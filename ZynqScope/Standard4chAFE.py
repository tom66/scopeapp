"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

# Supported attenuation levels in V (at 1X probe setting)
attenuation_options = [0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5]

# Maximum V/div and minimum V/div.
MAX_V_DIV = 5
MIN_V_DIV = 0.002

# Coupling modes supported
COUP_MODES = ["AC", "DC", "GND"]

# Get maximum supported offset for given attenuation
def max_supported_offset(atten):
    if atten >= 0.1:
        return (-8, +8)
    else:
        return (-2, +2)
