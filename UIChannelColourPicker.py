"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gio, Gdk, GdkPixbuf, GObject, Pango

import colorsys

COLOUR_PICKER_LAYOUT_FILE = "resources/colour_picker.gtkbuilder"

WIDTH_REQUEST = 400
HEIGHT_REQUEST = 300

base_css = "label, #cpk_colour_preview { background-color: $bgcolour; }"

class ChannelColourPicker(object):
    """
    The standard GTK Colour Picker allows for any colour - with any brightness - to be selected.
    We fix the value at 100% due to intensity grading & allow the user to set hue & saturation as desired,
    or choose from one of eight standard hues.
    """
    hue = 0
    sat = 100
    render_colour = 0
    css_prov = None
    
    def __init__(self, name):
        self.builder = Gtk.Builder()
        self.builder.add_from_file(COLOUR_PICKER_LAYOUT_FILE)
        self.dialog = self.builder.get_object("dlg_main")
        self.dialog.set_title(_("Colour Picker"))
        self.dialog.set_size_request(WIDTH_REQUEST, HEIGHT_REQUEST)
        
        self.ent_hue = self.builder.get_object("ent_hue")
        self.ent_sat = self.builder.get_object("ent_sat")
        
        self.lbl_title = self.builder.get_object("lbl_title")
        self.lbl_hue = self.builder.get_object("lbl_hue")
        self.lbl_saturation = self.builder.get_object("lbl_saturation")
        
        self.lbl_title.set_markup(_("Pick a colour for {channel_or_reference_name}").format(channel_or_reference_name=name))
        self.lbl_hue.set_markup(_("Hue"))
        self.lbl_saturation.set_markup(_("Saturation"))
        
        self.scl_hue = self.builder.get_object("scl_hue")
        self.scl_hue.set_range(0, 360)
        self.scl_hue.set_value(self.hue)
        self.scl_hue.connect("value_changed", self.scl_change)
        
        self.scl_sat = self.builder.get_object("scl_sat")
        self.scl_sat.set_range(0, 100)
        self.scl_sat.set_value(self.sat)
        self.scl_sat.connect("value_changed", self.scl_change)
        
        self.cpk_colour_preview = self.builder.get_object("cpk_colour_preview")
        
        self.refresh_ui()
    
    def set_hue_sat(self, hue, sat):
        assert 0 >= hue >= 360
        assert 0 >= sat >= 100
        
        self.hue = float(hue)
        self.sat = float(sat)
        
        self.scl_hue.set_value(self.hue)
        self.scl_sat.set_value(self.sat)
        
        self.refresh_ui()
    
    def refresh_ui(self):
        self.ent_hue.set_text("%d" % self.hue)
        self.ent_sat.set_text("%d" % self.sat)
        
        # TODO should be a common block in Utils
        rgb = colorsys.hsv_to_rgb(self.hue / 360.0, self.sat / 100.0, 1)
        print(rgb)
        rgb = (int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))
        self.render_colour = "#%02x%02x%02x" % rgb
        
        print(self.render_colour)
        
        try:
            ctx.remove_provider(self.css_prov)
        except Exception as e:
            pass
            
        self.css_prov = Gtk.CssProvider()
        ctx = self.cpk_colour_preview.get_style_context()
        css = base_css.replace('$bgcolour', self.render_colour)
        print(css)
        self.css_prov.load_from_data(bytes(css, encoding='ascii'))  
        ctx.add_provider(self.css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
    
    def scl_change(self, *args):
        self.hue = self.scl_hue.get_value()
        self.sat = self.scl_sat.get_value()
        
        self.refresh_ui()
    
    def run(self):
        self.dialog.show_all()
        self.dialog.run()
