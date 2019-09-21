"""
This file is part of YAOS and is licenced under the MIT licence.

Common utilities used by multiple submodules.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import math

class UserRequestError(Exception): pass
class UserRequestOutOfRange(UserRequestError): pass

def float_trail_free(x):
    """Return a formatted float without trailing zeroes.  This is an awful hack."""
    # https://stackoverflow.com/a/2440786/313032, Alex Martelli
    return ('%.15f' % x).rstrip('0').rstrip('.')

def round_sig_figs(x, sf):
    """Round a number `x' down to a number of significant figures `sf'."""
    if abs(x) < 1e-18:
        return 0
    else:
        # https://stackoverflow.com/a/3411435/313032, Roy Hyunjin Han
        return round(x, -int(math.floor(math.log10(abs(x)))) + (sf - 1)) 

def unit_format_suffix(value, suffix, precision=2):
    """Print given value as a SI-scaled unit.  Precision option specifies how many significant digits to display."""
    # TRANSLATORS: SI units generally are not translated, please check carefully before translating.
    if abs(value) < 1e-12: 
        return _("0 {unit}").format(unit=suffix) # Values below 1 pico are assumed to be zero
    elif abs(value) >= 1e-12 and abs(value) < 1e-9:
        return _("{value} p{unit}").format(value=float_trail_free(round_sig_figs(value * 1e12, precision)), unit=suffix)
    elif abs(value) >= 1e-9 and abs(value) < 1e-6:
        return _("{value} n{unit}").format(value=float_trail_free(round_sig_figs(value * 1e9, precision)), unit=suffix)
    elif abs(value) >= 1e-6 and abs(value) < 1e-3:
        return _("{value} \u03BC{unit}").format(value=float_trail_free(round_sig_figs(value * 1e6, precision)), unit=suffix)
    elif abs(value) >= 1e-3 and abs(value) < 0.99:
        return _("{value} m{unit}").format(value=float_trail_free(round_sig_figs(value * 1e3, precision)), unit=suffix)
    elif abs(value) >= 0.99 and abs(value) < .99e3:
        return _("{value} {unit}").format(value=float_trail_free(round_sig_figs(value, precision)), unit=suffix)
    elif abs(value) >= .99e3 and abs(value) < .99e6:
        return _("{value} k{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-3, precision)), unit=suffix)
    elif abs(value) >= .99e6 and abs(value) < .99e9:
        return _("{value} M{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-6, precision)), unit=suffix)
    elif abs(value) >= .99e9 and abs(value) < .99e12:
        return _("{value} G{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-12, precision)), unit=suffix)
    elif abs(value) >= .99e12:
        return _("{value} T{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-15, precision)), unit=suffix)

def unit_format_atten(value):
    """Print given value in V as a uV/div, mV/div, V/div or kV/div setting.  Input is as a voltage,
    floating point."""
    if value < 1e-3:
        return _("{vdiv:.0f} \u03BCV/div").format(vdiv=int(value * 1e6))
    elif value >= 1e-3 and value < 1: 
        return _("{vdiv:.0f} mV/div").format(vdiv=int(value * 1e3))
    elif value >= 1 and value < 1e3: 
        return _("{vdiv:.0f} V/div").format(vdiv=int(value))
    elif value >= 1e3: 
        return _("{vdiv:.0f} kV/div").format(vdiv=int(value * 1e-3))

def unit_format_voltage(value, precision=2):
    """Print given value as a voltage.  Precision option specifies how many significant digits to display."""
    # TRANSLATORS: Unit is 'voltage'
    return unit_format_suffix(value, _("V"), precision)
