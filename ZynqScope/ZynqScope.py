"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math

sys.path.append('..')
import Utils # from parent directory

import ZynqScope.Standard4chAFE as AFE # For now, we import the standard 4ch AFE as the only supported AFE
import ZynqScope.ZynqSPI, ZynqScope.ZynqCommands as zc

# Rawcam library
import ZynqScope.pirawcam.rawcam as rawcam

# Load debug logger
import logging
log = logging.getLogger()

ZYNQ_SAMPLE_WORD_SIZE = 8
ZYNQ_SAMPLE_WORD_CACHE_DIVISIBLE = 32

RAWCAM_LINE_SIZE = 2048
RAWCAM_MAX_BUFFER_HEIGHT = 2048
RAWCAM_MIN_SPARE_BUFFERS = 4

RAWCAM_IMAGE_ID = 0x2a
RAWCAM_WCT_HEADER = 0x0000

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

default_timebase = 12
                    
class ZynqScopeParameterRangeError(ValueError): pass

class ZynqScopeCurrentParameters(object): 
    sample_depth = 8
    memory_depth = 0
    sample_rate = 0
    nwaves = 0
    wave_rate = 0
    trigger_point = 0.5
    delay = 0
    flags = 0x0000
    expected_buffer_size = 0
    
    def __repr__(self):
        return "<ZynqScopeCurrentParameters sample_depth=%d bits, memory_depth=%s, sample_rate=%s, trigger_point=%2.1f%%, delay=%s>" % \
            (self.sample_depth, Utils.unit_format_suffix_handle_exc(self.memory_depth, 'pts', precision=2), \
            Utils.unit_format_suffix_handle_exc(self.sample_rate, 'Sa/s', precision=1), self.trigger_point * 100, \
            Utils.unit_format_suffix_handle_exc(self.delay, 's', precision=5))
 
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
    
    def get_div_value(self):
        return float(self.timebase_div)
    
    def __repr__(self):
        #print("interp", self.interp, self.timebase_div, self.timebase_span, self.timebase_span_actual, self.memory_auto, self.memory_max, self.sample_rate_auto, self.sample_rate_max)
        return "<ZynqScopeTimebaseOption div=%s, span=%s, actual_span=%s, memory_auto=%s, " \
               "sample_rate_auto=%s, sample_rate_max=%s, interp=%d>" % \
            (Utils.unit_format_suffix_handle_exc(self.timebase_div, 's/div', precision=3), Utils.unit_format_suffix_handle_exc(self.timebase_span, 's', precision=3), \
             Utils.unit_format_suffix_handle_exc(self.timebase_span_actual, 's', precision=3), \
             Utils.unit_format_suffix_handle_exc(self.memory_auto, 'pts', precision=6), \
             Utils.unit_format_suffix_handle_exc(self.sample_rate_auto, 'Sa/s', precision=3), Utils.unit_format_suffix_handle_exc(self.sample_rate_max, 'Sa/s', precision=3), 
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
                        #print(out_freq, r, "Duplicate!")
                        dupe = True
                        break
                
                if not dupe:
                    rates_list.append((out_freq, freq, div))
                    rates.append(out_freq)
        
        rates_list.sort(reverse=True, key=operator.itemgetter(0))
        self.rates = list(map(lambda x: x[0], rates_list))
        self.rates_lut = rates_list
        #print(self.rates_lut)
   
    def calculate_clock_for_index(self, freq, div):
        """Returns clock in Hz"""
        f = freq / div
        if (f < self.min_freq):
            return None
        else:
            return (f * 1e6)

class ZynqScopeSampleRateBehaviourModel_8Bit(ZynqScopeSampleRateBehaviourModel): 
    adc_divider   = [1, 2, 4, 8]
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
    mem_depth_minimum = 120                 # 120 samples in total for an acquisition
    mem_depth_minimum_pp = 16               # Minimum size for pre/post buffers individually (16 samples: two words of 8 samples)
    mem_depth_maximum = 200000000           # 200Mpts
    mem_depth_maximum_split = 100000000     # 100Mpts in split mode
    
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
    # the maximum performance possible.  
    acq_frametime_frac = 0.12
    
    # Sample rate model.  Defines the dividers and clock rates available to the ADC and PLL.
    samprate_mdl = None
    
    # Current parameters data set.  Can be passed back to the host process for UI purposes.
    params = ZynqScopeCurrentParameters()
    
    # Next timebase and current timebase
    next_tb = None
    next_memory_depth = None
    next_delay = 0
    curr_tb = None
    
    # Zynq command interface;  initialised by connect()
    zcmd = None
    
    # Rawcam interface
    rc = None
    rawcam_mod = None 
    rawcam_running = False
    rawcam_buffer_dims = (0, 0, 0)
    
    def __init__(self, display_samples_target, default_hdiv_span):
        # Set default parameters
        self.display_samples_target = display_samples_target
        self.default_hdiv_span = default_hdiv_span
    
    def connect(self):
        # Connect to the Zynq
        log.info("ZynqScope connect(): connecting to hardware")
        self.zcmd = zc.ZynqCommands()
        
        # Generate supported timebase configurations
        log.debug("ZynqScope connect(): generating timebases")
        self.samprate_mdl = ZynqScopeSampleRateBehaviourModel_8Bit()
        self.samprate_mdl.update()
        self.init_timebases()
        self.next_tb = self.timebase_settings[default_timebase]

        log.info("ZynqScope connect(): done initialisation")
        
        # Instead of blindly returning True we should check that the hardware is ready first...
        return True
    
    def rawcam_init(self):
        log.debug("ZynqScope rawcam_init(): setting up rawcam")

        self.rc = rawcam.init()
        rawcam.set_data_lanes(2)
        rawcam.set_image_id(RAWCAM_IMAGE_ID)
        rawcam.set_pack_mode(0)
        rawcam.set_unpack_mode(0)
        rawcam.set_unpack_mode(0)
        rawcam.set_encoding_fourcc(ord('G'), ord('R'), ord('B'), ord('G'))
        rawcam.set_zero_copy(1)
        rawcam.set_camera_num(1)

        log.debug("ZynqScope rawcam_init(): rawcam debug follows")
        rawcam.debug()

        # Configure CSI transmitter with rawcam parameters: image_id must match for successful reception
        self.zcmd.csi_setup_params(RAWCAM_WCT_HEADER, RAWCAM_IMAGE_ID)

    def rawcam_configure(self, buffer_size):
        """Configure the rawcam port for a specific buffer size."""
        lines = buffer_size // RAWCAM_LINE_SIZE

        if (buffer_size % RAWCAM_LINE_SIZE) != 0:
            lines += 1

        # max per-buffer size is RAWCAM_LINE_SIZE * RAWCAM_MAX_BUFFER_HEIGHT;
        # add extra buffers if needed
        buffer_max = RAWCAM_LINE_SIZE * RAWCAM_MAX_BUFFER_HEIGHT
        if (buffer_size > buffer_max):
            buffer_count = RAWCAM_MIN_SPARE_BUFFERS + (buffer_size // buffer_max)
            lines = RAWCAM_MAX_BUFFER_HEIGHT
        else:
            buffer_count = RAWCAM_MIN_SPARE_BUFFERS + 1

        # tuple members: number of lines in a buffer,  total buffer size,  number of true buffers,  per buffer byte size
        self.rawcam_buffer_dims = (\
            lines, buffer_size, buffer_count - RAWCAM_MIN_SPARE_BUFFERS, RAWCAM_LINE_SIZE * lines)

        log.debug("rawcam_config: lines_per_buffer:", lines, "buffer_size:", buffer_size, "buffer_max:", buffer_max, "num_buffers:", buffer_count)

        rawcam.set_buffer_num(buffer_count)
        #rawcam.set_buffer_num(8)
        rawcam.set_buffer_size(RAWCAM_LINE_SIZE * lines)
        rawcam.set_buffer_dimensions(RAWCAM_LINE_SIZE, lines)
        rawcam.debug()

    def rawcam_start(self):
        if self.rawcam_running:
            raise RuntimeError("Rawcam is already started, must stop before starting")
        else:
            log.debug("ZynqScope: rawcam_start()")
            rawcam.debug()
            rawcam.start()
            rawcam.debug()
            self.rawcam_running = True

    def rawcam_enable(self):
        rawcam.enable()

    def rawcam_disable(self):
        rawcam.disable()

    def rawcam_get_buffer_count(self):
        return rawcam.buffer_count()

    def rawcam_get_buffer(self):
        return rawcam.buffer_get()

    def rawcam_buffer_get_friendly(self):
        return rawcam.buffer_get_friendly()

    def rawcam_free_buffer(self, buffer):
        rawcam.buffer_free(buffer)

    def rawcam_buffer_free_friendly(self, friendly_buffer):
        rawcam.buffer_free_friendly(friendly_buffer)

    def rawcam_flush(self):
        rawcam.flush()

    def rawcam_debug(self):
        rawcam.debug()

    def rawcam_stop(self):
        if self.rawcam_running:
            log.debug("ZynqScope: rawcam_stop()")
            rawcam.stop()
            self.rawcam_running = False
        else:
            log.warning("ZynqScope: rawcam_stop() ignored - rawcam not running")

    def calc_real_sample_rate_for_index(self, index):
        """Only supports 8-bit mode for now"""
        return (1e6 * self.sample_rates_8b_pll_freq[index]) / self.sample_rates_8b_adc_div[index]
    
    def init_timebases(self):
        self.timebase_settings = []
        #print(self.samprate_mdl.rates)
        
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
            if new_tb.memory_auto < (self.mem_depth_minimum * 2):
                #print("minimum", self.mem_depth_minimum)
                new_tb.memory_auto = self.mem_depth_minimum * 2 # Double as we have a split pre/post buffer
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
            #print(new_tb, "nwaves:", self.calculate_nwaves(new_tb.timebase_span_actual))
            self.timebase_settings.append(new_tb)

    def get_supported_timebases(self): 
        """Returns a list of timebase settings in s/div units.  The index of each item
        is used to select the desired timebase later."""
        list_ = []
        for tb in self.timebase_settings:
            list_.append(tb.timebase_div)
        return list_
    
    def set_next_timebase(self, index):
        try:
            self.next_tb = self.timebase_settings[index]
        except IndexError:
            raise ZynqScopeParameterRangeError("Unsupported timebase setting %d" % index)
    
    def set_next_delay(self, delay):
        self.next_delay = delay
    
    def set_next_memory_depth(self, memory_depth):
        self.next_memory_depth = memory_depth
    
    def get_max_pre_trigger_time(self, buffer_size, sample_rate):
        """Return the maximum pre-trigger time for the given total memory 
        buffer size and sample rate."""
        return ((buffer_size - self.mem_depth_minimum_pp) / sample_rate) * 0.5
    
    def calculate_nwaves(self, acq_time):
        """nwaves is the number of waveforms to be captured in one frame.  It is
        set to a maximum of 255, a minimum of 1, or X% of the frame time."""
        #print("acq_time:", acq_time)
        nwaves = math.floor(((1.0 / self.acq_framerate) * self.acq_frametime_frac) / acq_time)
        return int(max(1, min(255, nwaves)))
    
    def setup_for_timebase(self):
        """
        Setup timebase parameters on the Zynq's acquisition controller for the
        currently set timebase parameters.
        """
        tb = self.next_tb
        sample_rate = tb.sample_rate_auto
        flags = 0x0000
            
        if self.next_memory_depth == None:
            depth = tb.memory_auto
        else:
            raise NotImplementedError("non auto memory size unsupported") # handle this case too at some point
        
        # Adjusting pre-trigger increases the size of the pre buffer and decreases the
        # size of the post buffer.  The post buffer reduces to nearly zero (but not exactly zero,
        # as that is unsupported).  Positive delay is not yet implemented. 
        if self.next_delay < 0:
            pre_time = -self.next_delay
        else:
            pre_time = 0
            
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
        
        pre_size = int(pre_size)
        post_size = int(post_size)
        
        #print("pre/post:", pre_size, post_size)
        assert(post_size >= self.mem_depth_minimum_pp)
        
        # Correct all buffers to be a multiple of a cache line.  The total buffer need only
        # be divisible by 32, but ensuring both pre and post buffers are is easier.
        pre_size += ZYNQ_SAMPLE_WORD_CACHE_DIVISIBLE - 1
        post_size += ZYNQ_SAMPLE_WORD_CACHE_DIVISIBLE - 1
        pre_size &= ~(ZYNQ_SAMPLE_WORD_CACHE_DIVISIBLE - 1)
        post_size &= ~(ZYNQ_SAMPLE_WORD_CACHE_DIVISIBLE - 1)
        
        # Compute the number of waves we want to acquire for each frame
        #print("params?:", pre_size + post_size, sample_rate)
        nwaves = self.calculate_nwaves((pre_size + post_size) * (1.0 / sample_rate))
        
        # Reduce nwaves if the allocation would exceed split or total memory limits (depending on which
        # is in effect).  Set split flag if we are in this mode.
        if tb.timebase_div <= self.split_transition_tb:
            max_memory = self.mem_depth_maximum_split
            flags |= zc.ACQ_MODE_DOUBLE_BUFFER
        else:
            max_memory = self.mem_depth_maximum
        
        if (nwaves * (pre_size + post_size)) > max_memory:
            nwaves = max_memory / (pre_size + post_size)
        
        #print(pre_size, post_size, nwaves)
        
        # Stop the current acquisition and set up a new acquisition.
        self.zcmd.stop_acquisition()
        self.zcmd.setup_triggered_acquisition(pre_size, post_size, nwaves, flags | zc.ACQ_MODE_8B_1CH)
        
        # Update the parameter set for user interface and the rest of the application.
        self.params.sample_depth = 8  # Fixed to 8-bit for now
        self.params.sample_rate = tb.sample_rate_auto
        self.params.memory_depth = pre_size + post_size
        
        if self.next_delay < 0:
            self.params.trigger_point = 1 - ((pre_size) / (pre_size + post_size))
        elif self.next_delay == 0:
            self.params.trigger_point = 0.5
        else:
            # positive delay not yet implemented
            self.params.trigger_point = 1.0
        
        self.params.acq_flags = flags
        self.params.nwaves = nwaves
        self.params.wave_rate = nwaves * self.acq_framerate
        self.params.delay = self.next_delay
        self.params.expected_buffer_size = self.params.nwaves * self.params.memory_depth
        self.curr_tb = self.next_tb

        log.debug("New acquisition parameters: %s" % repr(self.params))
    
        