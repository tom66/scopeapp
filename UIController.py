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

import sys, time
from datetime import datetime

import AppConfigManager
import ScopeController as SC
import UIChannelTab
import UIChannelWidget
import UINotifier
import Utils

LAYOUT_FILE = "resources/mainapp.gtkbuilder"

# Possible icon sizes
SIZE_OTHER = 0
SIZE_ICON = 1

# Popup menu options
popdown_menu_options = [
    (_("Save Settings"),            "_menu_save_settings",          "<Ctrl>S"), 
    (_("Load Settings"),            "_menu_load_settings",          "<Ctrl>O"), 
    (_("Quick Save Settings"),      "_menu_quick_save_settings",    "<Ctrl><Alt>S"), 
    (_("Quick Load Settings"),      "_menu_quick_load_settings",    "<Ctrl><Alt>O"), 
    (_("Defaults"),                 "_menu_load_defaults"),
    None,
    (_("Help"),                     "_menu_help",                   "F1"),
    (_("About & Credits"),          "_menu_about"), 
    (_("Licences"),                 "_menu_licence"), 
    None,
    (_("Preferences"),              "_menu_preferences"), 
    (_("Shutdown"),                 "_menu_shutdown"), 
    (_("Reboot"),                   "_menu_reboot"), 
    (_("Exit Application"),         "_menu_exit",                   "<Alt>F4"), 
]

# How often to refresh UI data.  Lower number = more CPU, faster refresh.
UI_REFRESH_MS = 25

# How long to wait before syncing a last save state.
STATE_SYNC_WAIT = 10

def dialog_box(window, pri_text, sec_text, icon, buttons):
    """Helper function to make a dialog box appear and return the result."""
    dlg = Gtk.MessageDialog(window, 0, icon, buttons, "")
    dlg.set_markup("<b>{0}</b>".format(pri_text))
    dlg.format_secondary_text(sec_text)
    resp = dlg.run()
    dlg.destroy()
    return resp

class MainApplication(object):
    """
    MainApplication handles the main application UI thread as well as starting the
    various service tasks that run the oscilloscope application.  
    
    It doesn't handle anything to do with waveform acquisition or rendering.  Those
    are handled from within WaveApp and the GL application.
    """
    status_icon_size = 0
    channel_tab_shading_factor = 0.0
    
    ui_tabs = []
    ui_widgets = []
    
    active_ch = 0
    
    # Flasher variable; flips state at config FlashFreq rate
    flash_period = 0
    flash_state = False
    flash_timer = 0
    flash_error = 0
    last_ui_time = None
    last_clock_time = 0
    
    ticks = 0
    last_window_size = (0, 0)
    
    # Last time the state was synced and whether a new state needs to be synced
    last_state_sync_time = time.time()
    state_sync_pending = True
    
    def __init__(self):
        """
        Init function.  This loads the GUI configuration, the application configurator,
        and the required skin/theme.
        """
        # Create a configuration manager.  The configuration manager loads the default
        # configuration file.
        self.cfgmgr = AppConfigManager.AppConfigManager()
        
        # Create the oscilloscope controller
        self.ctrl = SC.ScopeController()
        
        # Here we'd display a splash screen while setting everything up...
        
        
        # Connect the ScopeController to hardware.
        self.ctrl.set_render_parameters(int(self.cfgmgr['Render']['DisplaySamples']), int(self.cfgmgr['Render']['DisplayHDivisionsYT']))
        self.ctrl.connect()
        
        # Load CSS file as specified in config file and apply it to everything
        self.css = Gtk.CssProvider()
        self.css.load_from_file(Gio.File.new_for_path(self.cfgmgr['Theme']['CSSFile']))
        Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), self.css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
        
        self.resource_icon_size = int(self.cfgmgr['Theme']['StatusIconSize'])
        self.resource_root = str(self.cfgmgr['Theme']['ResourceDir'])
        
        # Load the GtkBuilder application object and load common objects.
        self.builder = Gtk.Builder()
        self.builder.add_from_file(LAYOUT_FILE)
        self.overlay_main = Gtk.Overlay()
        self.vbox_main = self.builder.get_object("vbox_main")
        self.overlay_main.add(self.vbox_main)
        self.overlay_fixed = Gtk.Fixed()
        self.window = Gtk.Window()
        self.window.set_size_request(1280, 800)
        self.window.add(self.overlay_main)
        self.lbl_status_time = self.builder.get_object("lbl_status_time")
        self.lbl_status_run = self.builder.get_object("lbl_status_run")
        self.lbl_status_run_ctx = self.lbl_status_run.get_style_context()
        
        # Connect to the timebase labels
        self.evt_lbl_status_timebase = self.builder.get_object("evt_lbl_status_timebase")
        self.evt_lbl_status_timebase.connect("button-press-event", self._timebase_click)
        self.lbl_status_timebase = self.builder.get_object("lbl_status_timebase")
        self.ui_update_timebase_labels()
                                             
        # Create the AccelGroup for all key bindings
        self.agr = Gtk.AccelGroup()
        self.window.add_accel_group(self.agr)
        
        # Create the notifier controller
        self.notifier = UINotifier.NotifyController()
        self.overlay_main.add_overlay(self.overlay_fixed)
        self.overlay_main.set_overlay_pass_through(self.overlay_fixed, True)
        self.notifier.set_fixed_container(self.overlay_fixed)
        
        # Test default images
        self.set_svg_image("img_status_trigger_type", "trigger_rising_edge", SIZE_ICON)
        self.set_svg_image("img_status_wifi", "wifi_3", SIZE_ICON)
        self.set_svg_image("img_status_net", "network_active", SIZE_ICON)
        self.set_svg_image("img_status_usb", "blank", SIZE_ICON)
        self.set_svg_image("img_status_mute", "blank", SIZE_ICON)
        
        # Set logo
        self.ebx_img_logo = self.builder.get_object("ebx_img_logo")
        self.ebx_img_logo.connect("button-press-event", self._logo_clicked)
        self.img_logo = self.builder.get_object("img_logo")
        self.img_logo.set_from_file(self.cfgmgr['UI']['Logo'])
        
        # Apply common CSS classes
        self.add_css_class_by_widget_name("lbl_status_run", "runstate_common")
        self.add_css_class_by_widget_name("lbl_status_timebase_char", "status_box_left_horiz_common")
        self.add_css_class_by_widget_name("lbl_status_delay_char", "status_box_left_horiz_common")
        self.add_css_class_by_widget_name("lbl_status_timebase", "status_box_right_horiz_common")
        self.add_css_class_by_widget_name("lbl_status_delay", "status_box_right_horiz_common")
        self.add_css_class_by_widget_name("lbl_status_trigger_char", "status_box_left_horiz_common")
        self.add_css_class_by_widget_name("img_status_trigger_type", "status_box_middle_horiz_common")
        self.add_css_class_by_widget_name("grd_status_trigger_channel_container", "status_box_middle_horiz_common")
        self.add_css_class_by_widget_name("lbl_status_trigger_info", "status_box_right_horiz_common")
        
        # Connect to the window exposed event to hook onto resize events.
        # Set the application title.
        self.window.set_title(_("BluePulse Oscilloscope - Main"))
        self.window.connect("key_press_event", self._wnd_key_press)
        self.window.connect("key_release_event", self._wnd_key_release)
        
        # Load the GtkBuilder resource for the channel tabs in the selection notebook, and
        # add one tab for each channel
        self.nbk_main_settings = self.builder.get_object("nbk_main_settings")
        self.nbk_main_settings.set_hexpand(False)
        self.nbk_main_settings.set_hexpand_set(True)
        self.nbk_main_settings.set_size_request(50, 0)
        self.nbk_main_settings.connect("select_page", self._nbk_select_page)

        for idx, channel in enumerate(self.ctrl.channels):
            ui_tab = UIChannelTab.ChannelTab(self, idx, self.nbk_main_settings, len(self.ui_tabs) + 1)
            ui_tab.append_to_notebook()
            self.ui_tabs.append(ui_tab)
        
        # Add a ChannelWidget for each channel to the channel widget container
        self.box_channel_info = self.builder.get_object("box_channel_info")
        
        for idx, channel in enumerate(self.ctrl.channels):
            wdg = UIChannelWidget.ChannelWidget(self, idx)
            self.box_channel_info.pack_start(wdg.get_embedded_container(), False, True, 0)
            self.ui_widgets.append(wdg)
        
        # Create the dropdown general purpose menu that is triggered by key press or clicking
        # the application logo
        self.popdown_menu = Gtk.Menu()
        self.popdown_menu.set_accel_group(self.agr)
        row = 0
        
        for opt in popdown_menu_options:
            if opt is None:
                item = Gtk.SeparatorMenuItem()
            else:
                item = Gtk.MenuItem(opt[0])
                
                if len(opt) == 3:
                    keyval, mod = Gtk.accelerator_parse(opt[2])
                    item.add_accelerator("activate", self.agr, keyval, mod, Gtk.AccelFlags.VISIBLE)
                    
                item.connect("activate", getattr(self, opt[1]))
                
            self.popdown_menu.attach(item, 0, 1, row, row + 1)
            row += 1
        
        # Try to load the last settings file.
        # If this fails load the default setting file and show an error.
        # If *this* fails, then save a default setting file on the basis of default state
        # configuration in the various objects.
        try:
            self.ctrl.restore_settings_last()
        except:
            try:
                self.ctrl.restore_settings_default()
                self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, "Unable to load last configuration - reverting to default configuration"))
            except:
                self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, "Unable to load last OR default configuration - configuration have errors"))
        self.ui_sync_config()
            
        # Read the flash rate and calculate the flash period.
        try:
            self.flash_period = 1.0 / float(self.cfgmgr['UI']['FlashFreq'])
        except:
            self.flash_period = 0.4 # Default
    
    def __user_exception_handler(func):
        def wrapper(self, *args):
            try:
                return func(self, *args)
            except Utils.UserRequestError as e:
                self._user_exception(e)
                return True # stop events being duplicated
        
        return wrapper
    
    def _user_exception(self, exc):
        """Called by subclasses if a user exception occurs.  Handles the display of the warning message
        to the user."""
        print("_user_exception:", exc)
        self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, str(exc)))
    
    def _user_message(self, msg):
        """Called to display a message to the user."""
        print("_user_message:", msg)
        self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_INFO, str(msg)))
    
    def _nbk_select_page(self, *args):
        # Store tab in ctrl structure so this can be recalled from saved configurations
        self.ctrl.active_tab = self.nbk_main_settings.get_current_tab()
        self.state_change_notify()
    
    def _wnd_key_press(self, *args):
        print("_wnd_key_press", args)

    def _wnd_key_release(self, *args):
        print("_wnd_key_release", args)
    
    def _logo_clicked(self, *args):
        print("_logo_clicked", args)
        self.popdown_menu.show_all()
        self.popdown_menu.popup_at_widget(self.img_logo, Gdk.Gravity.SOUTH_WEST, Gdk.Gravity.NORTH_WEST, None)
    
    def _app_nice_quit(self):
        # we'd kill all subprocesses nicely; waiting up to 5 seconds for them to terminate...
        
        # then we'll save our configuration
        
        # then we'll shut down the AFE and other parts cleanly
        
        # then we'll nicely quit
        
        # ... but for now, just sys.exit()
        sys.exit()
    
    def _menu_save_settings(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))
        
    def _menu_load_settings(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))
    
    def _menu_quick_save_settings(self, *args):
        print("_menu_quick_save_settings")
        self.ctrl.save_settings_temp()
        self._user_message(_("Present settings saved into quick restore file"))
    
    def _menu_quick_load_settings(self, *args):
        print("_menu_quick_load_settings")
        self.ctrl.restore_settings_temp()
        self.ui_sync_config()
        self.prompt_user_50ohm()
        self.ui_sync_config()
        self._user_message(_("Settings restored from quick restore file"))
    
    def _menu_load_defaults(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_help(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_about(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_licence(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_preferences(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_shutdown(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_reboot(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))

    def _menu_exit(self, *args):
        # prompt to exit?
        self._app_nice_quit()
    
    @__user_exception_handler
    def _timebase_click(self, wdg, evt):
        # Compute position of click.   
        xp = evt.x / wdg.get_allocation().width
        
        if xp >= 0 and xp < 0.33:
            # Clicks in the first 1/3rd are interpreted as a decreased timebase;  
            self.ctrl.timebase.timebase_down()
        elif xp >= 0.33 and xp < 0.66:
            # Clicks in the last 1/3rd are interpreted as an increase timebase; 
            pass
        elif xp >= 0.66 and xp < 1:
            # Clicks in between the two are interpreted as selecting the timebase/horizontal options.
            self.ctrl.timebase.timebase_up()
        
        self.ui_update_timebase_labels()
    
    def state_change_notify(self):
        # Set a flag.  Changes are synced after a few seconds.
        self.state_sync_pending = True
    
    def prompt_user_50ohm(self):
        """Check if any channels have 50 ohm mode selected after restoring settings.
        If any have 50 ohm enabled then the user is prompted to confirm before continuing,
        to prevent accidental hardware damage."""
        names = []
        
        for ch in self.ctrl.channels:
            if not ch.termination_50R_applied and ch.termination_50R:
                names.append(ch.default_long_name)
        
        if len(names) > 0:
            names_catenated = ", ".join(names)
            message = gettext.ngettext("{0} has 50 ohm mode enabled. ", "Inputs ({0}) have 50 ohm mode enabled. ", len(names)).format(names_catenated) + "\n\n" + \
                                     _("If a terminated channel has a voltage greater than 10 volts applied, instrument damage could occur. \n\n"
                                       "Would you like to enable the termination for these channels?")
            
            res = dialog_box(pri_text=_("Warning - 50 ohm mode enabled for some channels!"),
                            sec_text=message, icon=Gtk.MessageType.WARNING, buttons=Gtk.ButtonsType.YES_NO,
                            window=self.window)
            
            if res == Gtk.ResponseType.YES:
                for ch in self.ctrl.channels:
                    if not ch.termination_50R_applied and ch.termination_50R:
                        ch.termination_50R = True
                        ch.termination_50R_applied = True
            else:
                for ch in self.ctrl.channels:
                    if not ch.termination_50R_applied and ch.termination_50R:
                        ch.termination_50R = False
                        ch.termination_50R_applied = False
    
    def channel_widget_click(self, channel):
        # Find the appropriate ChannelTab instance and send the click message
        for tab in self.ui_tabs:
            if isinstance(tab, UIChannelTab.ChannelTab):
                if tab.channel == channel:
                    tab.tab_clicked(None)
    
    def add_css_class_by_widget_name(self, widget, cls):
        self.builder.get_object(widget).get_style_context().add_class(cls)
    
    def set_svg_image(self, widget, file, size_class):
        if size_class == SIZE_ICON:
            size = self.resource_icon_size
        else:
            raise ValueError(_("size parameter invalid"))
        
        pb = GdkPixbuf.Pixbuf.new_from_file_at_scale(self.resource_root + file + ".svg", size, size, 1)
        w = self.builder.get_object(widget)
        w.set_from_pixbuf(pb)
    
    def ui_tick(self, *args, **kwargs):
        """
        This is run several times per second.  It despatches the update tasks (updating measurements,
        the time, wifi/network status, etc.)
        """
        # Update the flash state
        if self.last_ui_time == None:
            self.last_ui_time = time.time()
        
        self.flash_timer += time.time() - self.last_ui_time
        #print(int(self.flash_state), self.flash_timer, self.flash_error)
        
        if self.flash_timer >= self.flash_period:
            self.flash_error = self.flash_timer - self.flash_period
            self.flash_timer = self.flash_error
            self.flash_state = not self.flash_state
        
        # Run helper functions
        self.ui_update_clock()
        self.ui_update_run_state()
        self.ui_update_tabs()
        self.ui_update_widgets()
        
        self.notifier.update_overlay(self.window.get_size()[0])
        
        self.last_ui_time = time.time()
        self.ticks += 1
        
        # Check if a sync is pending. The state is synced every 10 seconds.
        # (But only if the state changes.)
        if self.state_sync_pending:
            tdelta = time.time() - self.last_state_sync_time
            if tdelta < 0 or tdelta > STATE_SYNC_WAIT:
                print("Syncing last oscilloscope state")
                self.ctrl.save_settings_last()
                self.last_state_sync_time = time.time()
                self.state_sync_pending = False
            
        # To keep iteration running, return True
        return True
    
    def ui_update_clock(self):
        """
        Update the date and time on the user interface.
        """
        # Not all OSes support %n in strftime, so split and generate timestrings for each
        if (time.time() - self.last_clock_time) > 1.0:
            time_strs = []
            time_format = str(self.cfgmgr['UI']['TimeFormat']).split('%n')

            for line in time_format:
                time_strs.append(datetime.now().strftime(line.strip()))

            time_outstr = "\n".join(time_strs)
            self.lbl_status_time.set_markup(time_outstr)
            self.last_clock_time = time.time()
    
    def ui_update_run_state(self):
        """
        Update the run state based on the ScopeController state.
        """
        self.lbl_status_run_ctx.remove_class("runstate_stop")
        self.lbl_status_run_ctx.remove_class("runstate_run")
        self.lbl_status_run_ctx.remove_class("runstate_trigd")
        self.lbl_status_run_ctx.remove_class("runstate_wait_dim")
        self.lbl_status_run_ctx.remove_class("runstate_wait_bri")
        self.lbl_status_run_ctx.remove_class("runstate_auto_dim")
        self.lbl_status_run_ctx.remove_class("runstate_auto_bri")
        
        if self.ctrl.run_state == SC.STATE_RUNNING_WAIT_TRIG:
            if self.flash_state:
                self.lbl_status_run_ctx.add_class("runstate_wait_bri")
                self.lbl_status_run.set_markup(_("WAIT"))
            else:
                self.lbl_status_run_ctx.add_class("runstate_wait_dim")
                self.lbl_status_run.set_markup(_("WAIT"))
        elif self.ctrl.run_state == SC.STATE_RUNNING_AUTO:
            if self.flash_state:
                self.lbl_status_run_ctx.add_class("runstate_auto_bri")
                self.lbl_status_run.set_markup(_("AUTO"))
            else:
                self.lbl_status_run_ctx.add_class("runstate_auto_dim")
                self.lbl_status_run.set_markup(_("AUTO"))
        elif self.ctrl.run_state == SC.STATE_STOPPED:
            self.lbl_status_run_ctx.add_class("runstate_stop")
            self.lbl_status_run.set_markup(_("STOP"))
        elif self.ctrl.run_state == SC.STATE_RUNNING_TRIGD:
            self.lbl_status_run_ctx.add_class("runstate_trigd")
            self.lbl_status_run.set_markup(_("TRIG'D"))
    
    def ui_update_timebase_labels(self):
        print(self.ctrl.timebase.get_timebase())
        self.lbl_status_timebase.set_markup(Utils.unit_format_atten(self.ctrl.timebase.get_timebase().get_div_value(), "s"))
    
    def ui_update_tabs(self):
        for tab in self.ui_tabs:
            tab.refresh_tab()
    
    def ui_update_widgets(self):
        for wdg in self.ui_widgets:
            wdg.refresh_widget()
    
    def ui_sync_config(self):
        for tab in self.ui_tabs:
            tab.refresh_object_attach()
            
        for wdg in self.ui_widgets:
            wdg.refresh_object_attach()
    
        print("active_tab:", self.ctrl.active_tab)
        self.nbk_main_settings.set_current_page(self.ctrl.active_tab)
    
    def run(self):
        """
        Start the MainApplication.  This launches all required threads and shows the user interface.
        """
        self.window.show_all()
        GLib.timeout_add(UI_REFRESH_MS, self.ui_tick, None, priority=GLib.PRIORITY_DEFAULT)
        Gtk.main()
