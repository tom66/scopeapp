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

# Load debug logger
import logging
log = logging.getLogger()

class ZynqScopeTriggerSuperclass(object): 
    """Picklable superclass for the trigger configuration.  Designed to be passed
    via the multiprocessing queue."""
    def __init__(self):
        self._params_types = {}
        self._params_dict = {}

    def get_name(self):
        return "UNDEFINED"

    def get_supported_parameters(self):
        return self._params_types

    def set_parameter(self, key, value):
        if key not in self._params_dict:
            raise NotImplementedError("Parameter not supported")
        self._params_dict[key] = value
        self._validate_params()

    def get_parameter(self, key):
        return self._params_dict[key]

    def _validate_params(self):
        pass

    def commit(self, *params):
        raise NotImplementedError("Superclass not a valid trigger")

    def __repr__(self):
        return "<UndefinedTrigger>"

class ZynqScopeTriggerAlways(ZynqScopeTriggerSuperclass):
    def __init__(self): 
        super(ZynqScopeTriggerSuperclass, self).__init__()

    def get_name(self):
        return "ALWAYS_TRIGGER"

    def commit(self, zcmd, adc_map, chan_map):
        zcmd.setup_trigger_always()

    def __repr__(self):
        return "<AlwaysTrigger>"

class ZynqScopeTriggerEdge(ZynqScopeTriggerSuperclass):
    def __init__(self): 
        super(ZynqScopeTriggerSuperclass, self).__init__()
        self._params_types = {'Channel'    : 'ChannelSelection',
                              'Level'      : 'VoltageLevel',
                              'Hysteresis' : 'VoltageLevel',
                              'Edge'       : 'EdgeType'}

        # Defaults
        self.set_parameter('Level', 0.0)
        self.set_parameter('Hysteresis', 0.0)
        self.set_parameter('Channel', 'CH1')
        self.set_parameter('Edge', 'RISE')

    def get_name(self):
        return "EDGE_TRIGGER"

    def commit(self, zcmd, adc_map, chan_map):
        level = self.adc_map.apply_map_volt(self._params_dict['Level'])
        hyst = self.adc_map.apply_map_volt_rel(self._params_dict['Hysteresis'])
        channel = self.chan_map[self._params_dict['Channel']]

        zcmd.setup_trigger_edge(channel, level, hyst, EDGE_TYPES[self._params_dict['EdgeType']])

    def __repr__(self):
        return "<EdgeTrigger Level=%.2f, Hyst=%.2f, Channel=%d, Edge=%s>" % \
            (self._params_dict['Level'], self._params_dict['Hysteresis'], self._params_dict['Channel'], self._params_dict['Edge'])

AVAILABLE_TRIGGERS = [
    ZynqScopeTriggerAlways,
    ZynqScopeTriggerEdge,
]

class ZynqScopeTriggerManager(object):
    def __init__(self):
        self.zs = None
        self.ch_map = [zc.TRIG_CH_ADCSRC1, zc.TRIG_CH_ADCSRC2, zc.TRIG_CH_ADCSRC3, zc.TRIG_CH_ADCSRC4]
        self.adc_map = None
        self._last_config_obj = None

    def connect(self, zs):
        log.info("ZynqScopeTriggerManager: connect(%r)" % zs)
        self.zs = zs

    def set_adc_mapping(self, mapping):
        log.info("ZynqScopeTriggerManager: set_adc_mapping(%r)" % mapping)

        if not isinstance(mapping, zsadcmap.ZynqScopeADCMapping):
            raise RuntimeError("Unsupported alternative ADC mapping class, must be subclass of ZynqScopeADCMapping")

        self._adc_map = mapping

    def refresh_for_adc_map_change(self):
        log.info("ZynqScopeTriggerManager: refresh_for_adc_map_change()")
        self.set_config(self._last_config_obj)

    def set_config(self, config_obj):
        log.info("ZynqScopeTriggerManager: set_config(%r)" % config_obj)

        if self.adc_map is None:
            raise RuntimeError("ADC mapping not yet provided; how am I going to work this out?")

        if isinstance(config_obj, ZynqScopeTriggerSuperclass):
            raise NotImplementedError("Unsupported trigger, must be subclass of ZynqScopeTriggerSuperclass")
        else:
            self._last_config_obj = config_obj
            config_obj.commit(self.zs.zcmd, self._adc_map, DEFAULT_CHANNEL_MAP)
