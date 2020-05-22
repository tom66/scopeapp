"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math
sys.path.append('..')
import Utils # from parent directory

import ZynqScope.Standard4chAFE as AFE # For now, we import the standard 4ch AFE as the only supported AFE
import ZynqScope.ZynqSPI, ZynqScope.ZynqCommands

import multiprocessing

DEFAULT_ZYNQ_PING_RATE = 50

STATE_ZYNQ_NOT_READY = 0
STATE_ZYNQ_IDLE = 1

ZYNQ_SAMPLE_WORD_SIZE = 8

# Supported timebases
"""
timebase_options = [1e-9, 2e-9, 5e-9, 10e-9, 20e-9, 50e-9, 100e-9, 200e-9, 500e-9, 
                    1e-6, 2e-6, 5e-6, 10e-6, 20e-6, 50e-6, 100e-6, 200e-6, 500e-6, 
                    1e-3, 2e-3, 5e-3, 10e-3, 20e-3, 50e-3, 100e-3, 200e-3, 500e-3, 
                    1,    2,    5,    10,    20,    50,    100]
""" 

# Timebase options reduced until we have a variable sample discarder on the Zynq                
timebase_options = [1e-9, 2e-9, 5e-9, 10e-9, 20e-9, 50e-9, 100e-9, 200e-9, 500e-9, 
                    1e-6, 2e-6, 5e-6, 10e-6, 20e-6, 50e-6, 100e-6, 200e-6, 500e-6, 
                    1e-3, 2e-3, 5e-3, 10e-3, 20e-3, 50e-3, 100e-3]

class ZynqScopeParameterRangeError(ValueError): pass

class ZynqScopeSimpleCommand(object):
    def __init__(self, cmd_name, flush, *args, **kwargs):
        assert(type(self.cmd_name) == str)
        self.cmd_name = cmd_name
        self.flush = flush
        self.args = args
        self.kwargs = kwargs

class ZynqScopeGetStatus(object): pass
 
class ZynqScopeTimebaseOption(object):
    timebase_div = 0
    timebase_span = 0
    timebase_span_actual = 0
    memory_auto = 0
    sample_rate_auto = None
    sample_rate_max = None
    interp = 0
    
    def __init__(self):
        pass
    
    def __repr__(self):
        #print("interp", self.interp, self.timebase_div, self.timebase_span, self.timebase_span_actual, self.memory_auto, self.memory_max, self.sample_rate_auto, self.sample_rate_max)
        return "<ZynqScopeTimebaseOption div=%s, span=%s, actual_span=%s, memory_auto=%s, " \
               "sample_rate_auto=%s, sample_rate_max=%s, interp=%d>" % \
            (Utils.unit_format_suffix_handle_exc(self.timebase_div, 's/div', precision=3), Utils.unit_format_suffix_handle_exc(self.timebase_span, 's', precision=3), \
             Utils.unit_format_suffix_handle_exc(self.timebase_span_actual, 's', precision=3), \
             Utils.unit_format_suffix_handle_exc(self.memory_auto, 'samp', precision=6), \
             Utils.unit_format_suffix_handle_exc(self.sample_rate_auto, 'samp s^-1', precision=3), Utils.unit_format_suffix_handle_exc(self.sample_rate_max, 'samp s^-1', precision=3), 
             self.interp)
        
class ZynqScopeSampleRateBehaviourModel(object): 
    """Encapsulating class for divider/PLL behaviour model.  The rates,
    dividers and frequency lists must be in descending order of resulting
    output frequency."""
    rates_lut = []
    rates = []
    adc_divider = []
    pll_frequency = []
    min_freq = 0
    
    def update(self):
        rates_list = []
        rates = []
        
        for freq in self.pll_frequency:
            for div in self.adc_divider:
                # Don't add entry if it already exists (within 1kHz)
                out_freq = self.calculate_clock_for_index(freq, div)
                
                if out_freq == None:
                    continue
                
                dupe = False
                
                for r in rates:
                    if (abs(out_freq - r)) < 1e3:
                        print(out_freq, r, "Duplicate!")
                        dupe = True
                        break
                
                if not dupe:
                    rates_list.append((out_freq, freq, div))
                    rates.append(out_freq)
        
        rates_list.sort(reverse=True, key=operator.itemgetter(0))
        self.rates = list(map(lambda x: x[0], rates_list))
        self.rates_lut = rates_list
        print(self.rates_lut)
   
    def calculate_clock_for_index(self, freq, div):
        """Returns clock in Hz"""
        f = freq / div
        if (f < self.min_freq):
            return None
        else:
            return (f * 1e6)

class ZynqScopeSampleRateBehaviourModel_8Bit(ZynqScopeSampleRateBehaviourModel): 
    adc_divider   = [1, 2, 4, 8]
    #pll_frequency = [1000, 900, 850, 800, 750, 700, 650, 600, 550, 500, 450, 400, 333.33333333, 250, 125, 62.5, 40] # in MHz
    pll_frequency = [1000, 750, 500, 400, 250, 200, 125, 100, 62.5, 50] # in MHz
    min_freq = 120

class ZynqScope(object):
    """
    The base ZynqScope object which handles the command and control interface
    with the Zynq SoC on the Scopy board.  This class also stores limits and 
    acquisition parameters, such as timebase settings.
    
    This does not handle any interfacing with the analog front end or specifics
    relating to the gain/attenuation/ADC multiplexing settings.
    """
    # A list of ZynqTimebaseOption entries filled from timebase_options
    timebase_settings = []

    # Memory depth range.  In future, we would retrieve the amount of DDR3 connected to the Zynq
    # to automatically infer these parameters.  In addition precision mode must also be considered,
    # when it is implemented.
    mem_depth_minimum = 128                 # 128 samples
    mem_depth_maximum = 209715200           # 200MB
    mem_depth_maximum_split = 100663296     # 96MB in split mode
    
    # Split transition point: below this point, two buffers are maintained to improve update rate.
    # Nominally set to 2.5us/div so anything below 2us/div is included
    split_transition_tb = 2.5e-6
    
    # Target display samples.  This is filled from the GL frontend.
    # Our acquisition must always target this in the fastest mode to get the best performance.
    display_samples_target = 2048
    
    # Number of horizontal divisions.  Affects the length of any given acquisition at a timebase.
    default_hdiv_span = 12
    
    # Desired acquisition framerate with trigger
    acq_framerate = 50
    
    # Desired acquisition proportion for the frame time.  This should be tweaked to determine
    # the maximum performance possible.  0.1 = 10% of the frame used for acquisition
    acq_frametime_frac = 0.1
    
    # Sample rate model.  Defines the dividers and clock rates available to the ADC and PLL.
    samprate_mdl = None
    
    # Next timebase and current timebase
    next_tb = None
    curr_tb = None
    
    def __init__(self, display_samples_target, default_hdiv_span):
        self.display_samples_target = display_samples_target
        self.default_hdiv_span = default_hdiv_span
        self.samprate_mdl = ZynqScopeSampleRateBehaviourModel_8Bit()
        self.samprate_mdl.update()
        self.init_timebases()
    
    def connect(self):
        self.zcmd = ZynqCommands.ZynqCommands()
    
    def calc_real_sample_rate_for_index(self, index):
        """Only supports 8-bit mode for now"""
        return (1e6 * self.sample_rates_8b_pll_freq[index]) / self.sample_rates_8b_adc_div[index]
    
    def init_timebases(self):
        self.timebase_settings = []
        print(self.samprate_mdl.rates)
        
        for tb in timebase_options:
            new_tb = ZynqScopeTimebaseOption()
            new_tb.timebase_div = tb
            new_tb.timebase_span = self.default_hdiv_span * tb
            new_tb.timebase_span_actual = new_tb.timebase_span
            new_tb.sample_rate_auto = self.samprate_mdl.rates[0]
            new_tb.sample_rate_max = self.samprate_mdl.rates[0]
            
            # Assume medium acquistion: sample at the fastest possible rate, memory depth equals 
            # acquisition length in this mode
            new_tb.memory_auto = self.samprate_mdl.rates[0] * new_tb.timebase_span
            new_tb.interp = self.display_samples_target / (new_tb.timebase_span_actual * self.samprate_mdl.rates[0])
            
            if new_tb.interp < 1:
                new_tb.interp = 1
            
            # Short acquisition: we capture a larger span and display only a reduced portion of it
            if new_tb.memory_auto < self.mem_depth_minimum:
                #print("minimum", self.mem_depth_minimum)
                new_tb.memory_auto = self.mem_depth_minimum
                new_tb.timebase_span_actual = new_tb.memory_auto * (1.0 / self.samprate_mdl.rates[0])
            else:
                # Long acquisition: if the number of acquired samples would exceed the maximum memory length
                # in non-split mode, we must reduce the actual sample rate to fit this in DDR3!
                if new_tb.memory_auto >= self.mem_depth_maximum:
                    # Find the best sample rate that does not exceed the maximum memory depth (start 
                    # from the highest sample rate and work down)
                    found = False
                    for rate in self.samprate_mdl.rates:
                        mem_depth = int(math.ceil(new_tb.timebase_span * rate))
                        #print("rate (MSa/s):", rate / 1e6, "mem_depth (MB):", mem_depth / 1e6, "ratio:", mem_depth / self.mem_depth_maximum, "n_waves:", self.calculate_nwaves())
                        if mem_depth < self.mem_depth_maximum:
                            # Adjust this memory depth to fill the whole memory (no point throwing data away!)
                            new_tb.memory_auto = self.mem_depth_maximum
                            new_tb.timebase_span_actual = self.mem_depth_maximum / rate
                            new_tb.sample_rate_auto = rate
                            new_tb.sample_rate_max = rate
                            found = True
                            break
                    
                    if not found:
                        raise ValueError("Unable to solve for timebase %r" % new_tb)
            
            #print(tb)
            print(new_tb, "nwaves:", self.calculate_nwaves(new_tb.timebase_span_actual))
            self.timebase_settings.append(new_tb)

    def get_supported_timebases(self):
        pass
    
    def set_next_timebase(self, timebase_index):
        pass
    
    def get_max_pre_trigger_time(self, buffer_size, sample_rate):
        """Return the maximum pre-trigger time for the given total memory 
        buffer size and sample rate."""
        return ((buffer_size - self.mem_depth_minimum) / sample_rate) * 0.5
    
    def calculate_nwaves(self, acq_time):
        """nwaves is the number of waveforms to be captured in one frame.  It is
        set to a maximum of 255, a minimum of 1, or X% of the frame time."""
        nwaves = math.floor(((1.0 / self.acq_framerate) * self.acq_frametime_frac) / acq_time)
        return int(max(1, min(255, nwaves)))
    
    def setup_for_timebase(self, pre_time=0, memory_depth=None):
        """
        Setup timebase parameters on the Zynq's acquisition controller for the
        currently set timebase parameters.
        
        A memory_depth of None will configure the instrument to use the fastest
        memory depth available.
        
        Increasing pre_time will extend the pre-trigger buffer for browsing past
        events.  Set to zero, it retains the default configuration.
        """
        tb = self.next_tb
        sample_rate = tb.sample_rate_auto
            
        if memory_depth == None:
            depth = tb.memory_auto
        else:
            raise NotImplementedError("non auto memory size unsupported") # handle this case too
        
        # Adjusting pre-trigger increases the size of the pre buffer and decreases the
        # size of the post buffer.  The post buffer reduces to nearly zero (but not exactly zero,
        # as that is unsupported) 
        max_pre_time = self.get_max_pre_trigger_time(depth, sample_rate)
        if max_pre_time < pre_time:
            raise ZynqScopeParameterRangeError("Pre-trigger 'delay' exceeds limits")
        
        # Default settings
        pre_size = depth / 2
        post_size = depth / 2
        
        if pre_size > 0:
            pre_memory = pre_time * sample_rate
            pre_size += pre_time
            post_size -= pre_time
        
        assert(post_size >= self.mem_depth_minimum)
        
        # Correct all buffers to be a multiple of the sample word
        pre_size += ZYNQ_SAMPLE_WORD_SIZE / 2
        post_size += ZYNQ_SAMPLE_WORD_SIZE / 2
        pre_size &= ZYNQ_SAMPLE_WORD_SIZE - 1
        post_size &= ZYNQ_SAMPLE_WORD_SIZE - 1
        
        # Compute the number of waves we want to acquire for each frame
        nwaves = self.calculate_nwaves((pre_size + post_size) * sample_rate)
        print(pre_size, post_size, nwaves)
        
        # Stop the current acquisition and set up a new acquisition.
        self.zcmd.stop_acquisition()
        self.zcmd.setup_triggered_acquisition(pre_size, post_size, nwaves, ZynqCommands.ACQ_MODE_8B_1CH)
            
class ZynqScopeSubprocess(multiprocessing.Process):
    """
    This 'task' manages the interface with the Zynq via a multiprocessing interface.
    It internally contains a ZynqScope interface and accepts commands via a command queue
    and emits state messages via a separate queue. 
    """
    state = STATE_ZYNQ_NOT_READY
    
    def __init__(self, event_queue, response_queue):
        self.evq = event_queue
        self.rsq = response_queue
        
        # we might want the capability to tune the period as time goes by
        self.ping_period = 1000.0 / DEFAULT_ZYNQ_PING_RATE
        self.ping_period_req = self.ping_period
        
    def run(self):
        """Runs periodically to check the status of the Zynq.  Presently set to ping at 50Hz,
        but this can be changed."""
        if state == STATE_ZYNQ_NOT_READY:
            # Well get ready then!
            self.zs = ZynqScope()
            self.zs.connect()
        elif state == STATE_ZYNQ_IDLE:
            # Process any commands in the queue
            self.queue_process()
        
        time.sleep(self.ping_period)
    
    def queue_process(self):
        """See what work there is to do."""
        msg = self.evq.get()
        
        if type(msg) is ZynqScopeSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqCommands interface
            # No response is generated.  This is used, e.g. to set trigger parameters.  If 'flush' bit is
            # set, then a flush command is also sent.
            getattr(self.zs.zcmd, msg.cmd_name)(*msg.args, **msg.kwargs)
            if msg.flush:
                self.zs.zcmd.flush()
        elif type(msg) is ZynqScopeGetAcqStatus:
            # Enquire scope acquisition status.  Returns a ZynqAcqStatus object.
            resp = self.zs.zcmd.acq_status()
            self.rsq.put(resp)
        elif type(msg) is ZynqScopeSendCompAcqStreamCommand:
            # Send a composite acquisition status command and return the response data.
            resp = self.zs.zcmd.comp_acq_control()
            self.rsp.put(resp)
    