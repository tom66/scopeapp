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

LAYOUT_FILE = "resources/mainapp.gtkbuilder"

# Possible icon sizes
SIZE_OTHER = 0
SIZE_ICON = 1

# How often to refresh UI data.  Lower number = more CPU, faster refresh.
UI_REFRESH_MS = 50

import AppConfigManager
import ScopeController as SC
import UIChannelTab
import UINotifier

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
    
    # Flasher variable; flips state at config FlashFreq rate
    flash_period = 0
    flash_state = False
    flash_timer = 0
    flash_error = 0
    last_ui_time = None
    
    ticks = 0
    
    last_window_size = (0, 0)
    
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
        self.window.add(self.overlay_main)
        self.lbl_status_time = self.builder.get_object("lbl_status_time")
        self.lbl_status_run = self.builder.get_object("lbl_status_run")
        self.lbl_status_run_ctx = self.lbl_status_run.get_style_context()
        
        # Create the notifier controller
        self.notifier = UINotifier.NotifyController()
        self.overlay_main.add_overlay(self.overlay_fixed)
        self.overlay_main.set_overlay_pass_through(self.overlay_fixed, True)
        self.notifier.set_fixed_container(self.overlay_fixed)
        
        #self.overlay_main.add_overlay(Gtk.Label("this is a test"))
        
        # Test default images
        self.set_svg_image("img_status_trigger_type", "trigger_rising_edge", SIZE_ICON)
        self.set_svg_image("img_status_wifi", "wifi_3", SIZE_ICON)
        self.set_svg_image("img_status_net", "network_active", SIZE_ICON)
        self.set_svg_image("img_status_usb", "blank", SIZE_ICON)
        self.set_svg_image("img_status_mute", "blank", SIZE_ICON)
        
        # Set logo
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
        
        # Connect to the GLArea.  Note, in future this will be instantiated through TomH's OpenGL layer.
        #self.gl_area = self.builder.get_object("gl_main")
        
        # Load the GtkBuilder resource for the channel tabs in the selection notebook, and
        # add one tab for each channel
        self.nbk_main_settings = self.builder.get_object("nbk_main_settings")
        self.nbk_main_settings.set_hexpand(False)
        self.nbk_main_settings.set_hexpand_set(True)
        self.nbk_main_settings.set_size_request(50, 0)
        #self.gl_area.set_hexpand(True)
        #self.gl_area.set_hexpand_set(True)
        
        for channel in self.ctrl.channels:
            ui_tab = UIChannelTab.ChannelTab(self, channel, self.nbk_main_settings, len(self.ui_tabs) + 1)
            ui_tab.append_to_notebook()
            self.ui_tabs.append(ui_tab)
        
        # Read the flash rate and calculate the flash period.
        try:
            self.flash_period = 1.0 / float(self.cfgmgr['UI']['FlashFreq'])
        except:
            self.flash_period = 0.4 # Default
    
    def _user_exception(self, exc):
        """Called by subclasses if a user exception occurs.  Handles the display of the warning message
        to the user."""
        print("_user_exception:", exc)
        self.notifier.push_notification(UINotifier.NotifyMessage(UINotifier.NOTIFY_WARNING, str(exc)))
    
    def _wnd_key_press(self, *args):
        print("_wnd_key_press", args)

    def _wnd_key_release(self, *args):
        print("_wnd_key_release", args)
    
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
        self.notifier.update_overlay(self.window.get_size()[0])
        
        self.last_ui_time = time.time()
        self.ticks += 1
            
        # To keep iteration running, return True
        return True
    
    def ui_update_clock(self):
        """
        Update the date and time on the user interface.
        """
        # Not all OSes support %n in strftime, so split and generate timestrings for each
        time_strs = []
        time_format = str(self.cfgmgr['UI']['TimeFormat']).split('%n')
        
        for line in time_format:
            time_strs.append(datetime.now().strftime(line.strip()))
        
        time_outstr = "\n".join(time_strs)
        self.lbl_status_time.set_markup(time_outstr)
    
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
    
        if self.ticks % 100 == 0:
            self.ctrl.run_state += 1
            self.ctrl.run_state %= 4
    
    def ui_update_tabs(self):
        for tab in self.ui_tabs:
            tab.refresh_tab()
    
    def run(self):
        """
        Start the MainApplication.  This launches all required threads and shows the user interface.
        """
        self.window.show_all()
        GLib.timeout_add(UI_REFRESH_MS, self.ui_tick, None, priority=GLib.PRIORITY_DEFAULT)
        Gtk.main()
