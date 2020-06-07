"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math, inspect, copy, time, spidev, pickle
import multiprocessing, ctypes
from types import ModuleType

import ZynqScope.ZynqScope as zs
import ZynqScope.ZynqCommands as zc

import ZynqScope.ArmwaveRenderEngine as awre

# Rawcam library
import ZynqScope.pirawcam.rawcam as rawcam

AFE = zs.AFE

DEFAULT_ZYNQ_TASK_RATE = 1000       # Run internal task at 1000Hz
DEFAULT_ACQUISITION_RATE = 50       # By default acquire data at 50Hz from Zynq

STATE_ZYNQ_NOT_READY = 0
STATE_ZYNQ_IDLE = 1

TSTATE_ACQ_IDLE = 0
TSTATE_ACQ_PREPARE_TO_START = 1
TSTATE_ACQ_PING_ZYNQ = 2
TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER = 3
TSTATE_ACQ_AUTO_WAIT = 4

ACQSTATE_RUNNING_WAIT = 0
ACQSTATE_RUNNING_TRIGD = 1
ACQSTATE_RUNNING_AUTO_TRIGD = 2
ACQSTATE_STOPPED = 3

RAWCAM_BITRATE = 0.4e9              # 300MHz, 2 lanes, DDR: 1.2Gbit/s
RAWCAM_OVERHEAD = 1.50              # 30% overhead (estimated)

# Load debug logger
import logging
log = logging.getLogger()

class ZynqScopeTaskQueueCommand(object): pass
class ZynqScopeTaskQueueResponse(object): pass

class ZynqScopeCmdsIfcSimpleCommand(ZynqScopeTaskQueueCommand):
    def __init__(self, cmd_name, flush, args=(), kwargs={}):
        assert(type(cmd_name) == str)
        self.cmd_name = cmd_name
        self.flush = flush
        self.args = args
        self.kwargs = kwargs

class ZynqScopeSimpleCommand(ZynqScopeTaskQueueCommand):
    def __init__(self, cmd_name, args=(), kwargs={}):
        assert(type(cmd_name) == str)
        self.cmd_name = cmd_name
        self.args = args
        self.kwargs = kwargs
        
class ZynqScopeSendCompAcqStreamCommand(ZynqScopeTaskQueueCommand):
    def __init__(self, flags):
        self.flags = flags

class ZynqScopeSyncAcquisitionSettings(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetStatus(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetAcqStatus(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetAttributes(ZynqScopeTaskQueueCommand): pass

class ZynqScopeRawcamConfigure(ZynqScopeTaskQueueCommand):
    def __init__(self, buffer_size):
        self.buffer_size = buffer_size

class ZynqScopeRawcamStart(ZynqScopeTaskQueueCommand): pass
class ZynqScopeRawcamStop(ZynqScopeTaskQueueCommand): pass
class ZynqScopeRawcamDequeueBuffer(ZynqScopeTaskQueueCommand): pass
class ZynqScopeDieTask(ZynqScopeTaskQueueCommand): pass

class ZynqScopeStartAutoAcquisition(ZynqScopeTaskQueueCommand): 
    def __init__(self, rate):
        self.rate = rate

class ZynqScopeAttributesResponse(ZynqScopeTaskQueueResponse): pass
class ZynqScopeNullResponse(ZynqScopeTaskQueueResponse): pass

class ZynqScopeRenderSetupTargetDimensions(ZynqScopeTaskQueueCommand): 
    def __init__(self, width, height):
        self.width = width
        self.height = height

class ZynqScopeRenderChangeChannelColour(ZynqScopeTaskQueueCommand): 
    def __init__(self, ch, colour):
        self.ch = ch
        self.colour = colour

class ZynqScopeRenderChangeChannelIntensity(ZynqScopeTaskQueueCommand): 
    def __init__(self, ch, ints):
        self.ch = ch
        self.ints = ints

class ZynqScopeAcqStats(object):
    num_waves_acqd = 0

class ZynqScopeAcqStatsSender(object):
    num_waves_sent = 0

def compress_class_attrs_for_response(resp, clas_, exclude=[]):
    #print("compress_class_attrs_for_response %r %r" % (resp, clas_))
    attrs = inspect.getmembers(clas_)
    for attr, value in attrs:
        if attr.startswith("__"):
            continue
        if not callable(value):
            if not type(value) in exclude:
                #print(attr, value, type(value))
                setattr(resp, attr, copy.copy(value))
            else:
                pass # print("excluding %s %r" % (attr, value))

class ZynqScopeAcquisitionResponse(object):
    buffers = []
    status = None
    time = 0.0

    def __repr__(self):
        return "<ZynqScopeAcquisitionResponse n_buffers=%d status=%r time=%f>" % (len(self.buffers), self.status, self.time)

class ZynqScopePicklableMemoryBuff(object): 
    def __init__(self, pirawcam_buff):
        self.mmal_ptr = pirawcam_buff.mmal_ptr
        self.data_ptr = pirawcam_buff.data_ptr
        self.length = pirawcam_buff.length
        self.flags = pirawcam_buff.flags
        self.pts = pirawcam_buff.pts

    def __repr__(self):
        return "<ZynqScopePicklableMemoryBuff mmal_ptr=0x%08x data_ptr=0x%08x length=%d flags=0x%04x pts=%d>" % \
            (self.mmal_ptr, self.data_ptr, self.length, self.flags, self.pts)

    def __lt__(self, b):
        return b.pts < self.pts

    def get_memoryview(self):
        return rawcam.get_memoryview_from_buffer_params(self.data_ptr, self.length)

    def dump_to_file(self, fn):
        fp = open(fn, "wb")
        mv = self.get_memoryview()
        b = mv.tobytes()
        #log.warning("bytes: %r len: %d" % (b, len(b)))
        fp.write(b)
        fp.close()

class ZynqScopeSubprocess(multiprocessing.Process):
    """
    This 'task' manages the interface with the Zynq via a multiprocessing interface.
    It internally contains a ZynqScope interface and accepts commands via a command queue
    and emits state messages via a separate queue. 
    """
    state = STATE_ZYNQ_NOT_READY
    die_req = False
    zs_init_args = None
    buffers_working = []
    buffers_freeable = []

    target_dimensions = (0, 0)

    stop_signal = False
    start_signal = False

    acq_comp0_response = None

    time_last_acq = 0.0         # Starting timestamp for rawcam transaction
    time_reqd_rawcam = 0.0      # Estimated time for rawcam transaction to complete
    target_acq_period = 0.0

    rawcam_seq = 0
    last_pts = None

    stats = ZynqScopeAcqStatsSender()

    rengine = None

    def __init__(self, event_queue, response_queue, acq_response_queue, render_lock, shared_dict, zs_init_args):
        super(ZynqScopeSubprocess, self).__init__()
        
        self.evq = event_queue
        self.rsq = response_queue
        self.acq_response_queue = acq_response_queue
        self.render_lock = render_lock

        # While we are stopped we acquire the semaphore.  It is only released once we have a buffer ready.
        self.render_lock.acquire()

        self.shared_dict = shared_dict
        self.zs_init_args = zs_init_args

        self.acq_state = TSTATE_ACQ_IDLE
        self.shared_dict['running_state'] = ACQSTATE_STOPPED
        self.shared_dict['render_to_mmap'] = False
        self.shared_dict['mmap_id'] = None
        self.shared_dict['mmap_length'] = 0

        self.stats.num_waves_sent = 0
        
        # Prepare the render engine (in future we'll support other render targets)
        self.rengine = awre.ArmwaveRenderEngine()

        # we might want the capability to tune the period as time goes by
        self.task_period = 1.0 / DEFAULT_ZYNQ_TASK_RATE
        self.target_acq_period = 1.0 / DEFAULT_ACQUISITION_RATE
        
        log.info("ZynqScopeSubprocess __init__(): task_period=%2.6f, target_acq_period=%2.2f" % (self.task_period, self.target_acq_period))

    def do_render(self, resp):
        if self.shared_dict['render_to_mmap']:
            log.critical("render from:    0x%08x" % resp.buffers[0].data_ptr)
            log.critical("render buffers: %s" % repr(resp.buffers))
            log.critical("zs_params:      %s" % repr(self.zs.params))

            mmap_id, mmap_length = self.rengine.render_single_mmal(resp.buffers[0].data_ptr)
            self.shared_dict['mmap_id'] = mmap_id
            self.shared_dict['mmap_length'] = mmap_length
            self.render_lock.release()
        else:
            log.warn("Render inhibited")

    def run(self):
        """Runs periodically to check the status of the Zynq.  Presently set to ping at 50Hz,
        but this can be changed."""
        while True:
            if self.state == STATE_ZYNQ_NOT_READY:
                # Well get ready then!
                self.zs = zs.ZynqScope(*self.zs_init_args)
                if self.zs.connect():
                    self.state = STATE_ZYNQ_IDLE
                else:
                    raise RuntimeError("Unable to connect hardware resources")
            elif self.state == STATE_ZYNQ_IDLE:
                # Process any commands in the queue
                while not self.evq.empty():
                    self.queue_process()

                # Process the acquisition tasks
                self.acquisition_tick()
            
            if self.die_req:
                self.die_cleanup()
                self.terminate()
                return False
            
            time.sleep(self.task_period)
        
    def queue_process(self):
        """See what work there is to do."""
        msg = self.evq.get()
        typ = type(msg)

        if typ is ZynqScopeCmdsIfcSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqCommands interface.
            # This is used, e.g. to set trigger parameters.  If 'flush' bit is set, then a flush 
            # command is also sent.
            getattr(self.zs.zcmd, msg.cmd_name)(*msg.args, **msg.kwargs) 
            if msg.flush:
                self.zs.zcmd.flush()
            
        elif typ is ZynqScopeSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqScope interface.
            # This is used, e.g. to set acquisition parameters.  
            log.debug("ZynqScopeSimpleCommand:", msg, msg.args, msg.kwargs)
            getattr(self.zs, msg.cmd_name)(*msg.args, **msg.kwargs)
            
        elif typ is ZynqScopeStartAutoAcquisition:
            self.start_auto_acquisition()

        elif typ is ZynqScopeSyncAcquisitionSettings:
            self.zs.setup_for_timebase(0, None) # TODO: These parameters need to be filled in, too!
            
        elif typ is ZynqScopeGetAcqStatus:
            # Enquire scope acquisition status.  Returns a ZynqAcqStatus object.
            self.rsq.put(resp)
            resp = self.zs.zcmd.acq_status()
            
        elif typ is ZynqScopeGetAttributes:
            # Return a safed object copy of all scope parameters which can be accessed
            resp = ZynqScopeAttributesResponse()
            compress_class_attrs_for_response(resp, self.zs, exclude=[zc.ZynqCommands, rawcam.interface, ModuleType])
            #print(resp)
            self.rsq.put(resp)
            
        elif typ is ZynqScopeSendCompAcqStreamCommand:
            # Send a composite acquisition status command and return the response data.
            resp = self.zs.zcmd.comp_acq_control(msg.flags)
            self.rsq.put(resp)
        
        elif typ is ZynqScopeRawcamConfigure:
            self.zs.rawcam_configure(msg.buffer_size)
            
        elif typ is ZynqScopeRawcamStart:
            self.zs.rawcam_start()
            
        elif typ is ZynqScopeRawcamDequeueBuffer:
            self.rsq.put(self.zs.rawcam_get_buffer())
            
        elif typ is ZynqScopeRawcamStop:
            self.zs.rawcam_stop()
            
        elif typ is ZynqScopeDieTask:
            log.warning("ZynqScopeSubprocess: DieTask received")
            self.die_req = True

        elif typ is ZynqScopeRenderSetupTargetDimensions:
            #log.info("ZynqScopeRenderSetupTargetDimensions: setting dimensions %d x %d" % (msg.width, msg.height))
            self.target_dimensions = (msg.width, msg.height)
            # we really need to stop the render engine and re-initialise it here...
            
        elif typ is ZynqScopeRenderChangeChannelIntensity:
            log.info("ZynqScopeRenderChangeChannelIntensity: setting channel %d intensity to %.2f" % (msg.ch, msg.ints))
            self.rengine.set_channel_brightness(msg.ch, msg.ints)

        elif typ is ZynqScopeRenderChangeChannelColour:
            log.info("ZynqScopeRenderChangeChannelColour: setting channel %d colour to %s" % (msg.ch, repr(msg.colour)))
            self.rengine.set_channel_colour(msg.ch, msg.colour)

        else:
            if not isinstance(msg, ZynqScopeTaskQueueCommand):
                raise RuntimeError("Queue message not subclass of ZynqScopeTaskQueueCommand")
            else:
                raise RuntimeError("Unimplemented/unsupported task class: %r (type: %r)" % (msg, typ))
    
    def cleanup_rawcam_buffers(self):
        while len(self.buffers_freeable) > 0:
            self.zs.rawcam_buffer_free_friendly(self.buffers_freeable.pop())
        self.buffers_working = []

    def start_auto_acquisition(self):
        """Start automatic acquisition (i.e. continuous running as opposed to single shot.)
        The current acquisition is stopped and the acquisition configuration is loaded into the Zynq.
        Then the acquisition is started and result buffers will be streamed via the response queue.
        Note that auto in this context refers to the acquisition control being autonomous; it does
        not relate to the AUTO trigger mode."""
        log.debug("start_auto_acquisition(): entry")

        if self.acq_state != TSTATE_ACQ_IDLE:
            # We need to halt the state machine first... 
            self.stop_signal = True
            self.start_signal = False

            # We might need some timeout logic here if the state machine locks up for any reason
            while self.acq_state != TSTATE_ACQ_IDLE:
                log.debug("start_auto_acquisition(): waiting for IDLE %d ..." % self.acq_state)
                self.acquisition_tick()

        self.zs.setup_for_timebase()

        # prepare the render 
        self.rengine.update_wave_params(0, self.zs.params.memory_depth, self.zs.params.nwaves, self.zs.params.memory_depth)
        self.rengine.set_target_dimensions(*self.target_dimensions)

        self.zs.zcmd.flush()
        self.zs.zcmd.setup_trigger_edge(zc.TRIG_CH_ADCSRC1, 0x7f, 0x10, zc.TRIG_EDGE_RISING) # write default trigger
        self.zs.zcmd.start_acquisition()
        self.zs.zcmd.flush()
        self.time_last_acq = time.time()
        self.start_signal = True
        self.shared_dict['running_state'] = ACQSTATE_RUNNING_WAIT

        log.debug("start_auto_acquisition(): done")

    def acquisition_tick(self):
        """Acquisition tick process.  Manages acquisition and SPI control."""
        # This function should be cleaned up: we need to use ZynqScope API where possible, 
        # and not send our own ZynqCommands...
        #log.debug("aq=%d" % self.acq_state)

        if self.acq_state == TSTATE_ACQ_PREPARE_TO_START:
            # Stop, if we get a signal
            if self.stop_signal:
                self.acq_state = TSTATE_ACQ_IDLE
            else:
                # Rawcam must be stopped.  If not this is an error
                if self.zs.rawcam_running:
                    raise RuntimeError("rawcam not in stopped state")

                # Setup the rawcam interface preparing to acquire.  Save a copy of the acquisition
                # params before starting.
                self.acq_params = self.zs.params
                self.zs.rawcam_init()
                self.zs.rawcam_configure(self.acq_params.expected_buffer_size)
                self.zs.rawcam_start()
                #self.zs.rawcam_disable()
                self.zs.rawcam_enable()
                time.sleep(0.001)  # Give rawcam a moment to start

                # Wait, then start acquiring data
                self.acq_state = TSTATE_ACQ_AUTO_WAIT

        elif self.acq_state == TSTATE_ACQ_PING_ZYNQ:
            # Try to acquire the render lock
            self.render_lock.acquire()
            
            # Stop, if we get a signal
            if self.stop_signal:
                self.acq_state = TSTATE_ACQ_IDLE
            else:
                # Send message to Zynq to stop the current acquisition (either the first acquisition started
                # in start_auto_acquisition, or restared by this function) and return the status of it.  If 
                # that acquisition has more than zero waves, the waves will be streamed out via CSI bus.  
                # The Zynq function currently doesn't handle cases other than full waves or no waves yet; WIP.
                flags = zc.COMP0_ACQ_STOP | zc.COMP0_ACQ_GET_STATUS | zc.COMP0_ACQ_REWIND | \
                        zc.COMP0_ACQ_START_RESET_FIFO | zc.COMP0_CSI_TRANSFER_WAVES

                # if double-buffer acquisition is set then we want to swap lists on each Comp0 command
                if self.acq_params.flags & zc.ACQ_MODE_DOUBLE_BUFFER:
                    flags |= zc.COMP0_ACQ_SWAP_ACQ_LISTS

                #self.zs.rawcam_debug()
                self.acq_comp0_response = self.zs.zcmd.comp_acq_control(flags)
                self.time_last_acq = time.time()

                self.time_reqd_rawcam = (self.zs.rawcam_buffer_dims[1] * 8) / RAWCAM_BITRATE
                self.time_reqd_rawcam *= RAWCAM_OVERHEAD

                # Does Zynq have enough data for us?
                if self.acq_comp0_response['AcqStatus'].num_acq == 0:
                    # No acquisitions.  Maybe no trigger.  Go back to AUTO_WAIT.
                    self.zs.rawcam_stop()
                    self.acq_state = TSTATE_ACQ_AUTO_WAIT
                else:
                    self.acq_state = TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER
                    self.shared_dict['running_state'] = ACQSTATE_RUNNING_TRIGD

        elif self.acq_state == TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER:
            # Stop, if we get a signal
            if self.stop_signal:
                self.acq_state = TSTATE_ACQ_IDLE
                self.cleanup_rawcam_buffers()
                self.zs.rawcam_stop()
                self.zcmd.stop_acquisition()
            else:
                while self.zs.rawcam_get_buffer_count() > 0: #>= self.zs.rawcam_buffer_dims[2]:
                    # Dequeue this buffer and record the pointer so we can free this later
                    count = self.zs.rawcam_get_buffer_count()
                    fr_buffer = self.zs.rawcam_buffer_get_friendly()
                    buff = ZynqScopePicklableMemoryBuff(fr_buffer)

                    # hack
                    if buff.length == 0:
                        buff.length = self.zs.rawcam_buffer_dims[3]

                    self.buffers_working.append(buff)
                    self.buffers_freeable.append(fr_buffer)

                    #buff.dump_to_file("rxtest/sender%d.bin" % self.stats.num_waves_sent)

                    self.stats.num_waves_sent += 1
                    self.rawcam_seq += 1

                    if self.last_pts != None:
                        us_delta = buff.pts - self.last_pts
                    else:
                        us_delta = 0
                    self.last_pts = buff.pts
                    #print("Buffer count: %d, size of list: %d (total %d), new buffer: %r, us_delta: %d" % (count, len(self.buffers_working), self.rawcam_seq, buff, us_delta))

                if len(self.buffers_working) >= self.zs.rawcam_buffer_dims[2]:
                    # Create the response and send it
                    resp = ZynqScopeAcquisitionResponse()
                    resp.time = time.time()
                    resp.buffers = self.buffers_working
                    resp.status = self.acq_comp0_response['AcqStatus']
                    self.acq_response_queue.put(resp)
                    self.do_render(resp)
                    #self.zs.rawcam_stop()
                    #self.acq_state = TSTATE_ACQ_IDLE
                    self.acq_state = TSTATE_ACQ_AUTO_WAIT
                else:
                    pass 
                    #if (time.time() - self.time_last_acq) > self.time_reqd_rawcam:
                    #    print("Rawcam time up (%.4f s), let's ask for more." % self.time_reqd_rawcam)
                    #    self.zs.rawcam_flush() # Let's try and get some more, mkay?

                # Wait for the acquisition time to be reached for timeout purposes
                # If this happens it's bad.  We want to reduce these occurrences to zero.
                if (time.time() - self.time_last_acq) > self.target_acq_period:
                    log.warning("Timeout trying to get CSI buffers from Zynq/rawcam; let's try again")
                    self.cleanup_rawcam_buffers()
                    self.acq_state = TSTATE_ACQ_PING_ZYNQ

        elif self.acq_state == TSTATE_ACQ_AUTO_WAIT:
            # Stop, if we get a signal
            if self.stop_signal:
                self.acq_state = TSTATE_ACQ_IDLE
                self.zcmd.stop_acquisition()
                # Do we need to cleanup??
            else:
                # Wait for the acquisition time to be reached before gathering data
                if (time.time() - self.time_last_acq) > self.target_acq_period:
                    #log.debug("TimesUp!")
                    self.cleanup_rawcam_buffers()
                    self.acq_state = TSTATE_ACQ_PING_ZYNQ

        elif self.acq_state == TSTATE_ACQ_IDLE:
            if self.start_signal:
                # Stop the rawcam and free all buffers
                #self.cleanup_rawcam_buffers()
                #self.zs.rawcam_stop()
                self.zs.rawcam_disable()
                self.acq_state = TSTATE_ACQ_PREPARE_TO_START
        
        else:
            log.debug("Idle--not running")

    def die_cleanup(self):
        """Stub - to be fleshed out later."""
        return
            
class ZynqScopeTaskController(object):
    """
    Container class that wraps the ZynqScopeSubprocess module and provides a convenient
    interface.
    """
    def __init__(self, zs_init_args):
        log.info("ZynqScopeTaskController: __init__")

        # Create task queues and manager then initialise process with these resources
        self.evq = multiprocessing.Queue()
        self.rsq = multiprocessing.Queue()
        self.acq_resp = multiprocessing.Queue()
        self.shared_dict = multiprocessing.Manager().dict()
        self.render_lock = multiprocessing.Semaphore()

        self.zstask = ZynqScopeSubprocess(self.evq, self.rsq, self.acq_resp, self.render_lock, self.shared_dict, zs_init_args)
        self.status = zc.ZynqAcqStatus()
        self.rawcam_running = False

        self.acqstat = ZynqScopeAcqStats()
        self.acqstat.num_waves_acqd = 0

        # Initialise local rawcam task
        #rawcam.init()
        
        # Fill common request objects cache
        self.roc = {
            'ZynqScopeGetAttributes': ZynqScopeGetAttributes(),
            'ZynqScopeDieTask' : ZynqScopeDieTask(),
            'ZynqScopeSendCompAcqStreamCommand' : ZynqScopeSendCompAcqStreamCommand(0x0000),
            'ZynqScopeSimpleCommand_SetupForTimebase' : ZynqScopeSimpleCommand("setup_for_timebase"),
            'ZynqScopeRawcamConfigure' : ZynqScopeRawcamConfigure(0),
            'ZynqScopeRawcamStart' : ZynqScopeRawcamStart(),
            'ZynqScopeRawcamDequeueBuffer' : ZynqScopeRawcamDequeueBuffer(),
            'ZynqScopeRawcamStop' : ZynqScopeRawcamStop(),
            'ZynqScopeStartAutoAcquisition' : ZynqScopeStartAutoAcquisition(None),
            'ZynqScopeRenderSetupTargetDimensions' : ZynqScopeRenderSetupTargetDimensions(0, 0),
            'ZynqScopeRenderChangeChannelColour' : ZynqScopeRenderChangeChannelColour(0, None),
            'ZynqScopeRenderChangeChannelIntensity' : ZynqScopeRenderChangeChannelIntensity(0, 0)
        }
        
        # Cache for last fetched attributes
        self.attribs_cache = None
    
    def set_render_lock(self):
        self.render_lock.set()

    def evq_cache(self, key):
        """Pack a cached message quickly into the queue for the subprocess."""
        self.evq.put(self.roc[key])

    def start_task(self):
        self.zstask.start()
        
    def stop_task(self):
        # Send kill request, wait 200ms then force termination
        self.evq_cache('ZynqScopeDieTask')
        time.sleep(0.2)
        self.zstask.kill()
    
    def get_attributes_cache(self):
        if self.attribs_cache == None:
            self.get_attributes()
        return self.attribs_cache
    
    def get_attributes(self):
        self.evq_cache('ZynqScopeGetAttributes')
        resp = self.rsq.get()

        #print("get_attributes response:", resp)
        self.attribs_cache = resp
        return resp
    
    def get_supported_timebases(self):
        attrs = self.get_attributes()
        return attrs.timebase_settings

    def set_next_timebase_index(self, tb):
        cmd = self.roc['ZynqScopeSimpleCommand_SetupForTimebase']
        cmd.args = (int(tb),)
        self.evq.put(cmd)
    
    def setup_trigger_edge(self, ch, level, hyst, edge):
        self.evq.put(ZynqScopeCmdsIfcSimpleCommand("setup_trigger_edge", True, (ch, level, hyst, edge)))
    
    def stop_acquisition(self):
        pass
    
    def start_acquisition(self):
        log.debug("ZSTC: ZynqScopeStartAutoAcquisition")
        self.evq_cache('ZynqScopeStartAutoAcquisition')

        # for now, set this
        self.zstask.shared_dict['render_to_mmap'] = True
    
    def setup_render_dimensions(self, width, height):
        cmd = self.roc['ZynqScopeRenderSetupTargetDimensions']
        cmd.width = width
        cmd.height = height
        self.evq.put(cmd)

    def setup_render_channel_colour(self, idx, colour_tuple):
        cmd = self.roc['ZynqScopeRenderChangeChannelColour']
        cmd.ch = idx
        cmd.colour = colour_tuple
        self.evq.put(cmd)

    def setup_render_channel_intensity(self, idx, intensity):
        cmd = self.roc['ZynqScopeRenderChangeChannelIntensity']
        cmd.ch = idx
        cmd.ints = intensity
        self.evq.put(cmd)

    def get_render_mmap_id(self):
        return self.zstask.shared_dict['mmap_id']

    def get_render_mmap_length(self):
        return self.zstask.shared_dict['mmap_length']

    def acquire_render_lock(self):
        return self.render_lock.acquire(False)

    def release_render_lock(self):
        return self.render_lock.release()

    def sync_to_real_world(self):
        # Sync to the real world includes:  
        #  - Sending timebase change.  
        #  - Clearing acquisition memory.  
        #  - Sending any relay/attenuation unit changes.
        #  - Sending any ADC configuration changes.
        log.debug("sync_to_real_world")
        self.evq_cache('ZynqScopeSimpleCommand_SetupForTimebase')
    
    def acquisition_tick(self):
        pass
        """
        while not self.acq_resp.empty():
            resp = self.acq_resp.get()
            #log.debug("Got AcqResponse: %r" % resp)
            f = open("test.bin", "wb")
            bufs = sorted(resp.buffers)
            for b in bufs:
                log.debug("Buffer: %r" % b)
                log.debug("Deref:  %r" % b.get_memoryview())
                #b.dump_to_file("rxtest/test%d.bin" % self.acqstat.num_waves_acqd)
                self.acqstat.num_waves_acqd += 1
        """
