"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import ZynqScope.ZynqScopeGlobals as zsgl

# Supported attenuation levels in V (at 1X probe setting)
atten_options = [0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5]

# Coupling modes supported
coupling_modes = [zsgl.COUP_AC, zsgl.COUP_DC, zsgl.COUP_GND]

def get_attenuation_modes_supported():
    return atten_options

def get_coupling_modes_supported():
    return coupling_modes
    
def get_default_attenuation():
    # Return 100mV/div as default safe attenuation
    return atten_options[5]
    
def get_default_coupling():
    # Return DC coupling as default safe coupling
    return coupling_modes[1]

def get_supports_50R_mode():
    return False
    
def get_supports_BW_limit_mode():
    return False

def get_supported_BW_limits():
    return []

def get_channel_count():
    return 4
    
def get_max_offset_supported(atten):   
    """Get maximum supported offset for given attenuation"""
    if atten >= 0.1:
        return (-8, +8)
    else:
        return (-2, +2)
