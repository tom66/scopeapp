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
import ScopeController
import CSSManager

CHANNEL_WIDGET_CSS_FILE = "channel_widget.css"

class ChannelWidget(object):
    def __init__(self, root_mgr, channel):
        self.channel = channel
        self.cfgmgr = root_mgr.cfgmgr
        self.root_mgr = root_mgr
        
        self.container = Gtk.Box()
        
        self.label_left = Gtk.Label()
        self.label_left.set_selectable(True)
        self.label_modes = Gtk.Label()
        self.label_right = Gtk.Label()
        self.label_right.set_selectable(True)
        
        self.container.pack_end(self.label_right, True, True, 0)
        self.container.pack_end(self.label_modes, True, True, 0)
        self.container.pack_end(self.label_left, True, True, 0)
        
        self.css_manager = CSSManager.CSSManager(self.cfgmgr['Theme']['ResourceDir'] + CHANNEL_WIDGET_CSS_FILE)
        self.css_manager.set_variable("channel_colour", "#000000")
        self.css_manager.set_variable("channel_dkcolour", "#000000")
        self.css_manager.add_widget(self.label_left, "cwdg_left")
        self.css_manager.add_widget(self.label_modes, "cwdg_mid")
        self.css_manager.add_widget(self.label_right, "cwdg_right")
        
        self.refresh_widget()
    
    def refresh_widget(self):
        self.label_left.set_markup(self.channel.short_name)
        
        if self.channel.get_coupling() == ScopeController.COUP_DC:
            self.label_modes.set_markup(u"\u2393")
        elif self.channel.get_coupling() == ScopeController.COUP_AC:
            self.label_modes.set_markup("~")
        elif self.channel.get_coupling() == ScopeController.COUP_GND:
            self.label_modes.set_markup(u"\u23DA")
        
        self.label_right.set_markup(self.channel.get_unit().unit_format_atten(self.channel.get_computed_attenuation()))
        
        if self.channel.enabled:
            self.css_manager.set_variable("channel_colour",   self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelWidgetEnabledMain'])))
            self.css_manager.set_variable("channel_dkcolour", self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelWidgetEnabledShade'])))
        else:
            self.css_manager.set_variable("channel_colour",   self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelWidgetDisabledMain'])))
            self.css_manager.set_variable("channel_dkcolour", self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelWidgetDisabledShade'])))

        self.css_manager.refresh_css()
        
    def get_embedded_container(self):
        return self.container