"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import time, math

import ZynqScope.ZynqScope as zs
import ZynqScope.ZynqCommands as zc
import ZynqScope.ZynqScopeADCMapping as zsadcmap

EDGE_TYPES = {
    'RISE' : zc.TRIG_EDGE_RISING,
    'FALL' : zc.TRIG_EDGE_FALLING,
    'BOTH' : zc.TRIG_EDGE_BOTH
}

DEFAULT_CHANNEL_MAP = {
    'CH1': zc.TRIG_CH_ADCSRC1,
    'CH2': zc.TRIG_CH_ADCSRC2,
    'CH3': zc.TRIG_CH_ADCSRC3,
    'CH4': zc.TRIG_CH_ADCSRC4
}

class ZynqScopeTriggerSuperclass(object): 
    """Picklable superclass for the trigger configuration.  Designed to be passed
    via the multiprocessing queue."""
    def __init__(self):
        self._params_types = {}
        self._params_dict = {}

    def get_name(self):
        return "UNDEFINED"

    def get_parameters(self):
        return self._params_types

    def set_parameter(self, key, value):
        if key not in self._params_dict:
            raise NotImplementedError("Parameter not supported")
        self._params_dict[key] = value
        self._validate_params()

    def _validate_params(self):
        pass

    def commit(self, *params):
        raise NotImplementedError("Superclass not a valid trigger")

    def __repr__(self):
        return "<UndefinedTrigger>"

class ZynqScopeTriggerEdge(ZynqScopeTriggerSuperclass):
    def __init__(self): 
        super(ZynqScopeTriggerSuperclass, self).__init__()
        self._params_types = {'Channel'    : 'ChannelSelection',
                              'Level'      : 'VoltageLevel',
                              'Hysteresis' : 'VoltageLevel',
                              'Edge'       : 'EdgeType'}

    def get_name(self):
        return "SIMPLE_EDGE_TRIGGER"

    def commit(self, zcmd, adc_map, chan_map):
        level = self.adc_map.apply_map(self._params_dict['Level'], adc_mapping)
        hyst = self.adc_map.apply_map(self._params_dict['Hysteresis'])
        channel = self.chan_map[self._params_dict['Channel']]

        zcmd.setup_trigger_edge(channel, level, hyst, EDGE_TYPES[self._params_dict['EdgeType']])

    def __repr__(self):
        return "<EdgeTrigger Level=%.2f, Hyst=%.2f, Channel=%d, Edge=%s>" % \
            (self._params_dict['Level'], self._params_dict['Hysteresis'], self._params_dict['Channel'], self._params_dict['Edge'])

AVAILABLE_TRIGGERS = [
    ZynqScopeTriggerEdge
]

class ZynqScopeTriggerManager(object):
    def __init__(self):
        self.zs = None
        self.ch_map = [zc.TRIG_CH_ADCSRC1, zc.TRIG_CH_ADCSRC2, zc.TRIG_CH_ADCSRC3, zc.TRIG_CH_ADCSRC4]
        self.adc_map = None

    def connect(self, zs):
        self.zs = zs

    def set_adc_mapping(self, mapping):
        if not isinstance(mapping, zsadcmap.ZynqScopeADCMapping):
            raise RuntimeError("Unsupported alternative ADC mapping class, must be subclass of ZynqScopeADCMapping")

        self._adc_map = mapping

    def set_config(self, config_obj):
        if self.adc_map is None:
            raise RuntimeError("ADC mapping not yet provided; how am I going to work this out?")

        if isinstance(config_obj, ZynqScopeTriggerSuperclass):
            raise NotImplementedError("Unsupported trigger, must be subclass of ZynqScopeTriggerSuperclass")
        else:
            config_obj.commit(self.zs.zcmd, self._adc_map, DEFAULT_CHANNEL_MAP)