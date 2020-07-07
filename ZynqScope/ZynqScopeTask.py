"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math, inspect, copy, time, spidev, pickle
import multiprocessing, ctypes, struct, statistics
from types import ModuleType

sys.path.append('..')
import Utils

import ZynqScope.ZynqScope as zs
import ZynqScope.ZynqCommands as zc

import ZynqScope.ArmwaveRenderEngine as awre

# Rawcam library
import ZynqScope.pirawcam.rawcam as rawcam

AFE = zs.AFE

DEFAULT_ZYNQ_TASK_RATE = 1000       # Run internal task at 1000Hz
DEFAULT_ACQUISITION_RATE = 40       # By default acquire data at xx Hz from Zynq

STATE_ZYNQ_NOT_READY = 0
STATE_ZYNQ_IDLE = 1

TSTATE_ACQ_IDLE = 0
TSTATE_ACQ_STOPPED = 1
TSTATE_ACQ_PREPARE_TO_START = 2
TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER = 3

ACQSTATE_RUNNING_WAIT = 0
ACQSTATE_RUNNING_TRIGD = 1
ACQSTATE_RUNNING_AUTO_TRIGD = 2
ACQSTATE_STOPPED = 3

RAWCAM_BITRATE = 0.4e9              # 300MHz, 2 lanes, DDR: 1.2Gbit/s
RAWCAM_OVERHEAD = 1.50              # 50% overhead (estimated)

ZYNQ_CSI_HEADER_SIZE = 512

ZST_TIMEOUT = 0.5

# Load debug logger
import logging
log = logging.getLogger()

class ZynqScopeTaskQueueCommand(object): pass
class ZynqScopeTaskQueueResponse(object): pass

class ZynqScopeRenderQueueEmptyException(Exception): pass

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
class ZynqScopeGetStats(ZynqScopeTaskQueueCommand): pass

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

class ZynqScopeStopAutoAcquisition(ZynqScopeTaskQueueCommand): pass

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

class ZynqScopeRenderPassXID(ZynqScopeTaskQueueCommand):
    def __init__(self, xid):
        self.xid = xid

class ZynqScopeRenderSetDrawDimensions(ZynqScopeTaskQueueCommand):
    def __init__(self, x, y, w, h):
        self.x = x
        self.y = y
        self.w = w
        self.h = h

class ZynqScopeInitTrigger(ZynqScopeTaskQueueCommand): pass

class ZynqScopeApplyTrigger(ZynqScopeTaskQueueCommand):
    def __init__(self, trig):
        self.trig = trig

class ZynqScopeApplyADCMapping(ZynqScopeTaskQueueCommand):
    def __init__(self, adc_map):
        self.adc_map = adc_map

class ZynqScopeAttributesResponse(ZynqScopeTaskQueueResponse): pass
class ZynqScopeNullResponse(ZynqScopeTaskQueueResponse): pass
class ZynqScopeStopCompleted(ZynqScopeTaskQueueResponse): pass

class ZynqScopeStats(ZynqScopeTaskQueueResponse):
    num_waves_sent = 0
    last_wave_rates = [0]
    last_frame_times = [1]

    def add_wave_rate(self, rate):
        log.info("wr:%.3f r:%s" % (rate, repr(self.last_wave_rates)))
        if len(self.last_wave_rates) > 10:
            self.last_wave_rates.pop(0)
        self.last_wave_rates.append(rate)

    def add_frame_time(self, td):
        if len(self.last_frame_times) > 10:
            self.last_frame_times.pop(0)
        self.last_frame_times.append(td)

    def get_average_wave_rate(self):
        log.info("%s" % repr(self.last_wave_rates))
        if len(self.last_wave_rates) == 0:
            return 0
        else:
            return statistics.mean(self.last_wave_rates)

    def get_average_frame_time(self):
        if len(self.last_frame_times) == 0:
            return 0
        else:
            return statistics.mean(self.last_frame_times)

    def get_average_frame_rate(self):
        if len(self.last_frame_times) == 0:
            return 0
        else:
            return 1.0 / statistics.mean(self.last_frame_times)

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

class ZynqScopeCSIPacketHeader(object):
    pass

class ZynqScopePicklableMemoryBuff(object): 
    def __init__(self, pirawcam_buff):
        self.mmal_ptr = pirawcam_buff.mmal_ptr
        self.data_ptr = pirawcam_buff.data_ptr
        self.length = pirawcam_buff.length
        self.flags = pirawcam_buff.flags
        self.pts = pirawcam_buff.pts
        self.header_struct = struct.Struct("QHHIIIIIII")
        self.health_struct = struct.Struct("QhHHHHHHHH") 
        self.csi_stats_struct = struct.Struct("III") 

    def __repr__(self):
        return "<ZynqScopePicklableMemoryBuff mmal_ptr=0x%08x data_ptr=0x%08x length=%d flags=0x%04x pts=%d>" % \
            (self.mmal_ptr, self.data_ptr, self.length, self.flags, self.pts)

    def __lt__(self, b):
        return b.pts < self.pts

    def get_memoryview(self):
        return rawcam.get_memoryview_from_buffer_params(self.data_ptr, self.length)

    def parse_header(self):
        resp = bytes(resp.buffers[0].get_memoryview()[0:1024])

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

    rengine = None

    def __init__(self, event_queue, response_queue, acq_response_queue, render_queue, shared_dict, zs_init_args):
        super(ZynqScopeSubprocess, self).__init__()
        
        self.evq = event_queue
        self.rsq = response_queue
        self.acq_response_queue = acq_response_queue
        self.render_queue = render_queue

        self.shared_dict = shared_dict
        self.zs_init_args = zs_init_args

        self.acq_state = TSTATE_ACQ_IDLE
        self.shared_dict['running_state'] = ACQSTATE_STOPPED
        self.shared_dict['connected'] = False
        self.shared_dict['render_to_mmap'] = False
        self.shared_dict['mmap_display'] = None
        self.shared_dict['params'] = zs.ZynqScopeCurrentParameters()
        self.shared_dict['timebase_settings'] = [None]

        self.stats = ZynqScopeStats()

        self.tlast = 0.0
        self.time_acqs = 0
        self.time_last_acq_log = 0
        
        # Prepare the render engine (in future we'll support other render targets)
        self.rengine = awre.ArmwaveRenderEngine()

        # we might want the capability to tune the period as time goes by
        self.task_period = 1.0 / DEFAULT_ZYNQ_TASK_RATE
        self.target_acq_period = 1.0 / DEFAULT_ACQUISITION_RATE
        
        log.info("ZynqScopeSubprocess __init__(): task_period=%2.6f, target_acq_period=%2.2f" % (self.task_period, self.target_acq_period))

    def process_header(self, resp):
        pass #log.critical("buffer: %r" % bytes(resp.buffers[0].get_memoryview()[0:512]))

    def do_render(self, resp):
        #log.info("start do_render")

        if self.shared_dict['render_to_mmap']:
            #log.critical("render_single_mmal()")
            self.rengine.render_single_mmal(resp.buffers[0].data_ptr + 512)  # 512 byte offset for header; header to be decoded later
        else:
            log.warn("Render inhibited as render_to_mmap is False")

        #log.info("end do_render")

    def run(self):
        """Runs periodically to check the status of the Zynq."""
        while True:
            if self.state == STATE_ZYNQ_NOT_READY:
                # Well get ready then!
                self.zs = zs.ZynqScope(*self.zs_init_args)
                if self.zs.connect():
                    self.state = STATE_ZYNQ_IDLE
                else:
                    raise RuntimeError("Unable to connect hardware resources")

                self.shared_dict['timebase_settings'] = self.zs.timebase_settings
                self.shared_dict['connected'] = True

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
            log.debug("ZynqScopeSimpleCommand: %r" % [msg, msg.args, msg.kwargs])
            getattr(self.zs, msg.cmd_name)(*msg.args, **msg.kwargs)
            
        elif typ is ZynqScopeStartAutoAcquisition:
            self.start_auto_acquisition()

        elif typ is ZynqScopeStopAutoAcquisition:
            self.stop_auto_acquisition()

        elif typ is ZynqScopeSyncAcquisitionSettings:
            self.zs.setup_for_timebase(0, None) # TODO: These parameters need to be filled in, too!
            
        elif typ is ZynqScopeGetAcqStatus:
            # Enquire scope acquisition status.  Returns a ZynqAcqStatus object.
            resp = self.zs.zcmd.acq_status()
            self.rsq.put(resp)
            
        elif typ is ZynqScopeGetAttributes:
            # Return a safed object copy of all scope parameters which can be accessed
            resp = ZynqScopeAttributesResponse()
            compress_class_attrs_for_response(resp, self.zs, exclude=[zc.ZynqCommands, rawcam.interface, ModuleType])
            #print(resp)
            self.rsq.put(resp)
            
        elif typ is ZynqScopeGetStats:
            # Return a safed object copy of all scope parameters which can be accessed
            self.rsq.put(self.stats)
            
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

        elif typ is ZynqScopeInitTrigger:
            log.info("ZynqScopeInitTrigger: connect trigger manager")
            self.zs.connect_trigger()

        elif typ is ZynqScopeApplyTrigger:
            log.info("ZynqScopeApplyTrigger: applying trigger %r" % msg)
            self.zs.trig_eng.set_config(msg.trig)
            log.info("Done")

        elif typ is ZynqScopeApplyADCMapping:
            log.info("ZynqScopeApplyADCMapping: applying ADC mapping %r" % msg)
            self.zs.set_adc_mapping(msg.adc_map)
            log.info("Done")

        elif typ is ZynqScopeRenderPassXID:
            log.info("ZynqScopeRenderPassXID: new XID %d" % (msg.xid))
            self.rengine.set_xid(msg.xid)

        elif typ is ZynqScopeRenderSetDrawDimensions:
            log.info("ZynqScopeRenderSetDrawDimensions: new dims (%d,%d,%d,%d)" % (msg.x, msg.y, msg.w, msg.h))
            self.rengine.set_draw_dims(msg.x, msg.y, msg.w, msg.h)

        else:
            if not isinstance(msg, ZynqScopeTaskQueueCommand):
                raise RuntimeError("Queue message not subclass of ZynqScopeTaskQueueCommand")
            else:
                raise RuntimeError("Unimplemented/unsupported task class: %r (type: %r)" % (msg, typ))
    
    def cleanup_rawcam_buffers(self):
        #log.info("Start cleanup")

        while len(self.buffers_freeable) > 0:
            #log.info("Start free entry")
            entry = self.buffers_freeable.pop()
            self.zs.rawcam_buffer_free_friendly(entry)
            del entry
            #log.info("Deleted entry")

        self.buffers_working = []
        #log.info("Done cleanup, list length F:%d W:%d" % (len(self.buffers_freeable), len(self.buffers_working)))

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
        self.rengine.set_target_dimensions(1216, 256)  # fixed for now?
        self.rengine.fixup_timebase()
        #self.rengine.set_xid(None)

        self.zs.zcmd.flush()

        #self.zs.zcmd.setup_trigger_edge(zc.TRIG_CH_ADCSRC1, 0x7f, 0x10, zc.TRIG_EDGE_RISING) # write default trigger

        #self.zs.zcmd.start_acquisition()
        log.info("Writing period: %d us" % int(1e6 / DEFAULT_ACQUISITION_RATE))
        self.zs.zcmd.ac_stop()
        self.zs.zcmd.flush()
        self.zs.zcmd.ac_setup_acq_and_stream(1e6 / DEFAULT_ACQUISITION_RATE)
        self.zs.zcmd.ac_start()
        self.zs.zcmd.flush()
        self.time_last_acq = time.time()
        self.start_signal = True
        self.shared_dict['running_state'] = ACQSTATE_RUNNING_WAIT

        log.debug("start_auto_acquisition(): done")

    def stop_auto_acquisition(self):
        """Send the stop signal."""
        self.stop_signal = True

    def acquisition_tick(self):
        """Acquisition tick process.  Manages acquisition and SPI control."""
        # This function should be cleaned up: we need to use ZynqScope API where possible, 
        # and not send our own ZynqCommands...
        #log.debug("aq=%d" % self.acq_state)
        print_acq = False

        if (time.time() - self.tlast) > 1.0:
            print_acq = True
            log.info("acquisition_tick() iterating")
            self.tlast = time.time()

        self.shared_dict['params'] = self.zs.params

        if self.acq_state == TSTATE_ACQ_IDLE:
            if self.stop_signal:
                log.warn("Got stop while idle, ignorning")
                self.stop_signal = False

            if self.start_signal:
                self.acq_state = TSTATE_ACQ_PREPARE_TO_START
                self.start_signal = False
        
        elif self.acq_state == TSTATE_ACQ_PREPARE_TO_START:
            # Rawcam must be stopped.  If not this is an error
            if self.zs.rawcam_running:
                raise RuntimeError("rawcam not in stopped state")

            # Setup the rawcam interface preparing to acquire.  Save a copy of the acquisition
            # params before starting.
            self.acq_params = self.zs.params
            self.zs.rawcam_init()
            # TODO: Size needs to be dynamic...
            self.zs.rawcam_configure(self.acq_params.expected_buffer_size + ZYNQ_CSI_HEADER_SIZE)
            self.zs.rawcam_start()
            #self.zs.rawcam_disable()
            self.zs.rawcam_enable()
            time.sleep(0.001)  # Give rawcam a moment to start

            # tell the Zynq that we're ready to accept new data: READY goes low.
            self.zs.zynq_set_ready()

            # Wait, then start acquiring data
            self.acq_state = TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER

        elif self.acq_state == TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER:
            # Stop, if we get a signal
            if self.stop_signal:
                self._handle_stop()
            else:
                # Acknowledge any pending packet
                self.cleanup_rawcam_buffers()
                #log.info("Now waiting for Zynq to ack")

                if self.zs.zynq_acknowledge_if_pending():
                    #log.info("Zynq has packet; try to read it...")

                    while len(self.buffers_working) < self.zs.rawcam_buffer_dims[2]:
                        while self.zs.rawcam_get_buffer_count() > 0: 
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

                            #self.stats.num_waves_sent += 1
                            self.rawcam_seq += 1

                            if self.last_pts != None:
                                us_delta = buff.pts - self.last_pts
                            else:
                                us_delta = 0
                            self.last_pts = buff.pts
                            #print("Buffer count: %d, size of list: %d (total %d), new buffer: %r, us_delta: %d" % (count, len(self.buffers_working), self.rawcam_seq, buff, us_delta))

                        if len(self.buffers_working) >= self.zs.rawcam_buffer_dims[2]:
                            self.zs.zynq_set_ready()

                            # Create the response and send it
                            resp = ZynqScopeAcquisitionResponse()
                            resp.time = time.time()
                            resp.buffers = self.buffers_working
                            #resp.status = self.acq_comp0_response['AcqStatus']
                            #self.acq_response_queue.put(resp)

                            #log.info("Try to render ...")
                            self.process_header(resp)
                            self.do_render(resp)

                            self.time_acqs += 1

                            td = (time.time() - self.time_last_acq_log) / self.time_acqs
                            #log.info("Last render %.2f ms, effective frame rate %.1f fps (%d waves/sec) (based on %d acqs)" \
                            #    % (td * 1000, 1.0 / td, (1.0 / td) * self.zs.params.nwaves, self.time_acqs))

                            self.last_nwaves =  (1.0 / td) * self.zs.params.nwaves
                            self.stats.add_wave_rate(self.last_nwaves)
                            self.stats.add_frame_time(td)
                            self.time_last_acq_log = time.time()
                            self.time_acqs = 0

                            #log.info("Done render")

                            #self.zs.rawcam_stop()
                            #self.acq_state = TSTATE_ACQ_IDLE
                            self.acq_state = TSTATE_ACQ_WAITING_FOR_CSI_TRANSFER

        else:
            log.warning("Unimplemented state")

    def _handle_stop(self):
        log.info("_handle_stop()")
        self.acq_state = TSTATE_ACQ_IDLE
        self.cleanup_rawcam_buffers()
        self.zs.rawcam_stop()
        self.zs.zcmd.stop_acquisition()
        self.stop_signal = False
        self.start_signal = False
        self.rsq.put(ZynqScopeStopCompleted())

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
        
        # Fill common request objects cache
        self.roc = {
            'ZynqScopeGetAttributes': ZynqScopeGetAttributes(),
            'ZynqScopeDieTask' : ZynqScopeDieTask(),
            'ZynqScopeSendCompAcqStreamCommand' : ZynqScopeSendCompAcqStreamCommand(0x0000),
            'ZynqScopeSimpleCommand_SetNextTimebase' : ZynqScopeSimpleCommand("set_next_timebase"),
            'ZynqScopeSimpleCommand_SetupForTimebase' : ZynqScopeSimpleCommand("setup_for_timebase"),
            'ZynqScopeRawcamConfigure' : ZynqScopeRawcamConfigure(0),
            'ZynqScopeRawcamStart' : ZynqScopeRawcamStart(),
            'ZynqScopeRawcamDequeueBuffer' : ZynqScopeRawcamDequeueBuffer(),
            'ZynqScopeRawcamStop' : ZynqScopeRawcamStop(),
            'ZynqScopeGetStats' : ZynqScopeGetStats(),
            'ZynqScopeStartAutoAcquisition' : ZynqScopeStartAutoAcquisition(None),
            'ZynqScopeStopAutoAcquisition' : ZynqScopeStopAutoAcquisition(),
            'ZynqScopeRenderSetupTargetDimensions' : ZynqScopeRenderSetupTargetDimensions(0, 0),
            'ZynqScopeRenderChangeChannelColour' : ZynqScopeRenderChangeChannelColour(0, None),
            'ZynqScopeRenderChangeChannelIntensity' : ZynqScopeRenderChangeChannelIntensity(0, 0),
            'ZynqScopeApplyADCMapping' : ZynqScopeApplyADCMapping(None),
            'ZynqScopeApplyTrigger' : ZynqScopeApplyTrigger(None),
            'ZynqScopeInitTrigger' : ZynqScopeInitTrigger(),
            'ZynqScopeRenderPassXID' : ZynqScopeRenderPassXID(0),
            'ZynqScopeRenderSetDrawDimensions' : ZynqScopeRenderSetDrawDimensions(0, 0, 0, 0)
        }
        
        self.attribs_cache = None
        self.acq_running = False
        self.stats = None
        self.last_stats = 0.0

        # Create task queues and manager then initialise process with these resources
        self.zs_init_args = zs_init_args
        self.target_dims = (0, 0)
        self.subtask_restarts = 0
        self.init_zynq_task()

    def init_zynq_task(self):
        self.evq = multiprocessing.Queue()
        self.rsq = multiprocessing.Queue()
        self.acq_resp = multiprocessing.Queue()
        self.render_queue = multiprocessing.Queue()
        self.shared_dict = multiprocessing.Manager().dict()

        self.zstask = ZynqScopeSubprocess(self.evq, self.rsq, self.acq_resp, self.render_queue, self.shared_dict, self.zs_init_args)
        self.status = zc.ZynqAcqStatus()
        self.rawcam_running = False

        # Initialise local rawcam task
        #rawcam.init()
    
    def get_stats(self):
        return self.stats

    def has_stats(self):
        return self.stats != None

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
    
    def get_attributes(self):
        return self.shared_dict['params']
    
    def update_stats(self):
        self.evq_cache('ZynqScopeGetStats')
        return self.rsq.get(True, ZST_TIMEOUT)

    def get_supported_timebases(self):
        return self.shared_dict['timebase_settings']

    def set_next_timebase_index(self, tb):
        log.info("Set next timebase %d" % int(tb))
        cmd = self.roc['ZynqScopeSimpleCommand_SetNextTimebase']
        cmd.args = (int(tb),)
        self.evq.put(cmd)
    
    def setup_trigger_edge(self, ch, level, hyst, edge):
        # OBSOLETE
        self.evq.put(ZynqScopeCmdsIfcSimpleCommand("setup_trigger_edge", True, (ch, level, hyst, edge)))
    
    def stop_acquisition(self):
        self.evq_cache('ZynqScopeStopAutoAcquisition')

        log.info("Wait for Stop...")

        # Wait for stop... up to ZST_TIMEOUT seconds
        try:
            resp = self.rsq.get(True, ZST_TIMEOUT)

            if type(resp) == ZynqScopeStopCompleted:
                log.info("Got stop")
                return True
        except Exception as e:
            log.warn("Stop failed?: %r" % e)
            return False
    
    def set_xid(self, xid):
        cmd = self.roc['ZynqScopeRenderPassXID']
        cmd.xid = xid
        self.evq.put(cmd)

    def set_draw_dims(self, x, y, w, h):
        cmd = self.roc['ZynqScopeRenderSetDrawDimensions']
        cmd.x = x
        cmd.y = y
        cmd.w = w
        cmd.h = h
        self.evq.put(cmd)

    def start_acquisition(self):
        log.debug("ZSTC: ZynqScopeStartAutoAcquisition")
        self.evq_cache('ZynqScopeStartAutoAcquisition')

        self.acq_running = True
        self.zstask.shared_dict['render_to_mmap'] = True

    def setup_render_dimensions(self, width, height):
        cmd = self.roc['ZynqScopeRenderSetupTargetDimensions']
        cmd.width = width
        cmd.height = height
        self.evq.put(cmd)

        log.info("host: setup_render_dimensions(%d,%d)" % (width, height))
        self.target_dims = (width, height)

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
        
    def apply_adc_mapping(self, adc_map):
        cmd = self.roc['ZynqScopeApplyADCMapping']
        cmd.adc_map = adc_map
        self.evq.put(cmd)

    def apply_trigger(self, trig):
        log.info("Packing ZynqScopeApplyTrigger")
        cmd = self.roc['ZynqScopeApplyTrigger']
        cmd.trig = trig
        self.evq.put(cmd)
        log.info("Done!")

    def get_render_from_queue(self):
        """Get a render from the queue; acquire it and return it. Raises ZynqScopeRenderQueueEmpty 
        if the queue has no buffers available."""
        if self.render_queue.qsize() == 0:
            raise ZynqScopeRenderQueueEmptyException("empty queue")

        item = self.render_queue.get()
        item[2].acquire()  # index 2 holds semaphore

        return item

    def release_render(self, render):
        """Release the buffer, freeing it for reuse."""
        render[2].release()

    def sync_to_real_world(self):
        # Sync to the real world includes:  
        #  - Sending timebase change.  
        #  - Clearing acquisition memory.  
        #  - Sending any relay/attenuation unit changes.
        #  - Sending any ADC configuration changes.
        log.debug("sync_to_real_world")
        self.evq_cache('ZynqScopeSimpleCommand_SetupForTimebase')
    
    def acquisition_tick(self):
        # Fetch the sub task statistics every 100ms
        log.warning("%.3f" % ((time.time() - self.last_stats)))

        if (time.time() - self.last_stats) > 0.1:
            log.critical("Updating stats")
            self.update_stats()
            self.last_stats = time.time()

        # Check if the subtask has crashed.  It shouldn't ... but if it does, restart it.
        if self.zstask.exitcode not in [0, None]:
            log.critical("ZynqScopeTask crashed with exit code: %r -- attempting to restart it" % self.zstask.exitcode)
            self.init_zynq_task()
            self.start_task()

            raise Utils.SystemUnstable("Acquisition task crash detected.  Restarting -- system may be unstable.")

            #if self.acq_running:
            log.critical("Restarting acquisition to pre-crash state (%r)" % self.target_dims)
            self.setup_render_dimensions(*self.target_dims)
            self.start_acquisition()

            self.subtask_restarts += 1

        if self.subtask_restarts > 20:
            raise RuntimeError("Sub-task keeps crashing.  Fix it!")

    def init_trigger(self):
        self.evq_cache('ZynqScopeInitTrigger')
