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
    1: zc.TRIG_CH_ADCSRC1,
    2: zc.TRIG_CH_ADCSRC2,
    3: zc.TRIG_CH_ADCSRC3,
    4: zc.TRIG_CH_ADCSRC4
}

# Load debug logger
import logging
log = logging.getLogger()

class ZynqScopeTriggerSuperclass(object): 
    """Picklable superclass for the trigger configuration.  Designed to be passed
    via the multiprocessing queue."""
    def __init__(self):
        log.info("ZynqScopeTriggerSuperclass(): __init__()")
        self.params_types = {}
        self.params_dict = {}
        self._validate_params = None

    def get_name(self):
        return "UNDEFINED"

    def get_supported_parameters(self):
        return self.params_types

    def set_parameter(self, key, value):
        log.info("SupportedDict: %r" % self.params_types)

        try:
            self.params_types[key]
        except KeyError:
            raise NotImplementedError("Parameter not supported: %s" % key)

        self.params_dict[key] = value

        if callable(self._validate_params):
            self._validate_params()

    def get_parameter(self, key):
        return self.params_dict[key]

    def commit(self, *params):
        raise NotImplementedError("Superclass not a valid trigger")

    def __repr__(self):
        return "<UndefinedTrigger>"

class ZynqScopeTriggerAlways(ZynqScopeTriggerSuperclass):
    def __init__(self): 
        #super(ZynqScopeTriggerSuperclass, self).__init__()
        super().__init__()
        log.info("ZynqScopeTriggerAlways(): __init__()")

    def get_name(self):
        return "ALWAYS_TRIGGER"

    def get_commit_sequence(self, adc_map, chan_map):
        return [('setup_trigger_always', ())]

    def __repr__(self):
        return "<AlwaysTrigger>"

class ZynqScopeTriggerEdge(ZynqScopeTriggerSuperclass):
    def __init__(self): 
        #super(ZynqScopeTriggerSuperclass, self).__init__()
        super().__init__()
        log.info("ZynqScopeTriggerEdge(): __init__()")

        self.params_types = {'Channel'    : 'ChannelSelection',
                             'Level'      : 'VoltageLevel',
                             'Hysteresis' : 'VoltageLevel',
                             'Edge'       : 'EdgeType'}

        self.params_dict = {}
        self._validate_params = None

        # Defaults
        self.set_parameter('Level', 0.0)
        self.set_parameter('Hysteresis', 0.0)
        self.set_parameter('Channel', 1)
        self.set_parameter('Edge', 'RISE')

    def get_name(self):
        return "EDGE_TRIGGER"

    def get_commit_sequence(self, adc_map, chan_map):
        level = adc_map.apply_map_volt(self.params_dict['Level'])
        hyst = adc_map.apply_map_volt_rel(self.params_dict['Hysteresis'])
        channel = chan_map[self.params_dict['Channel']]

        return [('setup_trigger_edge', (channel, level, hyst, EDGE_TYPES[self.params_dict['Edge']]))]

    def __repr__(self):
        return "<EdgeTrigger Level=%.2f, Hyst=%.2f, Channel=%d, Edge=%s>" % \
            (self.params_dict['Level'], self.params_dict['Hysteresis'], self.params_dict['Channel'], self.params_dict['Edge'])

AVAILABLE_TRIGGERS = [
    ZynqScopeTriggerAlways,
    ZynqScopeTriggerEdge,
]

class ZynqScopeTriggerManager(object):
    def __init__(self):
        self.zcmd = None
        self.ch_map = [zc.TRIG_CH_ADCSRC1, zc.TRIG_CH_ADCSRC2, zc.TRIG_CH_ADCSRC3, zc.TRIG_CH_ADCSRC4]
        self._adc_map = None
        self._last_config_obj = None

    def connect(self, zcmd):
        log.info("ZynqScopeTriggerManager: connect(%r)" % zcmd)
        self.zcmd = zcmd

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

        if self._adc_map is None:
            raise RuntimeError("ADC mapping not yet provided; how am I going to work this out?")

        if isinstance(ZynqScopeTriggerSuperclass, type(config_obj)):
            raise NotImplementedError("Unsupported trigger, must be subclass of ZynqScopeTriggerSuperclass")
        else:
            self._last_config_obj = config_obj

            # We need to do this in this way because the config_obj might be in another process and have
            # no visibility over the SpiDev object
            seq = config_obj.get_commit_sequence(self._adc_map, DEFAULT_CHANNEL_MAP)

            for entry in seq:
                log.debug("Trigger commit: %s (%r)" % (entry[0], entry[1]))
                getattr(self.zcmd, entry[0])(*entry[1])

            log.info(repr(seq))
