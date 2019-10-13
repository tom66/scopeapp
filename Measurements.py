"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import multiprocessing

class MeasResultState(object): 
    """Encompassing state for all measurement results."""
    pass
    
class MeasResultNotReady(MeasResultState): 
    """Measurement is not ready because it's not been computed yet"""
    pass

class MeasResultException(MeasResultState): 
    """Measurement is not available because an exception occurred"""
    def __init__(self, exc):
        self.exc = exc

class MeasResultNotValid(MeasResultState): 
    """Measurement is not valid based on data values/range selected"""
    pass

class MeasResultNoEdgeForPeriod(MeasResultState):
    """No edge could be found so period result not available"""
    pass

class MeasResultClipped(MeasResultState): 
    """Result available; but due to clipping it may be inaccurate."""
    pass

class MeasResultUncertain(MeasResultState):
    """Result available; but due to the small number of points or other conditions, it is below
    the desired level of certainty."""
    
class MeasResultValid(MeasResultState): 
    """Valid result available"""

class MeasDuplicateException(Exception): 
    """Exception raised if a duplicate measurement is attempted to be added"""
    pass

class MeasRequestStart(object):
    """Request start of measurement."""
    pass

class MeasRequestInfo(object):
    """Request info from measurement."""
    pass

class MeasResponseResultAvailable(object):
    pass
    
class MeasResponseInfo(object):
    def __init__(self, name, src_name, bounds):
        self.name = name
        self.src_name = src_name
        self.bounds = bounds

class MeasBoundsType(object):
    """A Measurement bounding superclass."""
    pass
    
class MeasBoundsGlobal(MeasBoundsType):
    """A Measurement bounding that includes all available data.  This is 
    presently the only available bounding."""
    pass
    
class Measurement(multiprocessing.Process):
    """
    Base class for handling a Measurement - implemented as a child process.
    """
    _result = None
    _state = MeasResultNotReady()
    _conn_rx, _conn_tx = (None, None)
    
    def __init__(self, pipe, src_name, bounds):
       self._conn_rx, self._conn_tx = pipe
       self._src_name = src_name
       self._bounds = bounds
    
    def _get_name(self):
        return "Measurement on %s" % self.src_name
    
    def _measurement_task(self):
        """This function should be overridden by any child Measurement.  It 
        will implement the measurement and place the result in the result member.
        The default Measurement result is to return 0.0 and MeasResultNotValid."""
        self._result = 0.0
        self._state = MeasResultNotValid()
    
    def run(self):
        # Receive messages on _conn_rx and respond to them.  Block while waiting 
        # for messages.
        packet = self._conn_rx.recv()

        if isinstance(packet, MeasRequestStart):
            try:
                self._measurement_task()
            except Exception as e:
                self._result = float('NaN')
                self._state = MeasResultException(e)
            
            self._conn_tx.send((MeasResponseResultAvailable, self._result, self._state))
            
        if isinstance(packet, MeasRequestInfo):
            self._conn_tx.send((MeasResponseInfo(self._get_name(), self.src_name))

class MeasurementController(object):
    """
    The MeasurementController handles processing of requested auto-measurement functions,
    which require analysis of the waveform data to determine the correct reading.  Individual
    measurements are created and scheduled using a threading mechanism.
    """
    
    """
    For each channel that has active measurements, we acquire a subset of channel data 
    (usually one waveform from the given timebase span) and store it as a multiprocessing
    RawArray.  The RawArray is shared between child measurement processes that each perform
    the respective measurement required.
    """
    channel_data = {}
    
    """Reference to the root ScopeController object."""
    _ctrl = None
    
    """Measurements that are currently working."""
    _working_meas = []
    
    """Resulting measurements."""
    _result_meas = {}
    
    def __init__(self, controller):
        self._ctrl = controller
    
    def add_measurement(self, source_name, meas_classname, data_bounds):
        """Add a measurement to be taken on every tick.  If the measurement 
        already exists a MeasDuplicateException is raised.  If successful,
        a Process for the measurement is created. """
        if self.find_measurement(source_name, meas_classname) is not None:
            raise MeasDuplicateException(_("Measurement already exists"))
    
        if not isinstance(data_bounds, MeasBoundsType):
            raise RuntimeError("data_bounds not a subclass of MeasBoundsType")
    
        pipe = multiprocessing.Pipe(False)
        meas = type(meas_classname)(pipe, source_name, data_bounds)
        meas.start()
        self._working_meas.append([meas, source_name, pipe, False])
    
    def remove_measurement(self, source_name, meas_classname):
        idx = self.find_measurement(source_name, meas_classname)
        if idx != None:
            self._working_meas.remove(self._working_meas[idx])
    
    def find_measurement(self, source_name, meas_classname):
        for meas in self._working_meas:
            if isinstance(meas[0], type(meas_classname)) and meas[1] == source_name:
                return meas
        
        return None
    
    def tick(self):
        """On a tick, all measurement child processes receive a request 
        for updated data, and results are made available in this class
        as each becomes available.  This function is non-blocking - but the
        results may not be available immediately."""
        for meas in self._working_meas:
            # Only send the request if we are not waiting on data from this measurement
            meas[3] ###? 
