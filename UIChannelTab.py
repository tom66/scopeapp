"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gio, Gdk, GdkPixbuf

import random

CHANNEL_TAB_LAYOUT_FILE = "resources/channel_tab.gtkbuilder"
CHANNEL_TAB_CSS_FILE = "channel_tab.css"

class ChannelTab(object):
    def __init__(self, cfgmgr, channel, notebook, index):
        self.cfgmgr = cfgmgr
        self.channel = channel
        self.notebook = notebook
        self.notebook_index = index
        
        # Widgets whose sensitivity will be affected by channel enable/disable
        self.sensitive_widgets = []
        
        # Load the GtkBuilder file for the channel tab
        self.builder = Gtk.Builder()
        self.builder.add_from_file(CHANNEL_TAB_LAYOUT_FILE)
        self.vbox = self.builder.get_object("vbx_chan_container")
        
        # Extract connections to important widgets
        self.lbl_chan_name = self.builder.get_object("lbl_chan_name")
        self.sw_chan_enabled = self.builder.get_object("sw_chan_enabled")
        self.btn_chan_atten_up = self.builder.get_object("btn_chan_atten_up")
        self.btn_chan_atten_down = self.builder.get_object("btn_chan_atten_down")
        self.btn_chan_offset_up = self.builder.get_object("btn_chan_offset_up")
        self.btn_chan_offset_down = self.builder.get_object("btn_chan_offset_down")
        self.lbl_chan_atten = self.builder.get_object("lbl_chan_atten")
        self.lbl_chan_offset = self.builder.get_object("lbl_chan_offset")
        self.btn_chan_tog_coup_AC = self.builder.get_object("btn_chan_tog_coup_AC")
        self.btn_chan_tog_coup_DC = self.builder.get_object("btn_chan_tog_coup_DC")
        self.btn_chan_tog_coup_GND = self.builder.get_object("btn_chan_tog_coup_GND")
        self.chk_chan_coup_invert = self.builder.get_object("chk_chan_coup_invert")
        self.chk_chan_coup_20M = self.builder.get_object("chk_chan_coup_20M")
        self.chk_chan_coup_50R = self.builder.get_object("chk_chan_coup_50R")
        
        self.sensitive_widgets.append(self.btn_chan_atten_up)
        self.sensitive_widgets.append(self.btn_chan_atten_down)
        self.sensitive_widgets.append(self.btn_chan_offset_up)
        self.sensitive_widgets.append(self.btn_chan_offset_down)
        self.sensitive_widgets.append(self.btn_chan_tog_coup_AC)
        self.sensitive_widgets.append(self.btn_chan_tog_coup_DC)
        self.sensitive_widgets.append(self.btn_chan_tog_coup_GND)
        self.sensitive_widgets.append(self.chk_chan_coup_invert)
        self.sensitive_widgets.append(self.chk_chan_coup_20M)
        self.sensitive_widgets.append(self.chk_chan_coup_50R)
        
        self.sw_chan_enabled.connect("state-set", self._channel_switch_state_set)
        
        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(self.lbl_tab)
        self.lbl_btn.connect("clicked", self._tab_clicked)
        self.lbl_btn.show_all()
    
    def _channel_switch_state_set(self, *args):
        # Sets the channel state to on or off according to the new switch state
        if self.sw_chan_enabled.get_active():
            self.channel.enable_channel()
        else:
            self.channel.disable_channel()
    
    def _tab_clicked(self, *args):
        # Clicking a tab when the channel is not currently selected will select the tab
        # Clicking the tab when the channel is selected will toggle the channel enable state
        if (self.notebook.get_current_page() + 1) == self.notebook_index:
            self.channel.toggle_channel()
        else:
            self.notebook.set_current_page(self.notebook_index - 1)
    
    def _generate_css_provider(self, css, index, grad_pct, dk_colour, pri_colour):
        """
        Generates a CSS provider for dynamic styling of a channel tab
        """
        css_prov = Gtk.CssProvider()
        data = open(css, "r").read()
        data = data.replace("$channel_gradpct", grad_pct)
        data = data.replace("$channel_dkcolour", dk_colour)
        data = data.replace("$channel_colour", pri_colour)
        data = data.replace("$channel_index", str(index))
        css_prov.load_from_data(bytes(data, encoding='ascii'))  
        return css_prov
    
    def refresh_tab(self):
        self.lbl_tab.set_markup(self.channel.short_name)
        self.lbl_chan_name.set_markup(self.channel.long_name)
        self.apply_css()
        
        # If the channel is disabled, then all the controls related to the channel are also disabled
        sens = self.channel.is_enabled()
        for wdg in self.sensitive_widgets:
            print(wdg)
            wdg.set_sensitive(sens)
        
        self.sw_chan_enabled.set_active(sens)
        
    def get_css_provider(self, index):
        # Generate different style for enabled/disabled channels
        if self.channel.enabled:
            css_file = self.cfgmgr['Theme']['ResourceDir'] + CHANNEL_TAB_CSS_FILE
            css = self._generate_css_provider(css_file, index, \
                self.cfgmgr['Theme']['ChannelTabEnabledGradePct'], \
                self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelTabEnabledShade'])), \
                self.channel.get_hex_colour(1.0))
        else:
            css_file = self.cfgmgr['Theme']['ResourceDir'] + CHANNEL_TAB_CSS_FILE
            css = self._generate_css_provider(css_file, index, \
                self.cfgmgr['Theme']['ChannelTabGradePct'], \
                self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelTabShade'])), \
                self.channel.get_hex_colour(1.0))
        
        return css
    
    def append_to_notebook(self):
        self.notebook.append_page(self.get_embedded_container(), self.get_embedded_label())
    
    def apply_css(self):
        ctx = self.notebook.get_style_context()
        ctx.add_provider(self.get_css_provider(self.notebook_index), Gtk.STYLE_PROVIDER_PRIORITY_USER)
    
    def get_embedded_label(self):
        return self.lbl_btn #event_box
    
    def get_embedded_container(self):
        return self.vbox
