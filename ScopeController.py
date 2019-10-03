"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import colorsys, math

import Utils

# Supported run states
STATE_STOPPED = 0               # State when stopped
STATE_RUNNING_AUTO = 1          # State when running on auto trigger without a trigger source
STATE_RUNNING_WAIT_TRIG = 2     # State when waiting for a trigger
STATE_RUNNING_TRIGD = 3         # State when running on normal trigger / single trigger and have a trigger

# Supported channels
SCOPE_CH_1 = 0 
SCOPE_CH_2 = 1
SCOPE_CH_3 = 2
SCOPE_CH_4 = 3
SCOPE_CH_EXT = 5

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

# Supported attenuation levels in V (at 1X probe setting)
attenuation_options = [0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5]

# Maximum V/div and minimum V/div.  TODO:  Load from oscilloscope configuration.
MAX_V_DIV = 5
MIN_V_DIV = 0.002

# Amount to increase/decrease in Coarse Offset mode
COARSE_OFFSET = 0.1

# Maximum supported offsets  (In reality this would vary depending on range, so this
# will need to change)
MAX_OFFSET = +8
MIN_OFFSET = -8

# Coupling modes supported
COUP_AC = 1
COUP_DC = 2
COUP_GND = 3

class ScopeChannelController(object):
    """
    This class manages the configuration of a single channel.
    """
    enabled = True # TODO..change this
    index = None
    
    internal_name = _("???")            # Always CH1, CH2, etc.
    default_long_name = _("Undefined")  # Always Channel 1, Channel 2, etc.
    short_name = _("Undefined")         # Could be CLK, DAT, etc.
    long_name = _("Undefined")          # Longer version of above: Clock, Serial Out, etc.
    _using_default_name = True
    
    hue = 0
    sat = 0
    
    # Channel settings
    atten_div = attenuation_options[5]
    probe_multiplier = 1
    offset = -7.8
    coupling = COUP_AC
    invert = False
    bandwidth_20M = False
    termination_50R = False
    unit = Utils.UnitVolt()
    
    def __init__(self, index, short_name=None, long_name=None):
        """Initialise a channel controller"""
        self.index = int(index)
        
        # Generate automatic name if needed (replace both names)
        if short_name == None:
            self.set_channel_name_defaults()
        else:
            self.set_channel_name_global(short_name, long_name)

    def set_colour(self, hue, sat):
        """Set the colour of a channel.  Only the hue and saturation of a channel may be set, to allow
        for value variation for highlighting and intensity grading."""
        assert 0 <= hue <= 360
        assert 0 <= sat <= 1
        
        self.hue = hue
        self.sat = sat
    
    def get_colour(self):
        """Return a tuple containing hue and saturation."""
        print("GetColour", self.hue, self.sat)
        return (self.hue, self.sat)
    
    def get_hex_colour(self, value):
        """Get hex representation (e.g. #ff0000) of channel colour given @value (0-1)."""
        assert 0 <= value <= 1
        return Utils.get_hex_colour_hsv(self.hue, self.sat, value)

    def enable_channel(self):
        self.enabled = True
        
    def disable_channel(self):
        self.enabled = False
    
    def toggle_channel(self):
        self.enabled = not self.enabled

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
        for index, atten in enumerate(attenuation_options):
            if atten >= self.atten_div:
                return index
        
        # None found, this is a problem.  Return the first index instead.
        return 0
    
    def set_atten_index(self, new_atten):
        # If out of range, then raise an UserRequestOutOfRange exception, which is
        # generally passed out as a warning
        if new_atten > (len(attenuation_options) - 1):
            raise Utils.UserRequestOutOfRange(_("Attenuation requested at limit"))
        
        if new_atten < 0:
            raise Utils.UserRequestOutOfRange(_("Attenuation requested at limit"))
        
        self.atten_div = attenuation_options[new_atten]
    
    def adjust_offset(self, adj, snap_zero=False):
        self.set_offset(self.offset + adj, snap_zero)
    
    def set_offset(self, new, snap_zero=False):
        old_offset = self.offset
        self.offset = new
        
        if self.offset > MAX_OFFSET:
            self.offset = MAX_OFFSET
            raise Utils.UserRequestOutOfRange(_("Offset requested at limit"))
        
        if self.offset < MIN_OFFSET:
            self.offset = MIN_OFFSET
            raise Utils.UserRequestOutOfRange(_("Offset requested at limit"))
    
        sign = math.copysign(1, old_offset)
        new_sign = math.copysign(1, self.offset)
        
        if snap_zero and sign != new_sign and abs(old_offset) > 1e-12:
            print("Channel: Snap offset to zero")
            self.offset = 0
            
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
    
    def set_coupling(self, coup):
        if coup in [COUP_AC, COUP_DC, COUP_GND]:
            self.coupling = coup
        else:
            raise ValueError("Unsupported coupling type")

    def get_coupling(self):
        return self.coupling
    
    def set_50_ohm_termination(self, state):
        assert isinstance(state, bool)
        self.termination_50R = state
    
    def set_bandwidth_20M(self, state):
        assert isinstance(state, bool)
        self.bandwidth_20M = state
    
    def set_invert(self, state):
        assert isinstance(state, bool)
        self.invert = state
    
    def get_50_ohm_termination(self):
        return self.termination_50R 
    
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

class ScopeController(object):
    """
    This class manages the overall oscilloscope function.  It controls acquisition, via the FPGA,
    and manages run state and keeps the MCU/FPGA configuration in sync with the desired user 
    configuration.
    """
    
    # Current running state of the instrument
    run_state = STATE_RUNNING_AUTO
    
    # Set of channels
    channels = []
    
    def __init__(self):
        # TODO: We need to determine whether the instrument is 2ch or 4ch
        self.channels.append(ScopeChannelController(SCOPE_CH_1))
        self.channels.append(ScopeChannelController(SCOPE_CH_2))
        self.channels.append(ScopeChannelController(SCOPE_CH_3))
        self.channels.append(ScopeChannelController(SCOPE_CH_4))
        self.channels[0].set_colour(0, 0.85)
        self.channels[1].set_colour(60, 0.85)
        self.channels[2].set_colour(160, 0.85)
        self.channels[3].set_colour(270, 0.65)
        