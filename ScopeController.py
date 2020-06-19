"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import colorsys, math, json, logging
import Utils

import ZynqScope.ZynqScopeTask as zst
import ZynqScope.ZynqScopeGlobals as zsgl
import ZynqScope.ZynqScopeADCMapping as zsadcmap

import ScopeArena

COUP_AC, COUP_DC, COUP_GND = zsgl.COUP_AC, zsgl.COUP_DC, zsgl.COUP_GND

# Force 4ch AFE module for now
AFE_module = zst.AFE

# Supported run states of acquisition
STATE_STOPPED = 0               # State when stopped
STATE_RUNNING_AUTO = 1          # State when running on auto trigger without a trigger source
STATE_RUNNING_WAIT_TRIG = 2     # State when waiting for a trigger
STATE_RUNNING_TRIGD = 3         # State when running on normal trigger / single trigger and have a trigger

# Supported run/stop states
ACQ_IS_STOPPED = 0
ACQ_IS_RUNNING = 1

# Supported channels
SCOPE_CH_1 = 0 
SCOPE_CH_2 = 1
SCOPE_CH_3 = 2
SCOPE_CH_4 = 3
SCOPE_CH_EXT = 4

CHANNEL_INDEXES = [0, 1, 2, 3, 4]

# Automatic channel names. Not translated.
auto_short_names = [
    "CH1", "CH2", "CH3", "CH4", "EXT"
]

# Automatic long channel names.  Translatable.
auto_long_names = [
    _("Channel 1"),
    _("Channel 2"),
    _("Channel 3"),
    _("Channel 4"),
    _("External Input")
]

# Amount to increase/decrease in Coarse Offset mode
COARSE_OFFSET = 0.1

# Maximum supported timebase range
MAX_TIMEBASE_SHIFT_NEG = -100
MAX_TIMEBASE_SHIFT_POS = +100

# Settings files
TEMP_SETTING_FILE = "user/temp.stg"
DEFAULT_SETTING_FILE = "user/default.stg"
LAST_SETTING_FILE = "user/last.stg"

# Load debug logger
import logging
log = logging.getLogger()

class ScopeChannelController(object):
    """
    This class manages the configuration of a single channel.
    """
    enabled = False
    index = None
    
    internal_name = _("???")            # Always CH1, CH2, etc.
    default_long_name = _("Undefined")  # Always Channel 1, Channel 2, etc.
    short_name = _("Undefined")         # Could be CLK, DAT, etc.
    long_name = _("Undefined")          # Longer version of above: Clock, Serial Out, etc.
    _using_default_name = True
    
    hue = 0
    sat = 0
    
    # Limits/supported settings
    atten_supported = []
    coupling_supported = []
    
    # Channel settings
    atten_div = 0
    atten_raw = 0
    probe_multiplier = 1
    vernier = False
    offset = 0.0
    coupling = None
    invert = False
    bandwidth_20M = False
    termination_50R = False
    unit = Utils.UnitVolt()
    
    # Whether 50R mode is to be applied is determined by confirming with the user;  the setting
    # is not written until the user confirms if the setting is restored after a power up.
    termination_50R_applied = False
    
    pack_vars_types = {
        "enabled":              [(bool,)],
        "index":                [(int,), CHANNEL_INDEXES[0], CHANNEL_INDEXES[-1]],
        "internal_name":        [(str,), 20],
        "default_long_name":    [(str,), 20],
        "_using_default_name":  [(bool,)],
        "short_name":           [(str,), 5],
        "long_name":            [(str,), 20],
        "hue":                  [(float, int), 0, 360],
        "sat":                  [(float, int), 0, 1],
        "atten_div":            [(float, int)], # validated later
        "atten_raw":            [(float, int)], # validated later
        "probe_multiplier":     [(float, int)], # validated later
        "vernier":              [(bool,)], 
        "offset":               [(float, int)], # validated later
        "coupling":             [(int,)],       # validated later
        "invert":               [(bool,)], 
        "bandwidth_20M":        [(bool,)], 
        "termination_50R":      [(bool,)], 
        "unit":                 [(str,), 20],
    } 
    
    def __init__(self, index, short_name=None, long_name=None):
        """Initialise a channel controller"""
        log.info("__init__() ScopeChannelController for channel %d" % index)
        self.index = int(index)
        
        # Generate automatic name if needed (replace both names)
        if short_name == None:
            self.set_channel_name_defaults()
        else:
            self.set_channel_name_global(short_name, long_name)
        
        # Setup default settings according to AFE limitations
        self.atten_supported = AFE_module.get_attenuation_modes_supported()
        self.atten_div = AFE_module.get_default_attenuation()
        self.coupling_supported = AFE_module.get_coupling_modes_supported()
        self.coupling = AFE_module.get_default_coupling()
        
        # Set default change notifier (does nothing)
        self.change_notifier = lambda x: None

    def prepare_state(self):
        return Utils.pack_dict_json(self, self.pack_vars_types)
    
    def restore_state(self, json_dict):
        try:
            Utils.unpack_json(self, json_dict, self.pack_vars_types)
            #print("??termination_50R", self.termination_50R)
            self.unit = Utils.unit_unpickle(self.unit)
        except Exception as e:
            raise Utils.StateSaveFileCorrupted(_("Unable to restore configuration file for ScopeChannelController: Exception - %s" % str(e)))
    
    def set_colour(self, hue, sat):
        """Set the colour of a channel.  Only the hue and saturation of a channel may be set, to allow
        for value variation for highlighting and intensity grading."""
        assert 0 <= hue <= 360
        assert 0 <= sat <= 1
        
        self.hue = hue
        self.sat = sat
    
    def get_colour(self):
        """Return a tuple containing hue and saturation."""
        return (self.hue, self.sat)
    
    def get_hex_colour(self, value):
        """Get hex representation (e.g. #ff0000) of channel colour given @value (0-1)."""
        assert 0 <= value <= 1
        return Utils.get_hex_colour_hsv(self.hue, self.sat, value)

    def get_rgb_colour(self):
        """Get RGB representation (e.g. (0, 255, 0)) of channel colour assuming 100% value."""
        return Utils.get_rgb_colour_hsv(self.hue, self.sat, 1.0)

    def get_colour_formatted(self, str_, value=1.0):
        return '<span foreground="%s">%s</span>' % (self.get_hex_colour(value), str_)

    def enable_channel(self):
        self.enabled = True
        self.change_notifier('enable-state')
        
    def disable_channel(self):
        self.enabled = False
        self.change_notifier('enable-state')
    
    def toggle_channel(self):
        self.enabled = not self.enabled
        self.change_notifier('enable-state')

    def is_enabled(self):
        return self.enabled
    
    def set_unit(self, unit):
        if isinstance(unit, Utils.Unit):
            self.unit = unit
        else:
            raise ValueError("Invalid unit, not a subclass of Utils.Unit")
    
    def get_unit(self):
        return self.unit
    
    def set_channel_name_global(self, short_name, long_name):
        self.short_name = str(short_name)
        self.long_name = str(long_name)
        self._using_default_name = False

    def set_channel_name_defaults(self):
        self.internal_name = auto_short_names[self.index]
        self.default_long_name = auto_long_names[self.index]
        self.short_name = self.internal_name
        self.long_name = self.default_long_name
        self._using_default_name = True

    def has_default_name(self):
        return self._using_default_name

    def get_display_name(self):
        return self.long_name

    def get_short_display_name(self):
        return self.short_name

    def get_colour_formatted_display_name(self):
        return self.get_colour_formatted(self.get_display_name())

    def get_colour_formatted_short_display_name(self):
        return self.get_colour_formatted(self.get_short_display_name())
        
    def get_computed_attenuation(self):
        return self.atten_div * self.probe_multiplier
    
    def get_computed_offset(self):
        return self.offset * self.probe_multiplier
    
    def get_probe_gain(self):
        return self.probe_multiplier
        
    def set_probe_gain(self, gain):
        self.probe_multiplier = float(gain)
    
    def _get_nearest_atten_index(self):
        """Find the nearest value in the attenuation table to the current setting.
        To do this, the function iterates through the list, and at the soonest value
        equal or greater than the current attenuation, it will break and return that
        value.  If no value is found, the first index is returned instead - failing safe."""
        for index, atten in enumerate(self.atten_supported):
            if atten >= self.atten_div:
                return index
        
        # None found, this is a problem.  Return the first index instead.
        return 0
    
    def set_atten_index(self, new_atten):
        # If out of range, then raise an UserRequestOutOfRange exception, which is
        # generally passed out as a warning
        if new_atten > (len(self.atten_supported) - 1):
            raise Utils.UserRequestOutOfRange(_("Attenuation requested at upper limit"))
        
        if new_atten < 0:
            raise Utils.UserRequestOutOfRange(_("Attenuation requested at lower limit"))
        
        self.atten_div = self.atten_supported[new_atten]
        
        # If attenuation change causes offset limits to change we need to adjust those too; 
        # to account for this we adjust the offset by "None" to force recomputation
        self.adjust_offset(None)
        
        self.change_notifier('atten')
    
    def adjust_offset(self, adj, snap_zero=False):
        if adj == None:
            self.set_offset(None, snap_zero)
        else:
            self.set_offset(self.offset + adj, snap_zero)
    
    def set_offset(self, new, snap_zero=False):
        old_offset = self.offset
        
        if new != None:
            self.offset = new
        
        limits = AFE_module.get_max_offset_supported(self.atten_div)
        
        if self.offset > limits[1]:
            self.offset = limits[1]
            if new == None:
                raise Utils.UserRequestOutOfRange(_("Offset limited by attenuation range"))
            else:
                raise Utils.UserRequestOutOfRange(_("Offset requested at upper limit"))
        
        if self.offset < limits[0]:
            self.offset = limits[0]
            if new == None:
                raise Utils.UserRequestOutOfRange(_("Offset limited by attenuation range"))
            else:
                raise Utils.UserRequestOutOfRange(_("Offset requested at lower limit"))
    
        if new != None:
            sign = math.copysign(1, old_offset)
            new_sign = math.copysign(1, self.offset)
            
            if snap_zero and sign != new_sign and abs(old_offset) > 1e-12:
                log.info("Channel %d: Snap offset to zero" % self.index)
                self.offset = 0
        
        if old_offset != self.offset:
            self.change_notifier('offset')
    
    def atten_up_coarse(self):
        nearest_atten = self._get_nearest_atten_index()
        self.set_atten_index(nearest_atten + 1)
        
    def atten_down_coarse(self):
        nearest_atten = self._get_nearest_atten_index()
        self.set_atten_index(nearest_atten - 1)
        
    def offset_up_coarse(self):
        self.adjust_offset(+COARSE_OFFSET, snap_zero=True)
    
    def offset_down_coarse(self):
        # If offset crosses zero, snap to zero.
        self.adjust_offset(-COARSE_OFFSET, snap_zero=True)
    
    def offset_zero(self):
        self.set_offset(0)
    
    def get_supports_coupling(self, coup):
        return coup in self.coupling_supported
    
    def set_coupling(self, coup):
        if self.get_supports_coupling(coup):
            self.coupling = coup
            self.change_notifier('coupling')
        else:
            raise ValueError("Unsupported coupling type")

    def get_coupling(self):
        return self.coupling
    
    def set_50_ohm_termination(self, state):
        assert isinstance(state, bool)
        self.termination_50R = state
        self.termination_50R_applied = state
        self.change_notifier('fifty-ohm')
    
    def set_bandwidth_20M(self, state):
        assert isinstance(state, bool)
        self.bandwidth_20M = state
        self.change_notifier('bw-limit')
    
    def set_invert(self, state):
        assert isinstance(state, bool)
        self.invert = state
        self.change_notifier('invert')
    
    def get_50_ohm_termination(self):
        return self.termination_50R 
    
    def get_50_ohm_termination_applied(self):
        return self.termination_50R_applied
    
    def get_bandwidth_20M(self):
        return self.bandwidth_20M
    
    def get_invert(self):
        return self.invert
    
    def toggle_50_ohm_termination(self):
        self.set_50_ohm_termination(not self.termination_50R)
    
    def toggle_bandwidth_20M(self):
        self.set_bandwidth_20M(not self.bandwidth_20M)
    
    def toggle_invert(self):
        self.set_invert(not self.invert)

    def set_change_notifier(self, notify):
        assert(callable(notify))
        self.change_notifier = notify
        
class ScopeTimebaseController(object):
    supported_timebases = []
    timebase_index = 0
    offset = 0
    
    pack_vars_types = {
        "timebase_index":       [(int,)],
        "offset":               [(float, int)],
    }
    
    zstc = None
    
    def __init__(self, zstc):
        self.zstc = zstc
        
        # Get the list of supported timebases
        self.supported_timebases = self.zstc.get_supported_timebases()
        
        # Set default change notifier (does nothing)
        self.change_notifier = lambda x: None
    
    def prepare_state(self):
        return Utils.pack_dict_json(self, self.pack_vars_types)
    
    def restore_state(self, json_dict):
        try:
            Utils.unpack_json(self, json_dict, self.pack_vars_types)

            try:
                tb = self.supported_timebases[self.timebase_index]
            except:
                # Go back to default timebase
                log.warning("Timebase in configuration file is invalid: using first timebase available")
                self.timebase_index = 0

            # TODO: Bounds check on offset?
        except Exception as e:
            raise Utils.StateSaveFileCorrupted(_("Unable to restore configuration file for ScopeTimebaseController: Exception - %s" % str(e)))

    def get_timebase(self):
        if self.timebase_index < 0: 
            self.timebase_index = 0
        
        if self.timebase_index >= len(self.supported_timebases):
            self.timebase_index = len(self.supported_timebases) - 1
        
        return self.supported_timebases[self.timebase_index]
    
    def timebase_up(self):
        log.debug("timebase_up()")

        self.timebase_index += 1
        if self.timebase_index >= len(self.supported_timebases):
            self.timebase_index = len(self.supported_timebases) - 1
            raise Utils.UserRequestOutOfRange(_("Timebase at maximum"))
        else:
            self.change_notifier('timebase-div')
    
    def timebase_down(self):
        log.debug("timebase_down()")

        self.timebase_index -= 1
        if self.timebase_index < 0:
            self.timebase_index = 0
            raise Utils.UserRequestOutOfRange(_("Timebase at minimum"))
        else:
            self.change_notifier('timebase-div')
    
    def adjust_offset(self, adj):
        # This function needs to be completely reworked
        max_limit = (MAX_TIMEBASE_SHIFT_POS * self.get_timebase_value())
        min_limit = (MAX_TIMEBASE_SHIFT_NEG * self.get_timebase_value())
        
        self.offset += adj
        self.offset = min(max_limit, self.offset)
        self.offset = max(min_limit, self.offset)
        
        self.change_notifier('timebase-offset')
    
    def get_offset(self):
        return self.offset

    def set_change_notifier(self, notify):
        assert(callable(notify))
        self.change_notifier = notify
 
class ScopeController(object):
    """
    This class manages the overall oscilloscope function.  It controls acquisition, via the FPGA,
    and manages run state and keeps the MCU/FPGA configuration in sync with the desired user 
    configuration.
    """
    
    # Current acquisition state of the instrument
    acq_state = STATE_STOPPED
    run_state = ACQ_IS_STOPPED
    
    # Set of channels
    channels = []
    
    # Currently selected tab for UI
    active_tab = 0

    # ZynqScopeTaskController object.  Used as an interface to the "Real World"
    zst = None

    # ADC mapping, shared with the ZynqScopeTaskController
    adc_map = None

    # ScopeArena object.  Used as the render target
    arena = None
    
    def __init__(self, root_mgr):
        self.root_mgr = root_mgr

        if AFE_module.get_channel_count() == 4:
            self.channels.append(ScopeChannelController(SCOPE_CH_1))
            self.channels.append(ScopeChannelController(SCOPE_CH_2))
            self.channels.append(ScopeChannelController(SCOPE_CH_3))
            self.channels.append(ScopeChannelController(SCOPE_CH_4))
            self.channels[0].set_colour(0, 0.85)
            self.channels[1].set_colour(60, 0.85)
            self.channels[2].set_colour(160, 0.85)
            self.channels[3].set_colour(270, 0.65)
            
            for ch in self.channels:
                ch.set_change_notifier(self.change_notifier)
        else:
            raise NotImplementedError("Unsupported configuration")
    
    def set_render_parameters(self, display_samples_target, default_hdiv_span):
        self.display_samples_target = display_samples_target
        self.default_hdiv_span = default_hdiv_span
    
    def connect(self):
        log.debug("ScopeController.connect() - connecting to ZynqScopeTaskController and ScopeTimebaseController")

        self.zst = zst.ZynqScopeTaskController((self.display_samples_target, self.default_hdiv_span))
        self.zst.start_task()
        self.timebase = ScopeTimebaseController(self.zst)
        self.timebase.set_change_notifier(self.change_notifier)
        self.arena = ScopeArena.ScopeArenaController(self, self.root_mgr.cfgmgr)

        # Apply default ADC mapping.  This will need to change in future with real AFE
        log.debug("ScopeController.connect() - setting default ADC mapping and trigger")

        self.adc_map = zsadcmap.ZynqScopeADCMapping()
        self.adc_map.set_mapping(-9.0, +9.0, 0xff)
        log.info("ADCMapping: %r" % self.adc_map)
        self.zst.apply_adc_mapping(self.adc_map)

        # Apply default 'Always' trigger
        self.zst.apply_trigger(ZynqScopeTriggerAlways())

    def get_adc_mapping(self):
        return self.adc_map

    def get_adc_volt_limits(self):
        return self.adc_map.get_volt_limits()

    def get_adc_volt_limits_mapped_to_channel(self, chidx):
        return self.adc_map.get_volt_limits_scaled(self.channels[chidx].probe_multiplier)

    def get_adc_volt_span(self):
        return self.adc_map.get_volt_span()

    def get_adc_volt_span_mapped_to_channel(self, chidx):
        return self.adc_map.get_volt_span_scaled(self.channels[chidx].probe_multiplier)

    def save_settings_temp(self):
        self.save_settings(TEMP_SETTING_FILE)
        
    def save_settings_last(self):
        self.save_settings(LAST_SETTING_FILE)
        
    def restore_settings_temp(self):
        self.restore_settings(TEMP_SETTING_FILE)
        
    def restore_settings_last(self):
        self.restore_settings(LAST_SETTING_FILE)
        
    def restore_settings_default(self):
        self.restore_settings(DEFAULT_SETTING_FILE)
        
    def prepare_json_state(self):
        state = { 'version'     : (Utils.APP_VERSION_MAJOR, Utils.APP_VERSION_MINOR), 
                  'n_channels'  : int(len(self.channels)), 
                  'timebase'    : self.timebase.prepare_state(),
                  'arena'       : self.arena.prepare_state(),
                  'active_tab'  : self.active_tab }
        
        for n in range(len(self.channels)):
            log.info("Preparing channel %d" % n)
            state['channel%d' % n] = self.channels[n].prepare_state()
        
        return json.dumps(state)
    
    def unpack_json_state(self, state):
        log.info("Trying to unpack JSON state...")

        try:
            json_obj = json.loads(state)
            
            if int(json_obj['version'][0]) > Utils.APP_VERSION_MAJOR:
                raise Utils.StateSaveFileCorrupted(_("Unable to restore configuration file: Major version newer, cannot load"))
            
            # Recall channels
            for ch in range(int(json_obj['n_channels'])):
                self.channels[ch].restore_state(json_obj['channel%d' % ch])
                #print("unpack_json_state", self.channels[ch].termination_50R, self.channels[ch].termination_50R_applied)
                #self.channels[ch].termination_50R_applied = False
            
            # Recall timebase, arena; later recall triggers, acquisition settings, etc.
            self.timebase.restore_state(json_obj['timebase'])
            self.arena.restore_state(json_obj['arena'])

            self.acq_state = STATE_STOPPED              # Default to stopped
            #self.run_state = ACQ_IS_STOPPED
            self.active_tab = json_obj['active_tab']    # Recall tab
            
            log.info("After unpacking JSON state, active tab is %d" % self.active_tab)
            
        except Utils.StateSaveFileCorrupted as e:
            raise e
        except Exception as e:
            # TRANSLATORS: {0} is a Python exception string which may or may not be translated into user's locale. 
            raise Utils.StateSaveFileCorrupted(_("Unable to restore configuration file: General load error: {0}".format(repr(e))))

        # Generate notifiers for state change
        self.root_mgr.state_change_all()

    def save_settings(self, fname):
        """Save settings file, overwriting any existing file with this name."""
        f = open(fname, "w")
        f.write(self.prepare_json_state())
        f.close()
        
    def restore_settings(self, fname):
        """Restore settings from file."""
        f = open(fname, "r")
        self.unpack_json_state(f.read())
        f.close()
    
    def sync_if_needed(self):
        """Syncs changes to real world if needed.  If the oscilloscope is stopped changes are
        queued until the instrument resumes running."""
        log.info("sync_if_needed() run_state: %r in sync_if_needed" % self.run_state)
        
        if self.run_state == ACQ_IS_RUNNING:
            log.info("Syncing to real world")
            self.zst.stop_acquisition()
            self.zst.sync_to_real_world()
            self.zst.start_acquisition()
        else:
            log.info("No sync, we are stopped")
    
    def tick(self):
        self.zst.acquisition_tick()
    
    def get_memory_depth(self):
        # ZynqScopeCurrentParameters
        return self.zst.get_attributes_cache().params.memory_depth
    
    def get_waves_per_second(self):
        return self.zst.get_attributes_cache().params.wave_rate
    
    def get_nwaves(self):
        return self.zst.get_attributes_cache().params.nwaves
    
    def get_sample_depth(self):
        return self.zst.get_attributes_cache().params.sample_depth
    
    def get_sample_rate(self):
        return self.zst.get_attributes_cache().params.sample_rate
    
    def get_channels(self):
        ch = []
        for channel in self.channels:
            ch.append((channel.internal_name, channel))
        return ch

    def get_run_state_str(self):
        if self.run_state == ACQ_IS_STOPPED:
            return "STOP"
        else:
            return "RUN"
    
    def get_overall_state_str(self):
        if self.run_state == ACQ_IS_STOPPED:
            return "STOP"
        else:
            if self.acq_state == STATE_RUNNING_AUTO:
                return "AUTO"
            elif self.acq_state == STATE_RUNNING_WAIT_TRIG:
                return "WAIT"
            elif self.acq_state == STATE_RUNNING_TRIGD:
                return "TRIGD"
            else:
                return "STOP"
    
    def change_notifier(self, param):
        log.debug("change_notifier: %s" % param)
        
        # Sync for timebase and delay changes
        if param == "timebase-div":
            self.zst.set_next_timebase_index(self.timebase.timebase_index)
            self.sync_if_needed()
    
    def acq_run(self):
        log.debug("acq_run() outer")
        self.zst.start_acquisition()

        if self.run_state == ACQ_IS_STOPPED:
            # Sync all changes to the acquisition side
            self.zst.sync_to_real_world()
            self.zst.start_acquisition()
            self.run_state = ACQ_IS_RUNNING
            print("acq_run() - oscilloscope is running")
        else:
            raise RuntimeError("Oscilloscope is not stopped")

    def acq_stop(self):
        print("acq_stop() outer")
        
        if self.run_state == ACQ_IS_RUNNING:
            # Stop the instrument
            self.zst.stop_acquisition()
            self.run_state = ACQ_IS_STOPPED
            print("acq_stop() - oscilloscope is stopped")
        else:
            raise RuntimeError("Oscilloscope is not running")

    def update(self):
        self.arena.update()