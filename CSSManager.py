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

import Utils

class CSSManager(object):
    vars = {}
    wdgs = []
    old_css_prov = None
    var_change = False
    
    def __init__(self, input_file):
        self.vars = {}
        self.wdgs = []
        self.input_data = open(input_file, "r").read()
        self.var_change = True
    
    def set_variable(self, key, value):
        if key in self.vars.keys():
            if self.vars[key] != value:
                self.var_change = True
                
        self.vars[key] = value
    
    def add_widget(self, wdg, cls):
        self.wdgs.append(wdg)
        if cls != None:
            wdg.get_style_context().add_class(cls)
    
    def refresh_css(self):
        # If nothing has changed, don't bother refreshing
        if not self.var_change:
            return
        
        css_prov = Gtk.CssProvider()
        
        data = str(self.input_data)
        for key, var in self.vars.items():
            data = data.replace("$%s$" % key, str(var))
        
        css_prov.load_from_data(bytes(data, encoding='ascii'))  
        
        for wdg in self.wdgs:
            if self.old_css_prov is not None:
                wdg.get_style_context().remove_provider(self.old_css_prov)
            
            wdg.get_style_context().add_provider(css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        
        self.old_css_prov = css_prov
