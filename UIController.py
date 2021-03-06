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

import sys, time, random, math
from datetime import datetime

import ScopeController as SC
import UIChannelTab, UIDisplayTab, UITriggerTab, UIChannelWidget, UINotifier, ScopeArena, Utils

LAYOUT_FILE = "resources/mainapp.gtkbuilder"

# Load debug logger
import logging
log = logging.getLogger()

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
UI_REFRESH_MS = 1000 / 25.0

# Minimum delay between refreshes; as load in a tick increases the delay might reduce to keep the UI
# responsive (& above rate consistent), but we don't want to steal all of GTK's time
UI_MIN_DELAY_MS = 5.0

# How long to wait before syncing a last save state.
STATE_SYNC_WAIT = 10

# UI space usage, estimated to set the waveform render target size
UI_VERTICAL_SPACE = 48
UI_HORIZONTAL_SPACE = 196

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
    
    delay_tick = 0
    last_tick = 0
    fps_average_accu = 0
    fps_average_count = 0
    fps_average = 0
    
    # Time that the acquisition automatically starts; used for power-up auto start
    start_auto = 0.0

    # Last time the state was synced and whether a new state needs to be synced
    last_state_sync_time = time.time()
    state_sync_pending = True
    
    # Used for UI caching
    last_acq_params = None

    def __init__(self, cfgmgr):
        """
        Init function.  This loads the GUI configuration, the application configurator,
        and the required skin/theme.
        """
        self.cfgmgr = cfgmgr

        log.info("Start initialising oscilloscope control")
        self.ctrl = SC.ScopeController(self)
        
        # Here we'd display a splash screen while setting everything up...
        
        # Connect the ScopeController to hardware.
        self.ctrl.set_render_parameters(int(self.cfgmgr.Render.DisplaySamples), int(self.cfgmgr.Render.DisplayHDivisionsYT))
        self.ctrl.connect()

        log.info("Done initialising oscilloscope control")
        
        # Load CSS file as specified in config file and apply it to everything
        log.info("Start initialising GTK configuration")
        self.css = Gtk.CssProvider()
        self.css.load_from_file(Gio.File.new_for_path(self.cfgmgr.Theme.CSSFile))
        Gtk.StyleContext.add_provider_for_screen(Gdk.Screen.get_default(), self.css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)
        
        self.resource_icon_size = int(self.cfgmgr.Theme.StatusIconSize)
        self.resource_root = str(self.cfgmgr.Theme.ResourceDir)
        
        # Load the GtkBuilder application object and load common objects.
        self.builder = Gtk.Builder()
        self.builder.add_from_file(LAYOUT_FILE)
        self.overlay_main = Gtk.Overlay()
        self.vbox_main = self.builder.get_object("vbox_main")
        self.hbox_main = self.builder.get_object("hbox_main")
        self.overlay_main.add(self.vbox_main)
        self.overlay_fixed = Gtk.Fixed()
        self.window = Gtk.Window()
        self.window.set_size_request(1280, 800)
        self.window.add(self.overlay_main)
        self.lbl_status_time = self.builder.get_object("lbl_status_time")
        self.lbl_status_run = self.builder.get_object("lbl_status_run")
        self.lbl_status_run_ctx = self.lbl_status_run.get_style_context()
        
        # Since the contents of these labels can change, set their size to be at least 80 pixels wide each
        # TODO: Do we need to make this configurable by the stylesheet/theme?
        self.lbl_status_bits_samplerate = self.builder.get_object("lbl_status_bits_samplerate")
        self.lbl_status_npoints_nwaves = self.builder.get_object("lbl_status_npoints_nwaves")
        self.lbl_status_bits_samplerate.set_size_request(80, -1)
        self.lbl_status_npoints_nwaves.set_size_request(80, -1)
        
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
        
        # Set the application title.
        self.window.set_title(_("BluePulse Oscilloscope - Main"))

        # Connect window signals
        self.window.connect("key_press_event", self._wnd_key_press)
        self.window.connect("key_release_event", self._wnd_key_release)
        self.window.connect("configure-event", self._wnd_config_event)
        
        self.setup_settings_notebook()
        self.setup_channel_widgets()
        self.setup_context_menu()
        self.setup_render_arena()
        self.restore_settings_last()

        # Done initialisation of GUI stuff
        log.info("Done initialising GTK configuration")

        # Set the start signal.  It will start the acquisition automatically a few seconds after the application launches.
        self.start_auto = time.time() + 6.0
    
    def setup_settings_notebook(self):
        """Populate the settings notebook."""
        # Load the GtkBuilder resource for the channel tabs in the selection notebook, and
        # add one tab for each channel.   Add additional tabs for display, acquire, trigger etc.
        # XXX: Should we empty the notebook first?
        log.info("Creating settings notebook")

        self.nbk_main_settings = self.builder.get_object("nbk_main_settings")
        self.nbk_main_settings.set_hexpand(False)
        self.nbk_main_settings.set_hexpand_set(True)
        self.nbk_main_settings.set_size_request(50, 0)
        self.nbk_main_settings.connect("select_page", self._nbk_select_page)

        # Add channel tabs
        for idx, channel in enumerate(self.ctrl.channels):
            ui_tab = UIChannelTab.ChannelTab(self, idx, self.nbk_main_settings, len(self.ui_tabs) + 1)
            ui_tab.append_to_notebook()
            self.ui_tabs.append(ui_tab)

        # Add display tab
        ui_tab = UIDisplayTab.DisplayTab(self, self.nbk_main_settings, len(self.ui_tabs) + 1)
        ui_tab.append_to_notebook()
        self.ui_tabs.append(ui_tab)

        # Add trigger tab
        ui_tab = UITriggerTab.TriggerTab(self, self.nbk_main_settings, len(self.ui_tabs) + 1)
        ui_tab.append_to_notebook()
        ui_tab.refresh_ui()
        self.ui_tabs.append(ui_tab)

        # TODO: acquire, math, reference, storage, utility...

    def setup_channel_widgets(self):
        """Setup the channel widgets for the UI."""
        log.info("Creating channel widgets")

        # Add a ChannelWidget for each channel to the channel widget container
        self.box_channel_info = self.builder.get_object("box_channel_info")
        
        for idx, channel in enumerate(self.ctrl.channels):
            wdg = UIChannelWidget.ChannelWidget(self, idx)
            self.box_channel_info.pack_start(wdg.get_embedded_container(), False, True, 0)
            self.ui_widgets.append(wdg)

    def setup_context_menu(self):        
        """Create the dropdown general purpose menu that is triggered by key press or clicking
        the application logo."""
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

    def setup_render_arena(self):
        log.info("Initialising ScopeArenaController")

        self.ctrl.arena.gtk_attach(self.window, self.hbox_main, 'pack_start', (True, True, 0))

    def restore_settings_last(self):
        """
        Try to load the last settings file.
        If this fails load the default setting file and show an error.
        If *this* fails, then save a default setting file on the basis of default state
        configuration in the various objects.
        """
        log.info("Loading last settings file")

        try:
            self.ctrl.restore_settings_last()
        except Exception as e:
            try:
                log.critical("Exception during setting restore: %r" % e)
                log.info("Attempting to use default configuration file")

                self.ctrl.restore_settings_default() 
                self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, \
                    _("Unable to load last configuration - reverting to default configuration")))
            except:
                log.critical("Exception during default setting restore: %r" % e)
                log.error("Unable to load any configuration file.  The application may be unstable")
                
                self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, \
                    _("Unable to load last OR default configuration - configuration has errors.  The application may be unstable!\n" \
                      "Please restore the configuration file to the user directory.")))

        self.ui_sync_config()
        log.info("Done loading last settings file")
    
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
        log.error("UserException: %s" % repr(exc))
        self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, str(exc)))
    
    def _user_message(self, msg):
        """Called to display a message to the user."""
        log.info("UserMessage: %s" % str(msg))
        self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_INFO, str(msg)))
    
    def _nbk_select_page(self, *args):
        # Store tab in ctrl structure so this can be recalled from saved configurations
        self.ctrl.active_tab = self.nbk_main_settings.get_current_tab()
        self.state_change_notify()
    
    def _wnd_key_press(self, *args):
        log.info("_wnd_key_press %r" % list(args))

    def _wnd_key_release(self, *args):
        log.info("_wnd_key_release %r" % list(args))
    
    def _wnd_config_event(self, *args):
        rect = self.window.get_allocated_size().allocation
        w = rect.width - UI_HORIZONTAL_SPACE
        h = rect.height - UI_VERTICAL_SPACE

        log.info("New window size: %d x %d;  after removing mandatory space: %d x %d approx. available for waveform" % \
            (rect.width, rect.height, w, h))

        self.ctrl.arena.notify_resize()

    def _logo_clicked(self, *args):
        log.info("_logo_clicked %r" % list(args))
        self.popdown_menu.show_all()
        self.popdown_menu.popup_at_widget(self.img_logo, Gdk.Gravity.SOUTH_WEST, Gdk.Gravity.NORTH_WEST, None)
    
    def _app_nice_quit(self):
        # we'd kill all subprocesses nicely; waiting up to 5 seconds for them to terminate...
        
        # then we'll save our configuration
        
        # then we'll shut down the AFE and other parts cleanly
        
        # then we'll nicely quit
        
        # ... but for now, just sys.exit()
        log.info("Application quit")
        log.flush()
        sys.exit()
    
    def _menu_save_settings(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))
        
    def _menu_load_settings(self, *args):
        self._user_exception(Utils.UserRequestUnsupported(_("Function not implemented yet")))
    
    def _menu_quick_save_settings(self, *args):
        log.info("Quick save settings activated")
        self.ctrl.save_settings_temp()
        self._user_message(_("Present settings saved into quick restore file"))
    
    def _menu_quick_load_settings(self, *args):
        log.info("Quick load settings activated")
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
        elif xp > 0.4 and xp < 0.6:
            # Clicks in between the two are interpreted as selecting the timebase/horizontal options (not implemented)
            log.warning("Middle click on timebase: not yet implemented")
        elif xp > 0.66 and xp <= 1:
            # Clicks in the last 1/3rd are interpreted as an increase timebase; 
            self.ctrl.timebase.timebase_up()
        
        self.ui_update_timebase_labels()
    
    def state_change_notify(self, opt_ident=""):
        """State change notifier.  opt_ident can be passed to identify a change notifier to be 
        called e.g. 'ch-colour' to notify the render engine that the wave colour has changed."""
        # Set a flag.  Changes are synced after a few seconds.
        self.state_sync_pending = True

    def state_change_notify_ext(self, ident):
        """Extended state change notifier.  ident can be passed to identify a change notifier to be 
        called e.g. 'ch-colour' to notify the render engine that the wave colour has changed."""
        self.state_change_notify()

        if ident == "ch-colour":
            self.ctrl.arena.notify_channel_colour_change()

    def state_change_all(self):
        self.state_change_notify_ext("ch-colour")

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

        Utils.set_svg_image(self.builder.get_object(widget), self.resource_root + file + ".svg", size)
    
    def ui_tick(self, *args, **kwargs):
        """
        This is run several times per second.  It despatches the update tasks (updating measurements,
        the time, wifi/network status, etc.)
        """
        tick_start = time.time()
        
        # Update the flash state
        if self.last_ui_time == None:
            self.last_ui_time = time.time()
        
        self.flash_timer += time.time() - self.last_ui_time
        
        if self.flash_timer >= self.flash_period:
            self.flash_error = self.flash_timer - self.flash_period
            self.flash_timer = self.flash_error
            self.flash_state = not self.flash_state
        
        # Run helper functions
        #t0 = time.time()
        self.ui_update_clock()
        #self.ui_update_run_state()
        self.ui_update_acq_parameters()
        self.ui_update_tabs()
        self.ui_update_widgets()
        #t1 = time.time()

        #log.debug("widget_update: %.1f ms" % ((t1 - t0) * 1000))
        
        #t0 = time.time()
        self.notifier.update_overlay(self.window.get_size()[0])
        #t1 = time.time()
        #log.debug("update_overlay: %.1f ms" % ((t1 - t0) * 1000))
        
        self.last_ui_time = time.time()
        self.ticks += 1
        
        # Check if a sync is pending. The state is synced every 10 seconds.
        # (But only if the state changes.)
        if self.state_sync_pending:
            tdelta = time.time() - self.last_state_sync_time
            if tdelta < 0 or tdelta > STATE_SYNC_WAIT:
                log.info("Syncing last oscilloscope state to disk")
                self.ctrl.save_settings_last()
                self.last_state_sync_time = time.time()
                self.state_sync_pending = False

        # Sync scope controller functions
        self.ui_tick_scope()
        
        # Stop this iteration and set a new iteration up with the correct delay to maintain
        # the desired tick rate
        if self.last_tick is None:
            self.delay_tick = UI_REFRESH_MS
        else:
            actual_delay = (tick_start - self.last_tick) * 1000
            self.delay_tick -= (actual_delay - UI_REFRESH_MS)
            self.delay_tick = max(self.delay_tick, UI_MIN_DELAY_MS)
            
            # performance benchmarking: average performance over last 200 frames, once every 8 frames
            self.fps_average_accu += 1000.0 / actual_delay
            self.fps_average_count += 1
            
            if self.fps_average_count > 200:
                self.fps_average_count = 0
                self.fps_average_accu = 0
            elif (self.fps_average_count & 7) == 0:
                self.fps_average = self.fps_average_accu / self.fps_average_count
                log.debug("set_tick: %7.3f ms, actual_delay: %3.3f ms, avg_frame_rate: %2.1f fps" % (self.delay_tick, actual_delay, self.fps_average))
        
        # does this cause stack overflow?
        GLib.timeout_add(self.delay_tick, self.ui_tick, None, priority=GLib.PRIORITY_DEFAULT)
        self.last_tick = tick_start
            
        return False
    
    def ui_tick_scope(self):
        #t0 = time.time()
        try:
            self.ctrl.tick()
        except Utils.UserRequestError as e:
            log.critical("UserException passed from tick controller: %r" % e)
            self._user_exception(e)

        #t1 = time.time()

        #log.info("ctrl_tick %.1f ms" % ((t1 - t0) * 1000))

        # Should we start acquisition automatically?
        if self.start_auto != None and time.time() > self.start_auto:
            log.info("Automatically starting acquisition on power up...")
            self.start_auto = None
            self.ctrl.acq_run()

        # Update controller
        t0 = time.time()
        self.ctrl.update()
        t1 = time.time()

        #log.info("update()  %.1f ms" % ((t1 - t0) * 1000))
    
    def ui_update_clock(self):
        """
        Update the date and time on the user interface.
        """
        # Only update if more than 1 second has elapsed...
        if (time.time() - self.last_clock_time) > 1.0:
            # Not all OSes support %n in strftime, so split and generate timestrings for each
            time_strs = []
            time_format = str(self.cfgmgr.UI.TimeFormat).split('%n')

            for line in time_format:
                time_strs.append(datetime.now().strftime(line.strip()))

            time_outstr = "\n".join(time_strs)
            self.lbl_status_time.set_markup(time_outstr)
            self.last_clock_time = time.time()
    
    def ui_update_acq_parameters(self):
        """
        Update acquisition parameters: memory depth, waves/sec, bit depth, etc.
        """
        # TODO: Only update these on change...
        #waveforms_per_second = round(self.ctrl.get_waves_per_second(), 2)
        waveforms_per_second = round(self.ctrl.get_current_average_waves_per_second(), 3)
        #log.info("wfms:%.3f" % self.ctrl.get_current_average_waves_per_second())
        memory_depth = self.ctrl.get_memory_depth()
        sample_rate = self.ctrl.get_sample_rate()
        bits = self.ctrl.get_sample_depth()

        _acq_params = (waveforms_per_second, memory_depth, sample_rate, bits)
        #log.info("acq_params: %r" % (_acq_params,))

        if _acq_params != self.last_acq_params:
            # TRANSLATORS: lbl_status_bits_samplerate contains a bit depth (8-bit; compare 'audio' and 'graphics' bit depths, for instance)
            # and a sample rate (samples per second, compare with frequency or repetitiveness.)  This label probably should not be translated,
            # or altered.  Only translate the units if they are not commonly understood in engineering fields in your locale.
            self.lbl_status_bits_samplerate.set_markup(\
                _("{bits_value}-bit\n{samplerate_string}").format(
                    bits_value=bits, \
                    samplerate_string=Utils.unit_format_suffix_handle_exc(sample_rate, _("Sa/s"), precision=2) \
                ))
            
            # TRANSLATORS: lbl_status_npoints_nwaves contains the number of points per waveform and the number of waveforms per second
            # that the instrument is acquiring (or is targeting for acquisition.) The base label is not translatable.
            #
            # pts = points,  wfm/s = waveforms per second;  only translate the units if they are not commonly understood in engineering 
            # fields in your locale.
            #stats = self.ctrl.get_zs_stats()
            #log.info("%s" % repr(stats))

            self.lbl_status_npoints_nwaves.set_markup(\
                "{points_string}\n{nwaves_string}".format(\
                    points_string=Utils.unit_format_suffix_handle_exc(memory_depth, _("pts"), precision=1), \
                    nwaves_string=Utils.unit_format_suffix_handle_exc(waveforms_per_second, _("wfm/s"), precision=2) \
                ))

            self.last_acq_params = _acq_params
    
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
        self.lbl_status_timebase.set_markup(Utils.unit_format_atten(self.ctrl.timebase.get_timebase().get_div_value(), "s"))
    
    def ui_update_tabs(self):
        for tab in self.ui_tabs:
            tab.refresh_tab()
    
    def ui_update_widgets(self):
        # Only update these on every 10th frame, until we fix the resource hog bug
        if self.ticks % 10 == 0:
            for wdg in self.ui_widgets:
                wdg.refresh_widget()
    
    def ui_sync_config(self):
        for tab in self.ui_tabs:
            tab.refresh_object_attach()
            
        for wdg in self.ui_widgets:
            wdg.refresh_object_attach()

        # Read the flash rate and calculate the flash period.
        try:
            self.flash_period = 1.0 / float(self.cfgmgr.UI.FlashFreq)
        except:
            self.flash_period = 0.4 # Default

        log.info("Active tab index: %d" % self.ctrl.active_tab)
        self.nbk_main_settings.set_current_page(self.ctrl.active_tab)
    
    def run(self):
        """
        Start the MainApplication.  This launches all required threads and shows the user interface.
        """
        self.window.show_all()
        self.last_tick = None
        self.delay_tick = UI_REFRESH_MS
        
        GLib.timeout_add(UI_REFRESH_MS, self.ui_tick, None, priority=GLib.PRIORITY_DEFAULT)
        Gtk.main()
