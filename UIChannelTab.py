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
import UIChannelColourPicker
import UIController
import CSSManager

import copy

CHANNEL_TAB_LAYOUT_FILE = "resources/channel_tab.gtkbuilder"
CHANNEL_TAB_CSS_FILE = "channel_tab.css"

NAME_SIZE_THRESH = 18

ATTEN_UNIT_X = 1
ATTEN_UNIT_DB = 2

# Supported probe options
probe_atten_options = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000]

# Supported channel names (long & short variants).  Translatable.
# Short name: max 5 characters
#
# TODO: This should be loaded from a .cfg file.
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
        (_("Vcore"), _("Vcre")),
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
        (_("Demodulation"), _("DMod")),
        (_("Modulation"), _("Mod")),
        (_("Magneto-Reluctance"), _("MR")),
        (_("Capacitive Diractance"), _("CDR")),
        (_("Fusion Chamber"), _("88MI"))
    ]]
]

probe_atten_options = sorted(probe_atten_options)

class ChannelTab(object):
    last_enable_state = None
    cssprov = None
    
    atten_update = True
    atten_unit_update = True
    atten_unit = ATTEN_UNIT_X
    atten_init = False
    
    init_refresh = False
    
    last_state = None
    now_state = None
    
    _chk_sensitive = True
    
    def __init__(self, root_mgr, channel_index, notebook, index):
        self.channel_index = channel_index
        self.cfgmgr = root_mgr.cfgmgr
        self.root_mgr = root_mgr
        self.notebook = notebook
        self.notebook_index = index
        self.channel = self.root_mgr.ctrl.channels[self.channel_index]
        
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
        self.cmb_probe_atten = self.builder.get_object("cmb_probe_atten")
        self.btn_probe_atten_units = self.builder.get_object("btn_probe_atten_units")
        self.btn_chan_probe_V = self.builder.get_object("btn_chan_probe_V")
        self.btn_chan_probe_A = self.builder.get_object("btn_chan_probe_A")
        self.btn_chan_probe_other = self.builder.get_object("btn_chan_probe_other")
        self.btn_chan_colour = self.builder.get_object("btn_chan_colour")
        
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
        self.sensitive_widgets.append(self.cmb_probe_atten)
        self.sensitive_widgets.append(self.btn_probe_atten_units)
        self.sensitive_widgets.append(self.btn_chan_probe_V)
        self.sensitive_widgets.append(self.btn_chan_probe_A)
        self.sensitive_widgets.append(self.btn_chan_probe_other)
        self.sensitive_widgets.append(self.btn_chan_colour)
        
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
        self.cmb_probe_atten.connect("changed", self._cmb_probe_atten_changed)
        self.btn_probe_atten_units.connect("clicked", self._btn_probe_atten_units_press)
        self.btn_chan_probe_V.connect("clicked", self._btn_chan_probe_V_press)
        self.btn_chan_probe_A.connect("clicked", self._btn_chan_probe_A_press)
        self.btn_chan_probe_other.connect("clicked", self._btn_chan_probe_other_press)
        self.btn_chan_colour.connect("clicked", self._btn_chan_colour_press)
        
        # i10n
        self.btn_chan_tog_coup_AC.set_label(_("AC"))
        self.btn_chan_tog_coup_DC.set_label(_("DC"))
        self.btn_chan_tog_coup_GND.set_label(_("GND"))
        self.chk_chan_coup_invert.set_label(_("Invert"))
        self.chk_chan_coup_20M.set_label(_("20 MHz Filter"))
        self.chk_chan_coup_50R.set_label(_("50\u03A9 Impedance"))
        self.btn_chan_probe_other.set_label(_("..."))
        self.btn_probe_atten_units.set_label("")
        
        self.btn_chan_colour_label = Gtk.Label()
        self.btn_chan_colour.add(self.btn_chan_colour_label)
        self.btn_chan_colour_label.set_markup(_("Colour"))
        
        self.btn_chan_tog_coup_AC_ctx = self.btn_chan_tog_coup_AC.get_style_context()
        self.btn_chan_tog_coup_DC_ctx = self.btn_chan_tog_coup_DC.get_style_context()
        self.btn_chan_tog_coup_GND_ctx = self.btn_chan_tog_coup_GND.get_style_context()
        self.btn_chan_probe_V_ctx = self.btn_chan_probe_V.get_style_context()
        self.btn_chan_probe_A_ctx = self.btn_chan_probe_A.get_style_context()
        self.btn_chan_probe_other_ctx = self.btn_chan_probe_other.get_style_context()
        self.lbl_chan_name_ctx = self.lbl_chan_name.get_style_context()
        
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
        self.cmb_chan_label.set_active(0)
        self.cmb_chan_label.connect("changed", self._cmb_chan_label_changed)
        
        self.sensitive_widgets.append(self.cmb_chan_label)
        
        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(self.lbl_tab)
        self.lbl_btn.connect("clicked", self.tab_clicked)
        self.lbl_btn.show_all()
        
        # Add all relevant widgets to the CSS manager
        self.css_manager = CSSManager.CSSManager(CHANNEL_TAB_CSS_FILE)
        self.css_manager.add_widget(self.notebook, None)
        self.css_manager.add_widget(self.vbox, None)
        self.css_manager.add_widget(self.btn_chan_colour, "channel_button_color")
        self.css_manager.add_widget(self.btn_chan_colour_label, "channel_button_color_label")
        
        # Refresh channel object connection
        self.refresh_object_attach()
        self._update_probe_atten_options()
    
    def refresh_object_attach(self):
        self.channel = self.root_mgr.ctrl.channels[self.channel_index]
        
        # refresh attenuation combobox if it's been instantiated already
        self.atten_unit_update = True
        self.atten_update = True
        self._update_probe_atten_options()
        
        # refresh channel name combobox
        self._update_channel_name_combobox()
        
        # refresh checkboxes
        self._chk_sensitive = False
        self.chk_chan_coup_invert.set_active(self.channel.invert)
        self.chk_chan_coup_20M.set_active(self.channel.bandwidth_20M)
        self.chk_chan_coup_50R.set_active(self.channel.termination_50R)
        self._chk_sensitive = True

    def make_state(self):
        """Generate a state tuple;  this is compared against older states to see if any
        settings have changed & if a refresh is needed."""
        return copy.copy(vars(self.channel),)
    
    def __user_exception_handler(func):
        def wrapper(self, *args):
            try:
                return func(self, *args)
            except Utils.UserRequestError as e:
                # Pass the higher-order exception back to the application root manager
                self.root_mgr._user_exception(e)
                return True # stop events being duplicated
        
        return wrapper
    
    def __state_change(func):
        def wrapper(self, *args):
            self.root_mgr.state_change_notify()
            return func(self, *args)
        
        return wrapper
    
    @__state_change
    def _channel_switch_state_set(self, *args):
        # Sets the channel state to on or off according to the new switch state
        if self.sw_chan_enabled.get_active():
            self.sw_chan_enabled.set_state(True)
            self.channel.enable_channel()
        else:
            self.sw_chan_enabled.set_state(False)
            self.channel.disable_channel()
        
        return True
    
    @__state_change
    @__user_exception_handler
    def _btn_atten_up_press(self, *args):
        # TODO: vernier mode
        self.channel.atten_up_coarse()
        return True
        
    @__state_change
    @__user_exception_handler
    def _btn_atten_down_press(self, *args):
        # TODO: vernier mode
        self.channel.atten_down_coarse()
        return True
        
    @__state_change
    @__user_exception_handler
    def _btn_offset_up_press(self, *args):
        # TODO: vernier mode
        self.channel.offset_up_coarse()
        return True
        
    @__state_change
    @__user_exception_handler
    def _btn_offset_down_press(self, *args):
        # TODO: vernier mode
        self.channel.offset_down_coarse()
        return True
    
    @__state_change
    def _btn_coup_AC(self, *args):
        self.channel.set_coupling(SC.COUP_AC)
    
    @__state_change
    def _btn_coup_DC(self, *args):
        self.channel.set_coupling(SC.COUP_DC)
    
    @__state_change
    def _btn_coup_GND(self, *args):
        self.channel.set_coupling(SC.COUP_GND)
    
    @__state_change
    def _btn_chan_probe_V_press(self, *args):
        self.channel.set_unit(Utils.UnitVolt())
    
    @__state_change
    def _btn_chan_probe_A_press(self, *args):
        self.channel.set_unit(Utils.UnitAmp())
    
    @__user_exception_handler
    def _btn_chan_probe_other_press(self, *args):
        raise Utils.UserRequestUnsupported(_("This option is not supported right now"))
    
    @__state_change
    def _chkbtn_invert(self, widget, *args):
        if self._chk_sensitive:
            self.channel.toggle_invert()
            widget.set_state(False)   # initially just disable the checkbutton; it's enabled by the state updater
        
    @__state_change
    def _chkbtn_20M(self, widget, *args):
        if self._chk_sensitive:
            self.channel.toggle_bandwidth_20M()
            widget.set_state(False)
    
    @__state_change
    def _chkbtn_50R(self, widget, *args):
        if self._chk_sensitive:
            widget.set_state(False)
            
            if not self.channel.get_50_ohm_termination():
                resp = UIController.dialog_box(
                            pri_text=_("Do you want to enable 50 ohm termination?"),
                            sec_text=_("Exceeding 10 volts DC on terminated inputs may cause instrument damage.\n\nYou can disable this message in the Preferences dialog."), 
                            icon=Gtk.MessageType.QUESTION, buttons=Gtk.ButtonsType.YES_NO,
                            window=self.root_mgr.window)
                
                if resp == Gtk.ResponseType.YES:
                    self.channel.toggle_50_ohm_termination()
                    widget.set_state(True)
    
    @__state_change
    def _btn_probe_atten_units_press(self, *args):
        if self.atten_unit == ATTEN_UNIT_X:
            self.atten_unit = ATTEN_UNIT_DB
        elif self.atten_unit == ATTEN_UNIT_DB:
            self.atten_unit = ATTEN_UNIT_X
            
        self.atten_unit_update = True
        self._update_probe_atten_options()
    
    @__state_change
    def _cmb_probe_atten_changed(self, *args):
        if self.atten_init and not self.atten_unit_update and not self.atten_update:
            log.info("Set probe gain to %f" % probe_atten_options[self.cmb_probe_atten.get_active()])
            self.channel.set_probe_gain(probe_atten_options[self.cmb_probe_atten.get_active()])
    
    @__state_change
    def _btn_chan_colour_press(self, *args):
        colour_picker = UIChannelColourPicker.ChannelColourPicker(self.channel.long_name)
        colour_picker.set_hue_sat(*self.channel.get_colour())
        self.channel.set_colour(*colour_picker.run())
    
    @__state_change
    @__user_exception_handler
    def _cmb_chan_label_changed(self, *args):
        path = list(map(int, str(self.cmb_chan_label.get_model().get_path(self.cmb_chan_label.get_active_iter())).split(":")))
        if len(path) == 1:
            if path[0] == 0:
                log.debug("Reset channel name to defaults")
                self.channel.set_channel_name_defaults()
            elif path[0] == 1:
                raise Utils.UserRequestUnsupported(_("This option is not supported right now"))
        else:
            log.debug("Request templated name")
            key = user_channel_names[path[0] - 2][1][path[1]]
            self.channel.set_channel_name_global(key[1], key[0])
    
    @__state_change
    def _update_channel_name_combobox(self):
        model = self.cmb_chan_label.get_model()
        row = model.get_iter_first()
        
        while True:
            child = model.iter_children(row)
            
            if child != None:
                while True:
                    key, long = model.get_value(child, 0), model.get_value(child, 1)
                    if len(key) == 0:
                        key = long
                    
                    if key == self.channel.short_name and long == self.channel.long_name:
                        self.cmb_chan_label.set_active_iter(child)
                        self._cmb_chan_label_changed(None)
                    
                    child = model.iter_next(child)
                    if child == None:
                        break
                
            row = model.iter_next(row)
            
            if row == None:
                break
    
    @__state_change
    def _update_probe_atten_options(self):
        if self.atten_unit == ATTEN_UNIT_X:
            self.btn_probe_atten_units.set_label(_("X"))
        elif self.atten_unit == ATTEN_UNIT_DB:
            self.btn_probe_atten_units.set_label(_("dB"))
        else:
            self.btn_probe_atten_units.set_label(_("?"))
    
        if self.atten_unit_update:
            self.cmb_probe_atten.remove_all()
        
            for option in probe_atten_options:
                if self.atten_unit == ATTEN_UNIT_X:
                    self.cmb_probe_atten.append_text(_("{0}X").format(option))
                elif self.atten_unit == ATTEN_UNIT_DB:
                    self.cmb_probe_atten.append_text(Utils.value_20_log_db(option))
            
            self.atten_unit_update = False
            self.atten_update = True
            
        # Select the current attenuation (we select the nearest option)
        # if the option has changed
        if self.atten_update:
            min_error = 1e99
            for i, option in enumerate(probe_atten_options):
                error = abs(option - self.channel.get_probe_gain())
                if error < min_error:
                    min_error = error
                    self.cmb_probe_atten.set_active(i)
            self.atten_update = False
            self.atten_init = True
    
    def tab_clicked(self, *args):
        # Clicking a tab when the channel is not currently selected will select the tab
        # Clicking the tab when the channel is selected will toggle the channel enable state
        if (self.notebook.get_current_page() + 1) == self.notebook_index:
            self.channel.toggle_channel()
        else:
            self.notebook.set_current_page(self.notebook_index - 1)
    
    def refresh_tab(self):
        # Tab not refreshed if not active, and this is not the first run
        if self.notebook.get_current_page() != (self.notebook_index - 1) and self.init_refresh:
            return
        
        self.init_refresh = True
        
        # Tab not refreshed if Nothing Has Changed (T.May, 2017)
        self.new_state = self.make_state()
        if self.new_state == self.last_state:
            return
        self.last_state = self.new_state
        
        self.lbl_tab.set_markup(self.channel.short_name)
        
        if self.channel.has_default_name():
            self.lbl_chan_name.set_markup(self.channel.long_name)
            self.lbl_chan_name_ctx.remove_class("chan_name_small")
            self.lbl_chan_name_ctx.add_class("chan_name_std")
        else:
            # If the channel name exceeds a threshold, then apply a reduced-size class
            markup = _("{long_channel_name} ({short_internal_name})").format(\
                long_channel_name=self.channel.long_name, short_internal_name=self.channel.internal_name)
            
            if len(markup) > NAME_SIZE_THRESH:
                self.lbl_chan_name_ctx.remove_class("chan_name_std")
                self.lbl_chan_name_ctx.add_class("chan_name_small")
            else:
                self.lbl_chan_name_ctx.remove_class("chan_name_small")
                self.lbl_chan_name_ctx.add_class("chan_name_std")
            
            self.lbl_chan_name.set_markup(markup)
        
        self.css_manager.set_variable("channel_index", self.notebook_index)
        
        if self.channel.enabled:
            self.css_manager.set_variable("channel_colour", self.channel.get_hex_colour(1.0))
            self.css_manager.set_variable("channel_dkcolour", self.channel.get_hex_colour(self.cfgmgr.Theme.ChannelTabEnabledShade))
            self.css_manager.set_variable("channel_gradpct", self.cfgmgr.Theme.ChannelTabEnabledGradePct)
            self.css_manager.set_variable("channel_gradpct_bkgrnd", self.cfgmgr.Theme.ChannelBkgndGradePct)
        else:
            self.css_manager.set_variable("channel_colour", self.channel.get_hex_colour(1.0))
            self.css_manager.set_variable("channel_dkcolour", self.channel.get_hex_colour(self.cfgmgr.Theme.ChannelTabShade))
            self.css_manager.set_variable("channel_gradpct", self.cfgmgr.Theme.ChannelTabGradePct)
            self.css_manager.set_variable("channel_gradpct_bkgrnd", self.cfgmgr.Theme.ChannelBkgndGradePct)
        
        self.css_manager.set_variable("channel_btn_fgcolour", Utils.get_hue_fg_colour(*self.channel.get_colour(), 1.0))
        self.css_manager.refresh_css()
        
        # TODO: We need some way to read that channel enable state has changed externally and refresh
        # the state of the toggle switch
        
        # Sync the offset and attenuation fields
        self.lbl_chan_atten.set_markup(self.channel.get_unit().unit_format_atten(self.channel.get_computed_attenuation()))
        self.lbl_chan_offset.set_markup(self.channel.get_unit().unit_format(self.channel.get_computed_offset(), precision=2))
        
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
        
        # Sync the unit buttons
        self.btn_chan_probe_V_ctx.add_class("button_off")
        self.btn_chan_probe_A_ctx.add_class("button_off")
        self.btn_chan_probe_other_ctx.add_class("button_off")
        self.btn_chan_probe_V_ctx.remove_class("button_on")
        self.btn_chan_probe_A_ctx.remove_class("button_on")
        self.btn_chan_probe_other_ctx.remove_class("button_on")
        self.btn_chan_probe_other.set_label(_("..."))
        
        if isinstance(self.channel.get_unit(), Utils.UnitVolt):
            self.btn_chan_probe_V_ctx.remove_class("button_off")
            self.btn_chan_probe_V_ctx.add_class("button_on")
        elif isinstance(self.channel.get_unit(), Utils.UnitAmp):
            self.btn_chan_probe_A_ctx.remove_class("button_off")
            self.btn_chan_probe_A_ctx.add_class("button_on")
        else:
            self.btn_chan_probe_other_ctx.remove_class("button_off")
            self.btn_chan_probe_other_ctx.add_class("button_on")
            self.btn_chan_probe_other.set_label(self.channel.get_unit().get_short_name())
        
        # If the channel is disabled, then all the controls related to the channel are also disabled
        sens = self.channel.is_enabled()
        
        if sens != self.last_enable_state:
            self.sw_chan_enabled.set_active(sens)
            self.last_enable_state = sens
        
        for wdg in self.sensitive_widgets:
            wdg.set_sensitive(sens)
            
        # Update probe settings
        self._update_probe_atten_options()
    
    def append_to_notebook(self):
        self.notebook.append_page(self.get_embedded_container(), self.get_embedded_label())
    
    def get_embedded_label(self):
        return self.lbl_btn
    
    def get_embedded_container(self):
        return self.vbox
