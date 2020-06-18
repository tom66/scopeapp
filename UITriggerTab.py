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

EDGE_TRIGGER_LAYOUT_FILE = "resources/edge_trigger_tab.gtkbuilder"

ICON_RISE_EDGE = "trigger_rising_edge.svg"
ICON_FALL_EDGE = "trigger_always_edge.svg"
ICON_BOTH_EDGE = "trigger_either_edge.svg"

class TriggerContainerSuperclass(object): pass

class AlwaysTriggerContainer(TriggerContainerSuperclass):
    def __init__(self, root):
        self.name = _("Always Trigger")
        self.desc = _("Continuously generates a trigger")
        self.icon = "trigger_always.svg"

        self.root = root

        self.bin = Gtk.Box()
        self.bin.pack_start(Gtk.Label(_("This trigger has no options")), False, False, 0)
        self.bin.set_hexpand(True)
        self.bin.set_vexpand(True)
        self.bin.set_valign(Gtk.Align.START)
        self.bin.set_halign(Gtk.Align.FILL)

    def get_embedded_container(self):
        return self.bin

class EdgeTriggerContainer(TriggerContainerSuperclass):
    def __init__(self, root):
        self.name = _("Edge Trigger")
        self.desc = _("Generates a trigger when the input signal rises and/or falls through a threshold")
        self.icon = "trigger_rising_edge.svg"

        self.root = root

        self.builder = Gtk.Builder()
        self.builder.add_from_file(EDGE_TRIGGER_LAYOUT_FILE)

        self.vbox = self.builder.get_object("vbox_trigger_controller_edge")
        self.vbox.set_hexpand(True)
        self.vbox.set_vexpand(True)
        self.vbox.set_valign(Gtk.Align.START)
        self.vbox.set_halign(Gtk.Align.FILL)

        self.img_fall = Gtk.Image()
        self.img_both = Gtk.Image()
        self.img_rise = Gtk.Image()

        self.btn_fall = self.builder.get_object("btn_edge_fall")
        self.btn_both = self.builder.get_object("btn_edge_both")
        self.btn_rise = self.builder.get_object("btn_edge_rise")

        self.btn_fall.add(self.img_fall)
        self.btn_both.add(self.img_both)
        self.btn_rise.add(self.img_rise)

        Utils.set_svg_image(self.img_fall, os.path.join(self.root.cfgmgr.Theme.resourcedir, ICON_FALL_EDGE), self.root.cfgmgr.Theme.TriggerSubIconSize)
        Utils.set_svg_image(self.img_both, os.path.join(self.root.cfgmgr.Theme.resourcedir, ICON_BOTH_EDGE), self.root.cfgmgr.Theme.TriggerSubIconSize)
        Utils.set_svg_image(self.img_rise, os.path.join(self.root.cfgmgr.Theme.resourcedir, ICON_RISE_EDGE), self.root.cfgmgr.Theme.TriggerSubIconSize)

    def get_embedded_container(self):
        return self.vbox

supported_triggers = [
    AlwaysTriggerContainer, EdgeTriggerContainer
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
        
        # Add all relevant widgets to the CSS manager
        self.css_manager = CSSManager.CSSManager(OUTER_TRIGGER_TAB_CSS_FILE)
        self.css_manager.add_widget(self.notebook, None)
        self.css_manager.add_widget(self.vbox, None)

        # Initialise the menu dropdown with trigger options
        self.menubtn = self.builder.get_object("mub_trigger")
        self.menubtn_label = self.builder.get_object("lbl_mub_trig_name")
        self.menubtn_image = self.builder.get_object("img_mub_trig_image")

        self.trigger_pages = Gtk.Notebook()
        self.trigger_pages.set_show_tabs(False)

        self.trigger_menu = Gtk.Menu()
        self.inner_tabs = []
        row = 0

        for trig in supported_triggers:
            obj = trig()
            log.info("Initialising trigger option: %r" % obj)

            img = Gtk.Image()
            if obj.icon != None:
                Utils.set_svg_image(img, os.path.join(self.cfgmgr.Theme.resourcedir, obj.icon), self.cfgmgr.Theme.TriggerIconSize)

            img.set_halign(Gtk.Align.CENTER)
            lbl = Gtk.Label()
            lbl.set_markup("<b>%s</b>\n<small>%s</small>" % (obj.name, obj.desc))
            lbl.set_xalign(0.0)

            item = Gtk.MenuItem()
            hbox = Gtk.Box(Gtk.Orientation.HORIZONTAL, 0)
            hbox.pack_start(img, False, False, 0)
            hbox.pack_start(lbl, True, True, 0)
            item.add(hbox)
            item.connect("activate", self._trig_menu_select, row)

            self.trigger_menu.attach(item, 0, 1, row, row + 1)
            self.inner_tabs.append(obj)
            self.css_manager.add_widget(lbl, "trigger_option_menuitem")
            self.css_manager.add_widget(img, "trigger_option_menuitem")
            self.css_manager.add_widget(hbox, "trigger_option_menuitem")

            cont = obj.get_embedded_container()
            self.trigger_pages.append_page(cont, None)

            row += 1

        self.css_manager.add_widget(self.trigger_menu, "popdown_menu")
        self.css_manager.add_widget(self.trigger_menu, "trigger_option_menu")
        self.css_manager.add_widget(self.menubtn, "trigger_option_menubutton")
        self.trigger_pages.show_all()

        self.menubtn.set_popup(self.trigger_menu)
        self.menubtn.set_valign(Gtk.Align.START)
        self.menubtn.set_vexpand(False)
        #self.menubtn.set_vexpand_set(True)

        self.vbox.pack_start(self.trigger_pages, True, True, 0)

        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_tab.set_label(_("Trigger"))
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(self.lbl_tab)
        self.lbl_btn.connect("clicked", self.tab_clicked)
        self.lbl_btn.show_all()
        
        self.css_manager.refresh_css()
        self.refresh_ui()
        self.refresh_object_attach()
    
    def refresh_ui(self):
        # Refresh the mub (menubutton)
        obj = self.inner_tabs[self.inner_tab_sel]
        self.menubtn_label.set_markup(obj.name)
        Utils.set_svg_image(self.menubtn_image, os.path.join(self.cfgmgr.Theme.resourcedir, obj.icon), self.cfgmgr.Theme.TriggerIconSize)

        # Make the selection visible for the active item.  Hide all other items.
        self.trigger_pages.set_current_page(self.inner_tab_sel)
        log.critical("tabpos=%d" % self.trigger_pages.get_current_page())

    def refresh_object_attach(self):
        pass

    def make_state(self):
        pass
    
    def _trig_menu_select(self, wdg, row):
        log.info("_trig_menu_select(%r, %d)" % (wdg, row))
        self.inner_tab_sel = row
        self.refresh_ui()

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
