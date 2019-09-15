"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import colorsys

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

class ScopeChannelController(object):
    """
    This class manages the configuration of a single channel.
    """
    index = None
    internal_name = "Undefined"     # Always CH1, CH2, etc.
    short_name = "Undefined"        # Could be CLK, DAT, etc.
    long_name = "Undefined"         # Longer version of above: Clock, Serial Out, etc.
    hue = 0
    sat = 0
    
    # Channel settings
    atten_div_setting = 0
    offset = 0
    
    def __init__(self, index, name):
        """Initialise a channel controller"""
        self.index = int(index)
        self.short_name = str(name)
        self.internal_name = self.short_name    
        self.long_name = self.short_name

    def set_colour(self, hue, sat):
        """Set the colour of a channel.  Only the hue and saturation of a channel may be set, to allow
        for value variation for highlighting and intensity grading."""
        assert 0 <= hue < 360
        assert 0 <= sat <= 1
        
        self.hue = hue
        self.sat = sat
    
    def get_hex_colour(self, value):
        """Get hex representation (e.g. #ff0000) of channel colour given @value (0-1)."""
        assert 0 <= value <= 1
        
        rgb = colorsys.hsv_to_rgb(self.hue / 360.0, self.sat, value)
        rgb = (int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))
        return "#%02x%02x%02x" % rgb
        
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
        self.channels.append(ScopeChannelController(SCOPE_CH_1, "CH1"))
        self.channels.append(ScopeChannelController(SCOPE_CH_2, "CH2"))
        self.channels.append(ScopeChannelController(SCOPE_CH_3, "CH3"))
        self.channels.append(ScopeChannelController(SCOPE_CH_4, "CH4"))
        self.channels[0].set_colour(10, 0.85)
        self.channels[1].set_colour(50, 0.85)
        self.channels[2].set_colour(160, 0.85)
        self.channels[3].set_colour(250, 0.85)
        