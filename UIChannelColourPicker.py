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

import Utils

COLOUR_PICKER_LAYOUT_FILE = "resources/colour_picker.gtkbuilder"

WIDTH_REQUEST = 500
HEIGHT_REQUEST = 400

base_css = """
#cpk_colour_preview { 
    background-color: $bgcolour; 
}

#dlg_colour_picker scale.sat trough {
    background-size: cover;
    background-image: linear-gradient(90deg, #ffffff 0%, $bgcolour 100%);
    border: 1px solid #202020;
}"""

button_css = """
button {
    background-color: $bgcolour;
    background-image: none;
    margin-right: 10px;
    border: 1px solid #202020;
}

button:last-child {
    margin-right: 0px;
}
"""

default_colour_count = 9
default_saturation = 0.85

class ChannelColourPicker(object):
    """
    The standard GTK Colour Picker allows for any colour - with any brightness - to be selected.
    We fix the value at 100% due to intensity grading & allow the user to set hue & saturation as desired,
    or choose from one of eight standard hues.
    """
    hue = 0
    sat = 1
    old_hue = 0
    old_sat = 1
    
    render_colour = 0
    css_prov = None
    
    scl_inhibit = True
    
    default_colour_widgets = []
    default_colours = []
   
    def __init__(self, name):
        self.builder = Gtk.Builder()
        self.builder.add_from_file(COLOUR_PICKER_LAYOUT_FILE)
        self.dialog = self.builder.get_object("dlg_main")
        self.dialog.set_title(_("Colour Picker"))
        self.dialog.set_size_request(WIDTH_REQUEST, HEIGHT_REQUEST)
        self.dialog.connect("response", self.dialog_response)
        
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
        self.scl_hue.set_value(0)
        self.scl_hue.connect("value_changed", self.scl_change)
        
        self.scl_sat = self.builder.get_object("scl_sat")
        self.scl_sat.set_range(0, 100)
        self.scl_sat.set_value(0)
        self.scl_sat.connect("value_changed", self.scl_change)
        
        self.btn_ok = self.builder.get_object("btn_ok")
        self.btn_ok.set_label(_("OK"))
        self.btn_ok.connect("clicked", self.btn_ok_clicked)
        
        self.btn_cancel = self.builder.get_object("btn_cancel")
        self.btn_cancel.set_label(_("Cancel"))
        self.btn_cancel.connect("clicked", self.btn_cancel_clicked)
        
        self.ent_hue = self.builder.get_object("ent_hue")
        self.ent_hue.connect("key-press-event", self.ent_change)
        self.ent_hue.connect("key-release-event", self.ent_change)
        self.ent_sat = self.builder.get_object("ent_sat")
        self.ent_sat.connect("key-press-event", self.ent_change)
        self.ent_sat.connect("key-release-event", self.ent_change)
        
        self.cpk_colour_preview = self.builder.get_object("cpk_colour_preview")
        self.box_default_colours = self.builder.get_object("box_default_colours")
        
        # Add pre-defined colours
        for col in range(default_colour_count):
            hue = (360.0 / default_colour_count) * col
            sat = default_saturation
            self.default_colours.append((hue, sat))
            
            btn = Gtk.Button()
            self.default_colour_widgets.append(btn)
            self.box_default_colours.pack_end(btn, True, True, 0)
            btn.connect("clicked", self.btn_default_colour_clicked)
            
            css = button_css.replace('$bgcolour', Utils.get_hex_colour_hsv(hue, sat, 1))
            
            css_prov = Gtk.CssProvider()
            css_prov.load_from_data(bytes(css, encoding='ascii'))  
            
            btn.get_style_context().add_provider(css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        
        self.refresh_ui()
    
    def dialog_response(self, wdg, resp):
        if resp == Gtk.ResponseType.CLOSE:
            self.btn_cancel_clicked(None)
    
    def btn_default_colour_clicked(self, wdg):
        for n, btn in enumerate(self.default_colour_widgets):
            if btn == wdg:
                self.set_hue_sat(*self.default_colours[n])
    
    def btn_ok_clicked(self, *args):
        print("btn_ok_clicked")
        self.dialog.response(Gtk.ResponseType.OK)
        self.dialog.close()
    
    def btn_cancel_clicked(self, *args):
        print("btn_cancel_clicked")
        self.set_hue_sat(self.old_hue, self.old_sat)
        self.dialog.response(Gtk.ResponseType.Cancel)
        self.dialog.close()
    
    def get_hue_sat(self):
        return (self.hue, self.sat)
    
    def ent_change(self, wdg, event):
        if wdg == self.ent_hue:
            try:
                text = wdg.get_text()
                if len(text) == 0:
                    val = 0-1
                else:
                    val = float(text)
                    val = min(val, 360)
                    val = max(0, val)
                self.set_hue_sat(val, self.sat)
            except ValueError:
                wdg.set_text("%d" % self.hue)
        elif wdg == self.ent_sat:
            try:
                text = wdg.get_text()
                if len(text) == 0:
                    val = 0-1
                else:
                    val = float(text)
                    val = min(val, 100)
                    val = max(0, val)
                self.set_hue_sat(self.hue, val * 0.01)
            except ValueError:
                wdg.set_text("%d" % self.sat)
    
    def set_hue_sat(self, hue, sat):
        """Set the hue and saturation, from a channel setting or a default colour.
        
        Hue is from 0-360 and saturation from 0-1.
        
        These values are recorded as the default. If Cancel is pressed or
        the close button clicked, the default values are returned instead."""
        assert 0 <= hue <= 360
        assert 0 <= sat <= 1
        
        print(hue, sat)
        
        self.hue = float(hue)
        self.sat = float(sat)
        self.old_hue = self.hue
        self.old_sat = self.sat
        
        print("Set internal I:", (self.hue, self.sat))
        
        self.scl_inhibit = True
        self.scl_hue.set_value(self.hue)
        self.scl_sat.set_value(self.sat * 100)
        self.scl_inhibit = False
        
        print("Set internal II:", (self.hue, self.sat))
        
        self.refresh_ui()
    
    def refresh_ui(self):
        self.ent_hue.set_text("%d" % self.hue)
        self.ent_sat.set_text("%d" % (self.sat * 100))
        
        # TODO should be a common block in Utils
        rgb = colorsys.hsv_to_rgb(self.hue / 360.0, self.sat, 1)
        rgb = (int(rgb[0] * 255), int(rgb[1] * 255), int(rgb[2] * 255))
        self.render_colour = "#%02x%02x%02x" % rgb
        
        try:
            ctx.remove_provider(self.css_prov)
        except Exception as e:
            pass
            
        css = base_css.replace('$bgcolour', self.render_colour)
        
        self.css_prov = Gtk.CssProvider()
        self.css_prov.load_from_data(bytes(css, encoding='ascii'))  
        
        self.cpk_colour_preview.get_style_context().add_provider(self.css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        self.scl_sat.get_style_context().add_provider(self.css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        
        print(css)
    
    def scl_change(self, *args):
        if self.scl_inhibit:
            return
            
        self.hue = self.scl_hue.get_value()
        self.sat = self.scl_sat.get_value() * 0.01
        
        self.refresh_ui()
    
    def run(self):
        self.dialog.show_all()
        self.dialog.run()
        print("Done, resp:", self.get_hue_sat())
        return self.get_hue_sat()
