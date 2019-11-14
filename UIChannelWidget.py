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

import copy

import Utils
import ScopeController
import CSSManager

CHANNEL_WIDGET_CSS_FILE = "channel_widget.css"

class ChannelWidget(object):
    def __init__(self, root_mgr, channel):
        self.channel = channel
        self.cfgmgr = root_mgr.cfgmgr
        self.root_mgr = root_mgr
        
        self.event_box = Gtk.EventBox()
        self.container = Gtk.Box()
        
        self.label_left = Gtk.Label()
        self.label_modes = Gtk.Label()
        self.label_right = Gtk.Label()
        #self.label_right.set_selectable(True)
        
        self.container.pack_end(self.label_right, True, True, 0)
        self.container.pack_end(self.label_modes, True, True, 0)
        self.container.pack_end(self.label_left, True, True, 0)
        
        self.css_manager = CSSManager.CSSManager(CHANNEL_WIDGET_CSS_FILE)
        self.css_manager.set_variable("channel_colour", "#000000")
        self.css_manager.set_variable("channel_dkcolour", "#000000")
        self.css_manager.add_widget(self.label_left, "cwdg_left")
        self.css_manager.add_widget(self.label_modes, "cwdg_mid")
        self.css_manager.add_widget(self.label_right, "cwdg_right")
        
        self.event_box.add(self.container)
        self.event_box.connect("button-press-event", self.widget_clicked)
        
        self.new_state = self.make_state()
        self.last_state = None
        
        self.refresh_widget()
    
    def make_state(self):
        """Generate a state tuple;  this is compared against older states to see if any
        settings have changed & if a refresh is needed."""
        return copy.copy(vars(self.channel),)
    
    def widget_clicked(self, *args):
        # Send the channel click signal to the root_mgr
        self.root_mgr.channel_widget_click(self.channel)
    
    def refresh_widget(self):
        # Don't refresh widget if Nothing Has Changed
        self.new_state = self.make_state()
        if self.new_state == self.last_state:
            return
        self.last_state = self.new_state
        
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
        return self.event_box