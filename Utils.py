"""
This file is part of YAOS and is licenced under the MIT licence.

Common utilities used by multiple submodules.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import GdkPixbuf

import math, colorsys, logging

# Quantify library: https://pypi.org/project/quantiphy/
from quantify import Quantity

log = logging.getLogger()

APP_VERSION_MAJOR = 0
APP_VERSION_MINOR = 1

# This class should probably be renamed to be a more general warning/error rather than a user initiated one
# as SystemUnstable is not caused (necessarily) by user input.
class UserRequestError(Exception): pass
class UserRequestOutOfRange(UserRequestError): pass
class UserRequestUnsupported(UserRequestError): pass
class SystemUnstable(UserRequestError): pass
class StateSaveFileCorrupted(UserRequestError): pass

class ObjectUnpickled(Exception): pass

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
    
    def safe_pickle(self):
        return "Unit:%s" % self.__class__.__name__
    
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

def unit_unpickle(pickle_str):
    if pickle_str.startswith("Unit:"):
        parts = pickle_str.split(":")
        for unit in supported_units:
            if unit.__name__ == parts[1]:
                return unit()
    
    # otherwise...
    return None

def get_hex_colour_hsv(h, s, v):
    return "#%02x%02x%02x" % get_rgb_colour_hsv(h, s, v)

def get_rgb_colour_hsv(h, s, v):
    rgb = colorsys.hsv_to_rgb(h / 360.0, s, v)
    return (int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))

def get_hue_fg_colour(h, s, v):
    """Returns the best foreground colour for a given background colour (black or white.)"""
    if s > 0.6:
        if h > 20 and h <= 200:
            return "black"
    elif s <= 0.6:
        if v > 0.8:
            return "black"
    
    return "white"
   
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
    """
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
        return _("{value} G{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-9, precision)), unit=suffix)
    elif abs(value) >= .99e12:
        return _("{value} T{unit}").format(value=float_trail_free(round_sig_figs(value * 1e-12, precision)), unit=suffix)
    """

    return Quantity(value).render(suffix, prec=precision)

def unit_format_atten(value, suffix):
    """Print given value (e.g. V) as a uV/div, mV/div, V/div or kV/div setting.  Input is floating point."""
    # TRANSLATORS: SI units generally are not translated, please check carefully before translating.
    if value >= 1e-12 and value < 1e-9:
        return _("{vdiv:.0f} p{unit}/div").format(vdiv=int(value * 1e12), unit=suffix)
    elif value >= 1e-9 and value < 1e-6:
        return _("{vdiv:.0f} n{unit}/div").format(vdiv=int(value * 1e9), unit=suffix)
    elif value >= 1e-6 and value < 1e-3:
        return _("{vdiv:.0f} \u03BC{unit}/div").format(vdiv=int(value * 1e6), unit=suffix)
    elif value >= 1e-3 and value < 1: 
        return _("{vdiv:.0f} m{unit}/div").format(vdiv=int(value * 1e3), unit=suffix)
    elif value >= 1 and value < 1e3: 
        return _("{vdiv:.0f} {unit}/div").format(vdiv=int(value), unit=suffix)
    elif value >= 1e3 and value < 1e6: 
        return _("{vdiv:.0f} k{unit}/div").format(vdiv=int(value * 1e-3), unit=suffix)
    elif value >= 1e6 and value < 1e9: 
        return _("{vdiv:.0f} M{unit}/div").format(vdiv=int(value * 1e-6), unit=suffix)

def unit_format_suffix_handle_exc(value, suffix, precision=2):
    """Print a given value but handle None and exceptions during processing."""
    if value is None:
        # TRANSLATORS: do not translate {unit};  "None" is equivalent to "Not Applicable" or "No Value"
        return _("[None] {unit}").format(unit=suffix)
    else:
        try:
            return unit_format_suffix(value, suffix, precision)
        except Exception as e:
            log.error(_("Exception during unit_format_suffix_handle_exc: {0}").format())
            
            # TRANSLATORS: do not translate {unit};  "Exc is equivalent to "Error"/"Exception"
            return _("[EXC] {unit}").format(unit=suffix)
    
def unit_format_voltage(value, precision=2):
    """Print given value as a voltage.  Precision option specifies how many significant digits to display."""
    # TRANSLATORS: Unit is 'voltage'
    return unit_format_suffix(value, _("V"), precision)

def value_20_log_db(ratio, precision=0):
    # TRANSLATORS: Unitless - decibels.  Check engineering terminology carefully.
    return _("{ratio:.{prec}f} dB").format(ratio=(20 * math.log10(ratio)), prec=precision)

def pack_dict_json(obj, vars_):
    """
    Generate a dict of objects safe to pack into a JSON structure for storage.
    """
    vars_ = vars_.keys()
    json_dict = {}
    
    for v in vars_:
        try:
            x = getattr(obj, v)
            if isinstance(x, (int, float, str)):
                json_dict[v] = x
            else:
                json_dict[v] = x.safe_pickle()
        except Exception as e:
            log.error("In pack_dict_json(): unpickable: %r" % e)
            json_dict[v] = ObjectUnpickled(str(e))

    return json_dict

def unpack_json(obj, json_dict, vars_):
    """
    Process values in a dict and unpack into an object, safely.
    """
    seen = []
    safed = {}
    
    for key, value in json_dict.items():
        k = str(key)
        
        if k not in vars_:
            raise StateSaveFileCorrupted(_("Unable to restore configuration file: Unknown key '%s' (old version?)" % k))
        
        seen.append(k)
        typing = vars_[k]
        
        # skip if item not required
        if typing[0] == False:
            continue
        
        #print(typing)
        
        if not isinstance(value, tuple(typing[0])):
            raise StateSaveFileCorrupted(_("Unable to restore configuration file: Invalid type for '%s' (old version?)" % k))
        
        if typing[0] == (bool,):
            #print("bool value", key, value, bool(value))
            value = bool(value)
        else:
            if typing[0] == (str,):
                if len(value) > typing[1]:
                    raise StateSaveFileCorrupted(_("Unable to restore configuration file: Value excessively long"))
            elif len(typing) == 3:
                if value < typing[1] or value > typing[2]:
                    raise StateSaveFileCorrupted(_("Unable to restore configuration file: Value out of range for '%s'" % k))
        
        safed[k] = value
    
    for key in vars_.keys():
        if key not in seen:
            raise StateSaveFileCorrupted(_("Unable to restore configuration file: Not all configuration values present"))
    
    for key, value in safed.items():
        #print(obj, key, value)
        setattr(obj, str(key), value)

def clamp(y, lo, hi):
    """Clip argument `y` so that it lies between the bounds `lo` and `hi` exclusively.  `lo` < `hi` for correct operation."""
    return max(lo, min(y, hi))

def set_svg_image(widget, file, size):
    """Set a widget GtkImage with an SVG image of a given size."""
    pb = GdkPixbuf.Pixbuf.new_from_file_at_scale(file, size, size, 1)
    widget.set_from_pixbuf(pb)
