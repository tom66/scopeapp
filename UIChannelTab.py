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
import ScopeController as SC

CHANNEL_TAB_LAYOUT_FILE = "resources/channel_tab.gtkbuilder"
CHANNEL_TAB_CSS_FILE = "channel_tab.css"

# Supported channel names (long & short variants).  Translatable.
# Short name: max 5 characters
#
# TODO: Maybe load this from a .cfg file.
user_channel_names = [
    [_('SPI and Serial'), [
        # SPI/serial
        (_("Master Out"), _("MOSI")),
        (_("Slave Out"), _("MISO")),
        (_("Clock"), _("CLK")),
        (_("Slave Select"), _("SS")),
        (_("Chip Select"), _("CS")),
        (_("1-Wire Data"), _("1WD"))
    ]],
    
    # I2C
    [_('I\u00B2C'), [
        (_("I\u00B2C Clock"), _("SCL")),
        (_("I\u00B2C Data"), _("SDA")),
    ]],
    
    # UART
    [_('UART/RS232'), [
        (_("Transmit"), _("TX")),
        (_("Receive"), _("RX")),
        (_("Ready-to-Send"), _("RTS")),
        (_("Clear-to-Send"), _("CTS")),
        (_("Data Carrier Det."), _("DCD")),
        (_("Data Set Ready"), _("DSR")),
        (_("Data Terminal Ready"), _("DTR")),
        (_("Ring Indicator"), _("RING"))
    ]],
    
    # Power
    [_('Power'), [
        (_("Gate"), _("G")),
        (_("Drain"), _("D")),
        (_("Source"), _("S")),
        (_("Substrate"), _("SUB")),
        (_("Base"), _("B")),
        (_("Collector"), _("C")),
        (_("Emitter"), _("E")),
        (_("Cathode"), _("K")),
        (_("Anode"), _("A")),
        (_("Anode 1"), _("A1")),
        (_("Anode 2"), _("A2")),
        (_("Positive"), _("+ve")),
        (_("Negative"), _("-ve")),
        (_("Current"), _("I")),
        (_("Power"), _("W")),
        (_("Vdd"), _("Vdd")),
        (_("Vcc"), _("Vcc")),
        (_("Vee"), _("Vee")),
        (_("Vcore"), _("Vcore")),
        (_("15V"), _("15V")),
        (_("12V"), _("12V")),
        (_("9V"), _("9V")),
        (_("5V"), _("5V")),
        (_("3V3"), _("3V3")),
        (_("-5V"), _("-5V")),
        (_("-12V"), _("-12V")),
        (_("-15V"), _("-15V")),
        (_("Battery"), _("BATT")),
        (_("B+"), _("B+")),
    ]],
    
    # Other
    [_('Other'), [
        (_("Signal A"), _("A")),
        (_("Signal B"), _("B")),
        (_("Signal C"), _("C")),
        (_("Signal D"), _("D")),
        (_("Input"), _("IN")),
        (_("Output"), _("OUT")),
        (_("Acknowledge"), _("ACK")),
        (_("Address"), _("Addr")),
        (_("Bit"), _("BIT")),
        (_("Error"), _("Err")),
        (_("Position"), _("POS")),
        (_("RSSI"), _("RSSI")),
        (_("Temperature"), _("Temp")),
        (_("Demodulation"), _("Demod")),
        (_("Modulation"), _("Mod")),
        (_("Rel. Flux"), _("RFlux")),
        (_("Magn.-Reluctance"), _("MR")),
        (_("Cap. Diractance"), _("CDR")),
        (_("Fusion Chamber"), _("88mph"))
    ]]
]

class ChannelTab(object):
    last_enable_state = None
    
    cssprov = None
    
    def __init__(self, root_mgr, channel, notebook, index):
        self.channel = channel
        self.cfgmgr = root_mgr.cfgmgr
        self.root_mgr = root_mgr
        self.notebook = notebook
        self.notebook_index = index
        
        # Widgets whose sensitivity will be affected by channel enable/disable
        self.sensitive_widgets = []
        
        # Load the GtkBuilder file for the channel tab
        self.builder = Gtk.Builder()
        self.builder.add_from_file(CHANNEL_TAB_LAYOUT_FILE)
        self.vbox = self.builder.get_object("vbx_chan_container")
        self.vbox.get_style_context().add_class("channel_tab")
        self.vbox.set_hexpand(False)
        
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
        self.btn_chan_atten_up.connect("clicked", self._btn_atten_up_press)
        self.btn_chan_atten_down.connect("clicked", self._btn_atten_down_press)
        self.btn_chan_offset_up.connect("clicked", self._btn_offset_up_press)
        self.btn_chan_offset_down.connect("clicked", self._btn_offset_down_press)
        self.btn_chan_tog_coup_AC.connect("clicked", self._btn_coup_AC)
        self.btn_chan_tog_coup_DC.connect("clicked", self._btn_coup_DC)
        self.btn_chan_tog_coup_GND.connect("clicked", self._btn_coup_GND)
        self.chk_chan_coup_invert.connect("toggled", self._chkbtn_invert)
        self.chk_chan_coup_20M.connect("toggled", self._chkbtn_20M)
        self.chk_chan_coup_50R.connect("toggled", self._chkbtn_50R)
        
        self.btn_chan_tog_coup_AC_ctx = self.btn_chan_tog_coup_AC.get_style_context()
        self.btn_chan_tog_coup_DC_ctx = self.btn_chan_tog_coup_DC.get_style_context()
        self.btn_chan_tog_coup_GND_ctx = self.btn_chan_tog_coup_GND.get_style_context()
        
        self.cmb_chan_label = self.builder.get_object("cmb_chan_label")
        
        # Set channel toggle-switch state according to actual channel state on initialisation
        self.sw_chan_enabled.set_active(self.channel.is_enabled())
        
        # Create the TreeModel for the channel name options
        col_cell_text = Gtk.CellRendererText()
        col_category = Gtk.TreeViewColumn(_("Category"))
        col_category.pack_start(col_cell_text, True)
        col_category.add_attribute(col_cell_text, "text", 0)
        
        col_cell_text_long = Gtk.CellRendererText()
        col_name = Gtk.TreeViewColumn(_("Name"))
        col_name.pack_start(col_cell_text_long, True)
        col_name.add_attribute(col_cell_text_long, "text", 0)
        col_cell_text_long.set_property("ellipsize", Pango.EllipsizeMode.END)
        col_cell_text_long.set_property("ellipsize_set", True)
        col_cell_text_long.set_property("wrap_mode", Pango.WrapMode.WORD)
        col_cell_text_long.set_property("wrap_width", 50)
        col_cell_text_long.set_property("max_width_chars", 20)
        
        col_cell_text_short = Gtk.CellRendererText()
        col_short = Gtk.TreeViewColumn(_("Short"))
        col_short.pack_start(col_cell_text_short, True)
        col_short.add_attribute(col_cell_text_short, "text", 0)
        tree_store = Gtk.TreeStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
        
        # Add first item
        tree_store.append(None, [self.channel.internal_name, self.channel.default_long_name])
        
        # Add custom item
        tree_store.append(None, ["", _("Custom")])
        
        for cat in user_channel_names:
            sub_tree = tree_store.append(None, ["", cat[0]])
            for item in cat[1]:
                if item[1] == item[0]:
                    tree_store.append(sub_tree, ["", item[0]])
                else:
                    tree_store.append(sub_tree, [item[1], item[0]])
        
        self.cmb_chan_label.set_model(tree_store)
        self.cmb_chan_label.pack_start(col_cell_text_short, True)
        self.cmb_chan_label.add_attribute(col_cell_text_short, "text", 0)
        self.cmb_chan_label.pack_start(col_cell_text_long, True)
        self.cmb_chan_label.add_attribute(col_cell_text_long, "text", 1)
        self.cmb_chan_label.connect("changed", self._cmb_chan_label_changed)
        
        self.sensitive_widgets.append(self.cmb_chan_label)
        
        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(self.lbl_tab)
        self.lbl_btn.connect("clicked", self._tab_clicked)
        self.lbl_btn.show_all()
    
    def __user_exception_handler(func):
        def wrapper(self, *args):
            try:
                return func(self, *args)
            except Utils.UserRequestError as e:
                # Pass the higher-order exception back to the application root manager
                self.root_mgr._user_exception(e)
                return True # stop events being duplicated
        
        return wrapper
    
    @__user_exception_handler
    def _btn_atten_up_press(self, *args):
        # TODO: vernier mode
        self.channel.atten_up_coarse()
        return True
        
    @__user_exception_handler
    def _btn_atten_down_press(self, *args):
        # TODO: vernier mode
        self.channel.atten_down_coarse()
        return True
        
    @__user_exception_handler
    def _btn_offset_up_press(self, *args):
        # TODO: vernier mode
        self.channel.offset_up_coarse()
        return True
        
    @__user_exception_handler
    def _btn_offset_down_press(self, *args):
        # TODO: vernier mode
        self.channel.offset_down_coarse()
        return True
    
    def _btn_coup_AC(self, *args):
        self.channel.set_coupling(SC.COUP_AC)
    
    def _btn_coup_DC(self, *args):
        self.channel.set_coupling(SC.COUP_DC)
    
    def _btn_coup_GND(self, *args):
        self.channel.set_coupling(SC.COUP_GND)
    
    def _chkbtn_invert(self, widget, *args):
        self.channel.toggle_invert()
        widget.set_state(False)   # initially just disable the checkbutton; it's enabled by the state updater
        
    def _chkbtn_20M(self, widget, *args):
        self.channel.toggle_bandwidth_20M()
        widget.set_state(False)
    
    def _chkbtn_50R(self, widget, *args):
        self.channel.toggle_50_ohm_termination()
        widget.set_state(False)
    
    def _channel_switch_state_set(self, *args):
        # Sets the channel state to on or off according to the new switch state
        if self.sw_chan_enabled.get_active():
            self.sw_chan_enabled.set_state(True)
            self.channel.enable_channel()
        else:
            self.sw_chan_enabled.set_state(False)
            self.channel.disable_channel()
        
        return True
    
    def _cmb_chan_label_changed(self, *args):
        path = list(map(int, str(self.cmb_chan_label.get_model().get_path(self.cmb_chan_label.get_active_iter())).split(":")))
        if len(path) == 1:
            if path[0] == 0:
                print("Reset channel name to defaults")
                self.channel.set_channel_name_defaults()
            elif path[0] == 1:
                print("Request custom name - not currently supported")
        else:
            print("Request templated name")
            key = user_channel_names[path[0] - 2][1][path[1]]
            self.channel.set_channel_name_global(key[1], key[0])
    
    def _tab_clicked(self, *args):
        # Clicking a tab when the channel is not currently selected will select the tab
        # Clicking the tab when the channel is selected will toggle the channel enable state
        if (self.notebook.get_current_page() + 1) == self.notebook_index:
            self.channel.toggle_channel()
        else:
            self.notebook.set_current_page(self.notebook_index - 1)
    
    def _generate_css_provider(self, css, index, grad_pct_bkgnd, grad_pct, dk_colour, pri_colour):
        """
        Generates a CSS provider for dynamic styling of a channel tab.
        
        @FIXME  there may be a better way to do this, but I couldn't find it
        """
        css_prov = Gtk.CssProvider()
        data = open(css, "r").read()
        data = data.replace("$channel_gradpct_bkgrnd", grad_pct_bkgnd)
        data = data.replace("$channel_gradpct", grad_pct)
        data = data.replace("$channel_dkcolour", dk_colour)
        data = data.replace("$channel_colour", pri_colour)
        data = data.replace("$channel_index", str(index))
        css_prov.load_from_data(bytes(data, encoding='ascii'))  
        return css_prov
    
    def refresh_tab(self):
        self.lbl_tab.set_markup(self.channel.short_name)
        
        if self.channel.has_default_name():
            self.lbl_chan_name.set_markup(self.channel.long_name)
        else:
            self.lbl_chan_name.set_markup(_("{long_channel_name} ({short_internal_name})")\
                .format(long_channel_name=self.channel.long_name, short_internal_name=self.channel.internal_name))

        self.apply_css()
        
        # TODO: We need some way to read that channel enable state has changed externally and refresh
        # the state of the toggle switch
        
        # Sync the offset and attenuation fields
        self.lbl_chan_atten.set_markup(Utils.unit_format_atten(self.channel.get_computed_attenuation()))
        self.lbl_chan_offset.set_markup(Utils.unit_format_voltage(self.channel.offset, precision=2))
        
        # Adjust the coupling toggle-buttons 
        self.btn_chan_tog_coup_AC_ctx.add_class("button_off")
        self.btn_chan_tog_coup_DC_ctx.add_class("button_off")
        self.btn_chan_tog_coup_GND_ctx.add_class("button_off")
        self.btn_chan_tog_coup_AC_ctx.remove_class("button_on")
        self.btn_chan_tog_coup_DC_ctx.remove_class("button_on")
        self.btn_chan_tog_coup_GND_ctx.remove_class("button_on")
            
        if self.channel.get_coupling() == SC.COUP_AC:
            self.btn_chan_tog_coup_AC_ctx.add_class("button_on")
            self.btn_chan_tog_coup_AC_ctx.remove_class("button_off")
        elif self.channel.get_coupling() == SC.COUP_DC:
            self.btn_chan_tog_coup_DC_ctx.add_class("button_on")
            self.btn_chan_tog_coup_DC_ctx.remove_class("button_off")
        elif self.channel.get_coupling() == SC.COUP_GND:
            self.btn_chan_tog_coup_GND_ctx.add_class("button_on")
            self.btn_chan_tog_coup_GND_ctx.remove_class("button_off")
        
        # Apply the invert/20MHz/50ohm settings
        self.chk_chan_coup_invert.set_state(self.channel.get_invert())
        self.chk_chan_coup_20M.set_state(self.channel.get_bandwidth_20M())
        self.chk_chan_coup_50R.set_state(self.channel.get_50_ohm_termination())
        
        # If the channel is disabled, then all the controls related to the channel are also disabled
        sens = self.channel.is_enabled()
        
        if sens != self.last_enable_state:
            self.sw_chan_enabled.set_active(sens)
            self.last_enable_state = sens
        
        for wdg in self.sensitive_widgets:
            wdg.set_sensitive(sens)
    
    def get_css_provider(self, index):
        # Generate different style for enabled/disabled channels
        if self.channel.enabled:
            css_file = self.cfgmgr['Theme']['ResourceDir'] + CHANNEL_TAB_CSS_FILE
            css = self._generate_css_provider(css_file, index, \
                self.cfgmgr['Theme']['ChannelBkgndGradePct'], \
                self.cfgmgr['Theme']['ChannelTabEnabledGradePct'], \
                self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelTabEnabledShade'])), \
                self.channel.get_hex_colour(1.0))
        else:
            css_file = self.cfgmgr['Theme']['ResourceDir'] + CHANNEL_TAB_CSS_FILE
            css = self._generate_css_provider(css_file, index, \
                self.cfgmgr['Theme']['ChannelBkgndGradePct'], \
                self.cfgmgr['Theme']['ChannelTabGradePct'], \
                self.channel.get_hex_colour(float(self.cfgmgr['Theme']['ChannelTabShade'])), \
                self.channel.get_hex_colour(1.0))
        
        return css
    
    def append_to_notebook(self):
        self.notebook.append_page(self.get_embedded_container(), self.get_embedded_label())
    
    def apply_css(self):
        nb_ctx = self.notebook.get_style_context()
        vb_ctx = self.vbox.get_style_context()
        
        try:
            nb_ctx.remove_provider(self.css_prov)
            vb_ctx.remove_provider(self.css_prov)
        except Exception as e:
            pass
        
        self.css_prov = self.get_css_provider(self.notebook_index)
        
        nb_ctx.add_provider(self.css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
        vb_ctx.add_provider(self.css_prov, Gtk.STYLE_PROVIDER_PRIORITY_USER)
    
    def get_embedded_label(self):
        return self.lbl_btn #event_box
    
    def get_embedded_container(self):
        return self.vbox
