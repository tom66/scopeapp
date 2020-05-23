"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math, inspect, copy, time, spidev
import multiprocessing
from types import ModuleType

import ZynqScope.ZynqScope as zs
import ZynqScope.ZynqCommands as zc

# Rawcam library
import ZynqScope.pirawcam.rawcam as rawcam

AFE = zs.AFE

DEFAULT_ZYNQ_TASK_RATE = 100        # Run internal task at 100Hz
DEFAULT_ZYNQ_PING_MULT = 5          # Ping Zynq every 5 ticks for new data (~50Hz)

STATE_ZYNQ_NOT_READY = 0
STATE_ZYNQ_IDLE = 1

TSTATE_ACQ_NOT_RUNNING = 0
TSTATE_ACQ_RUNNING = 1

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
class ZynqScopeRawcamStart(ZynqScopeTaskQueueCommand): pass
class ZynqScopeDieTask(ZynqScopeTaskQueueCommand): pass

class ZynqScopeRawcamBufferContainer(ZynqScopeTaskQueueResponse):
    def __init__(self, rcb):
        self.rcb = rcb

class ZynqScopeAttributesResponse(ZynqScopeTaskQueueResponse): pass
class ZynqScopeNullResponse(ZynqScopeTaskQueueResponse): pass

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

class ZynqScopeSubprocess(multiprocessing.Process):
    """
    This 'task' manages the interface with the Zynq via a multiprocessing interface.
    It internally contains a ZynqScope interface and accepts commands via a command queue
    and emits state messages via a separate queue. 
    """
    state = STATE_ZYNQ_NOT_READY
    die_req = False
    zs_init_args = None
    
    def __init__(self, event_queue, response_queue, shared_dict, zs_init_args):
        super(ZynqScopeSubprocess, self).__init__()
        
        self.evq = event_queue
        self.rsq = response_queue
        self.shared_dict = shared_dict
        self.zs_init_args = zs_init_args
        
        # we might want the capability to tune the period as time goes by
        self.task_period = 1.0 / DEFAULT_ZYNQ_TASK_RATE
        self.ping_multiple = DEFAULT_ZYNQ_PING_MULT
        
        print("ZynqScopeSubprocess __init__(): task_period=%2.6f, ping_multiple=%2.2f" % (self.task_period, self.ping_multiple))
        
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
                    self.rawcam_tick()
            
            if self.die_req:
                self.terminate()
                return False
            
            time.sleep(self.task_period)
        
    def queue_process(self):
        """See what work there is to do."""
        msg = self.evq.get()
        #print("queue_process: %r" % msg)
        
        if not isinstance(msg, ZynqScopeTaskQueueCommand):
            raise RuntimeError("Queue message not subclass of ZynqScopeTaskQueueCommand")
        
        if type(msg) is ZynqScopeCmdsIfcSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqCommands interface.
            # This is used, e.g. to set trigger parameters.  If 'flush' bit is set, then a flush 
            # command is also sent.
            getattr(self.zs.zcmd, msg.cmd_name)(*msg.args, **msg.kwargs)
            if msg.flush:
                self.zs.zcmd.flush()
            
        elif type(msg) is ZynqScopeSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqScope interface.
            # This is used, e.g. to set acquisition parameters.  
            print("ZynqScopeSimpleCommand:", msg, msg.args, msg.kwargs)
            getattr(self.zs, msg.cmd_name)(*msg.args, **msg.kwargs)
            
        elif type(msg) is ZynqScopeSyncAcquisitionSettings:
            self.zs.setup_for_timebase(0, None) # TODO: These parameters need to be filled in, too!
            
        elif type(msg) is ZynqScopeGetAcqStatus:
            # Enquire scope acquisition status.  Returns a ZynqAcqStatus object.
            resp = self.zs.zcmd.acq_status()
            self.rsq.put(resp)
            
        elif type(msg) is ZynqScopeGetAttributes:
            # Return a safed object copy of all scope parameters which can be accessed
            resp = ZynqScopeAttributesResponse()
            compress_class_attrs_for_response(resp, self.zs, exclude=[zc.ZynqCommands, rawcam.interface, ModuleType])
            #print(resp)
            self.rsq.put(resp)
            
        elif type(msg) is ZynqScopeSendCompAcqStreamCommand:
            # Send a composite acquisition status command and return the response data.
            resp = self.zs.zcmd.comp_acq_control(msg.flags)
            self.rsq.put(resp)
        
        elif type(msg) is ZynqScopeRawcamStart:
            self.zs.rawcam_mod.start()
            
        elif type(msg) is ZynqScopeRawcamDequeueBuffer:
            self.rsq.put(self.zs.rawcam_mod.buffer_get())
            
        elif type(msg) is ZynqScopeDieTask:
            print("ZynqScopeSubprocess: DieTask received")
            self.die_req = True
            
        else:
            raise RuntimeError("Unimplemented/unsupported task class")
    
    def rawcam_tick(self):
        """Rawcam tick process.  Checks buffer state."""
        self.shared_dict['buffer_count'] = self.zs.rawcam_mod.buffer_count()
            
class ZynqScopeTaskController():
    """
    Container class that wraps the ZynqScopeSubprocess module and provides a convenient
    interface.
    """
    acq_state = TSTATE_ACQ_NOT_RUNNING
    
    def __init__(self, zs_init_args):
        # Create task queues and manager then initialise process with these resources
        self.evq = multiprocessing.Queue()
        self.rsq = multiprocessing.Queue()
        self.shared_dict = multiprocessing.Manager().dict()
        self.zstask = ZynqScopeSubprocess(self.evq, self.rsq, self.shared_dict, zs_init_args)
        
        # Fill common request objects cache
        self.roc = {
            'ZynqScopeGetAttributes': ZynqScopeGetAttributes(),
            'ZynqScopeDieTask' : ZynqScopeDieTask(),
            'ZynqScopeSendCompAcqStreamCommand' : ZynqScopeSendCompAcqStreamCommand(0x0000),
            'ZynqScopeSimpleCommand_SetupForTimebase' : ZynqScopeSimpleCommand("setup_for_timebase"),
        }
        
        # Cache for last fetched attributes
        self.attribs_cache = None
    
    def start_task(self):
        self.zstask.start()
        
    def stop_task(self):
        # Send kill request, wait 200ms then force termination
        self.evq.put(self.roc['ZynqScopeDieTask'])
        time.sleep(0.2)
        self.zstask.kill()
    
    def get_attributes_cache(self):
        return self.attribs_cache
    
    def get_attributes(self):
        self.evq.put(self.roc['ZynqScopeGetAttributes'])
        resp = self.rsq.get()
        #print("get_attributes response:", resp)
        self.attribs_cache = resp
        return resp
    
    def get_supported_timebases(self):
        attrs = self.get_attributes()
        return attrs.timebase_settings
    
    def set_next_timebase_index(self, tb):
        self.evq.put(ZynqScopeSimpleCommand("set_next_timebase", (int(tb),)))
    
    def stop_acquisition(self):
        self.evq.put(ZynqScopeCmdsIfcSimpleCommand("stop_acquisition", True,))
        self.acq_state = TSTATE_ACQ_NOT_RUNNING
    
    def start_acquisition(self):
        self.evq.put(ZynqScopeCmdsIfcSimpleCommand("start_acquisition", True, (), {'reset_fifo' : 1}))
        self.acq_state = TSTATE_ACQ_RUNNING
    
    def sync_to_real_world(self):
        # Sync to the real world includes:  
        #  - Sending timebase change.  
        #  - Clearing acquisition memory.  
        #  - Sending any relay/attenuation unit changes.
        #  - Sending any ADC configuration changes.
        print("sync_to_real_world")
        self.evq.put(self.roc['ZynqScopeSimpleCommand_SetupForTimebase'])
    
    def acquisition_tick(self):
        """Manages Zynq acquisition control."""
        self.get_attributes()
        
        if self.acq_state == TSTATE_ACQ_RUNNING:
            cmd = self.roc['ZynqScopeSendCompAcqStreamCommand']
            cmd.flags = zc.COMP0_ACQ_STOP | zc.COMP0_ACQ_GET_STATUS | zc.COMP0_ACQ_REWIND | zc.COMP0_ACQ_START_RESET_FIFO | \
                        zc.COMP0_CSI_TRANSFER_WAVES | zc.COMP0_SPI_RESP_CSI_SIZE
            
            # if double-buffer acquisition is set then we want to swap lists on each Comp0 command
            if self.attribs_cache.params.flags & zc.ACQ_MODE_DOUBLE_BUFFER:
                cmd.flags |= zc.COMP0_ACQ_SWAP_ACQ_LISTS
            
            print("cmd.flags 0x%04x" % cmd.flags)
            self.evq.put(cmd)
            
            print("buffer_count:", self.shared_dict['buffer_count'])
        else:
            print("Idle--not running")
    