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
import UIController
import CSSManager

import os, copy

import logging
log = logging.getLogger()

OUTER_TRIGGER_TAB_LAYOUT_FILE = "resources/outer_trigger_tab.gtkbuilder"
OUTER_TRIGGER_TAB_CSS_FILE = "trigger_tab.css"

class TriggerContainerSuperclass(object): pass

class AlwaysTriggerContainer(TriggerContainerSuperclass):
    def __init__(self):
        self.name = _("Always Trigger")
        self.desc = _("Continuously generates a trigger")
        self.icon = None

class EdgeTriggerContainer(TriggerContainerSuperclass):
    def __init__(self):
        self.name = _("Edge Trigger")
        self.desc = _("Generates a trigger when the input signal rises and/or falls through a threshold")
        self.icon = "trigger_rising_edge.svg"

supported_triggers = [
    AlwaysTriggerContainer(), EdgeTriggerContainer()
]

class TriggerTab(object):
    cssprov = None
    
    init_refresh = False

    inner_tab_sel = 0
    inner_tabs = []
    
    last_state = None
    now_state = None
    
    _chk_sensitive = True
    
    def __init__(self, root_mgr, notebook, index):
        self.cfgmgr = root_mgr.cfgmgr
        self.root_mgr = root_mgr
        self.notebook = notebook
        self.notebook_index = index
        
        # Load the GtkBuilder file for the display tab
        self.builder = Gtk.Builder()
        self.builder.add_from_file(OUTER_TRIGGER_TAB_LAYOUT_FILE)
        self.vbox = self.builder.get_object("vbox_trigger_outer")
        self.vbox.get_style_context().add_class("trigger_tab")
        self.vbox.set_hexpand(True)

        # Initialise the menu dropdown with trigger options
        self.menubtn = self.builder.get_object("mub_trigger")

        # Initialise each inner tab
        self.trigger_menu = Gtk.Menu()
        self.inner_tabs = []
        row = 0

        for obj in supported_triggers:
            log.info("Initialising trigger option: %r" % obj)
            log.info("Dump: %r" % (dir(obj),))
            img = Gtk.Image()
            if obj.icon != None:
                Utils.set_svg_image(img, os.path.join(global_cfg.Theme.resourcedir, obj.icon))

            item = Gtk.ImageMenuItem()
            item.set_image(img)
            item.set_label("<b>%s</b>\n<small>%s</small>" % (obj.name, obj.desc))

            self.trigger_menu.attach(item, 0, 1, row, row + 1)
            self.inner_tabs.append(obj)
            row += 1

        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_tab.set_label(_("Trigger"))
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(self.lbl_tab)
        self.lbl_btn.connect("clicked", self.tab_clicked)
        self.lbl_btn.show_all()
        
        # Add all relevant widgets to the CSS manager
        self.css_manager = CSSManager.CSSManager(OUTER_TRIGGER_TAB_CSS_FILE)
        self.css_manager.add_widget(self.notebook, None)
        self.css_manager.add_widget(self.vbox, None)
        
        # Refresh channel object connection
        self.refresh_object_attach()
    
    def refresh_object_attach(self):
        pass

    def make_state(self):
        pass
    
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

    def tab_clicked(self, *args):
        # Clicking this tab does nothing but set the current page to it.
        self.notebook.set_current_page(self.notebook_index - 1)
    
    def refresh_tab(self):
        # Tab not refreshed if not active, and this is not the first run
        if self.notebook.get_current_page() != (self.notebook_index - 1) and self.init_refresh:
            return
        
        self.init_refresh = True
    
    def append_to_notebook(self):
        self.notebook.append_page(self.get_embedded_container(), self.get_embedded_label())
    
    def get_embedded_label(self):
        return self.lbl_btn
    
    def get_embedded_container(self):
        return self.vbox
