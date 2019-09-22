"""
This file is part of YAOS and is licenced under the MIT licence.

Common utilities used by multiple submodules.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import math

# Supported units
class Unit(object):
    _short = "?"
    _category = "???????"
    
    def unit_format(self, value, precision=2):
        return unit_format_suffix(value, self._short, precision)

    def unit_format_atten(self, value):
        return unit_format_atten(value, self._short)

    def get_short_name(self):
        return self._short
    
    def get_category(self):
        return self._category
    
    def get_long_name(self, num):
        raise ValueError("base class Unit not a valid unit")
    
class UnitVolt(Unit):
    _short = _("V")
    _category = _("Voltage")

    def get_long_name(self, num):
        return gettext.ngettext("volt", "volts", num)

class UnitAmp(Unit):
    _short = _("A")
    _category = _("Current")

    def get_long_name(self, num):
        return gettext.ngettext("amp", "amperes", num)

class UnitWatt(Unit):
    _short = _("W")
    _category = _("Power")

    def get_long_name(self, num):
        return gettext.ngettext("watt", "watts", num)

supported_units = [UnitVolt, UnitAmp, UnitWatt]
        
class UserRequestError(Exception): pass
class UserRequestOutOfRange(UserRequestError): pass
class UserRequestUnsupported(UserRequestError): pass

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

def unit_format_atten(value, suffix):
    """Print given value (e.g. V) as a uV/div, mV/div, V/div or kV/div setting.  Input is floating point."""
    if value < 1e-3:
        return _("{vdiv:.0f} \u03BC{unit}/div").format(vdiv=int(value * 1e6), unit=suffix)
    elif value >= 1e-3 and value < 1: 
        return _("{vdiv:.0f} m{unit}/div").format(vdiv=int(value * 1e3), unit=suffix)
    elif value >= 1 and value < 1e3: 
        return _("{vdiv:.0f} {unit}/div").format(vdiv=int(value), unit=suffix)
    elif value >= 1e3: 
        return _("{vdiv:.0f} k{unit}/div").format(vdiv=int(value * 1e-3), unit=suffix)

def unit_format_voltage(value, precision=2):
    """Print given value as a voltage.  Precision option specifies how many significant digits to display."""
    # TRANSLATORS: Unit is 'voltage'
    return unit_format_suffix(value, _("V"), precision)

def value_20_log_db(ratio, precision=0):
    return _("{ratio:.{prec}f} dB").format(ratio=(20 * math.log10(ratio)), prec=precision)
