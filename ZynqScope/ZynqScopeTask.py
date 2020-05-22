"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, operator, math, inspect, copy, time, spidev
import multiprocessing

import ZynqScope.ZynqScope as zs
import ZynqScope.ZynqCommands as zc

AFE = zs.AFE

DEFAULT_ZYNQ_TASK_RATE = 10000      # Run internal task at 10kHz
DEFAULT_ZYNQ_PING_MULT = 200        # Ping Zynq every 200 ticks for new data (~50Hz)

STATE_ZYNQ_NOT_READY = 0
STATE_ZYNQ_IDLE = 1

class ZynqScopeTaskQueueCommand(object): pass

class ZynqScopeCmdsIfcSimpleCommand(ZynqScopeTaskQueueCommand):
    def __init__(self, cmd_name, flush, *args, **kwargs):
        assert(type(self.cmd_name) == str)
        self.cmd_name = cmd_name
        self.flush = flush
        self.args = args
        self.kwargs = kwargs

class ZynqScopeSimpleCommand(ZynqScopeTaskQueueCommand):
    def __init__(self, cmd_name, *args, **kwargs):
        assert(type(self.cmd_name) == str)
        self.cmd_name = cmd_name
        self.args = args
        self.kwargs = kwargs

class ZynqScopeSyncAcquisitionSettings(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetStatus(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetAcqStatus(ZynqScopeTaskQueueCommand): pass
class ZynqScopeGetAttributes(ZynqScopeTaskQueueCommand): pass
class ZynqScopeSendCompAcqStreamCommand(ZynqScopeTaskQueueCommand): pass
class ZynqScopeDieTask(ZynqScopeTaskQueueCommand): pass

class ZynqScopeAttributesResponse(object): pass
class ZynqScopeNullResponse(object): pass

def compress_class_attrs_for_response(resp, clas_, exclude=[]):
    attrs = inspect.getmembers(clas_)
    for attr, value in attrs:
        if attr.startswith("__"):
            continue
        if not callable(value):
            if not type(value) in exclude:
                print(attr, value)
                setattr(resp, attr, copy.copy(value))
            else:
                print("excluding %s %r" % (attr, value))

class ZynqScopeSubprocess(multiprocessing.Process):
    """
    This 'task' manages the interface with the Zynq via a multiprocessing interface.
    It internally contains a ZynqScope interface and accepts commands via a command queue
    and emits state messages via a separate queue. 
    """
    state = STATE_ZYNQ_NOT_READY
    die_req = False
    zs_init_args = None
    
    def __init__(self, event_queue, response_queue, zs_init_args):
        super(ZynqScopeSubprocess, self).__init__()
        
        self.evq = event_queue
        self.rsq = response_queue
        self.zs_init_args = zs_init_args
        
        # we might want the capability to tune the period as time goes by
        self.task_period = 1000.0 / DEFAULT_ZYNQ_TASK_RATE
        self.ping_multiple = DEFAULT_ZYNQ_PING_MULT
        
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
                self.queue_process()
            
            if self.die_req:
                self.terminate()
                return False
            
            time.sleep(self.task_period)
        
    def queue_process(self):
        """See what work there is to do."""
        msg = self.evq.get()
        print(msg)
        
        if not isinstance(msg, ZynqScopeTaskQueueCommand):
            raise RuntimeError("Queue message not subclass of ZynqScopeTaskQueueCommand")
        
        if type(msg) is ZynqScopeCmdsIfcSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqCommands interface.
            # A Null response is generated.  This is used, e.g. to set trigger parameters.  If 'flush' bit is
            # set, then a flush command is also sent.
            getattr(self.zs.zcmd, msg.cmd_name)(*msg.args, **msg.kwargs)
            if msg.flush:
                self.zs.zcmd.flush()
            self.rsq.put(ZynqScopeNullResponse())
        elif type(msg) is ZynqScopeSimpleCommand:
            # This is a simple command: we call the relevant method on the ZynqScope interface.
            # A Null response is generated.  This is used, e.g. to set acquisition parameters.  
            getattr(self.zs.zcmd, msg.cmd_name)(*msg.args, **msg.kwargs)
            self.rsq.put(ZynqScopeNullResponse())
        elif type(msg) is ZynqScopeSyncAcquisitionSettings:
            self.zs.setup_for_timebase(0, None) # TODO: These parameters need to be filled in, too!
        elif type(msg) is ZynqScopeGetAcqStatus:
            # Enquire scope acquisition status.  Returns a ZynqAcqStatus object.
            resp = self.zs.zcmd.acq_status()
            self.rsq.put(resp)
        elif type(msg) is ZynqScopeGetAttributes:
            # Return a safed object copy of all scope parameters which can be accessed
            resp = ZynqScopeAttributesResponse()
            compress_class_attrs_for_response(resp, self.zs, exclude=[zc.ZynqCommands])
            print(resp)
            self.rsq.put(resp)
        elif type(msg) is ZynqScopeSendCompAcqStreamCommand:
            # Send a composite acquisition status command and return the response data.
            resp = self.zs.zcmd.comp_acq_control()
            self.rsq.put(resp)
        elif type(msg) is ZynqScopeDieTask:
            print("ZynqScopeSubprocess: DieTask received")
            self.die_req = True
            self.rsq.put(ZynqScopeNullResponse())
        else:
            self.rsq.put(ZynqScopeNullResponse())

class ZynqScopeTaskController():
    """
    Container class that wraps the ZynqScopeSubprocess module and provides a convenient
    interface.
    """
    def __init__(self, zs_init_args):
        self.evq = multiprocessing.Queue()
        self.rsq = multiprocessing.Queue()
        self.zstask = ZynqScopeSubprocess(self.evq, self.rsq, zs_init_args)
    
    def start_task(self):
        self.zstask.start()
        
    def stop_task(self):
        # Send kill request, wait 200ms then force termination
        self.evq.put(ZynqScopeDieTask())
        time.sleep(0.2)
        self.zstask.kill()
    
    def get_attributes(self):
        self.evq.put(ZynqScopeGetAttributes())
        resp = self.rsq.get()
        return resp
    
    def get_supported_timebases(self):
        attrs = self.get_attributes()
        return attrs.timebase_settings
    
    def stop_acquisition(self):
        self.evq.put(ZynqScopeSimpleCommand("stop_acquisition", True,))
    
    def start_acquisition(self):
        self.evq.put(ZynqScopeSimpleCommand("start_acquisition", True, (), {'reset_fifo' : 1}))
    
    def sync_to_real_world(self):
        # Sync to the real world includes:  
        #  - Sending timebase change.  
        #  - Clearing acquisition memory.  
        #  - Sending any relay/attenuation unit changes.
        #  - Sending any ADC configuration changes.
        self.evq.put(ZynqScopeSimpleCommand("setup_for_timebase", True,))
        