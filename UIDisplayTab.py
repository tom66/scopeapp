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

import copy

DISPLAY_TAB_LAYOUT_FILE = "resources/display_tab.gtkbuilder"
DISPLAY_TAB_CSS_FILE = "display_tab.css"

class DisplayTab(object):
    cssprov = None
    
    init_refresh = False
    
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
        self.builder.add_from_file(DISPLAY_TAB_LAYOUT_FILE)
        self.vbox = self.builder.get_object("vbx_disp_container")
        self.vbox.get_style_context().add_class("display_tab")
        self.vbox.set_hexpand(False)
        
        # Extract connections to important widgets
        self.scl_intensity = self.builder.get_object("scl_intensity")
        self.chk_crt_mode = self.builder.get_object("chk_crt_mode")
        self.btn_disp_tog_dots = self.builder.get_object("btn_disp_tog_dots")
        self.btn_disp_tog_vectors = self.builder.get_object("btn_disp_tog_vectors")
        self.btn_disp_tog_fast = self.builder.get_object("btn_disp_tog_fast")
        self.btn_disp_tog_AA = self.builder.get_object("btn_disp_tog_AA")
        self.scl_grat_intensity = self.builder.get_object("scl_grat_intensity")
        self.chk_grat_crosshair = self.builder.get_object("chk_grat_crosshair")
        self.chk_grat_divisions = self.builder.get_object("chk_grat_divisions")
        self.chk_grat_subdivisions = self.builder.get_object("chk_grat_subdivisions")
        self.lbl_render_fps = self.builder.get_object("lbl_render_fps")
        self.lbl_render_arenadims = self.builder.get_object("lbl_render_arenadims")
        self.lbl_render_time = self.builder.get_object("lbl_render_time")
        self.lbl_render_wfms = self.builder.get_object("lbl_render_wfms")
        self.frm_disp_intensity = self.builder.get_object("frm_disp_intensity")
        self.frm_disp_rendering = self.builder.get_object("frm_disp_rendering")
        self.frm_disp_graticule = self.builder.get_object("frm_disp_graticule")
        
        self.chk_crt_mode.connect("toggled", self._chk_crt_mode_toggle)
        self.chk_grat_crosshair.connect("toggled", self._chk_grat_crosshair_toggle)
        self.chk_grat_divisions.connect("toggled", self._chk_grat_divisions_toggle)
        self.chk_grat_subdivisions.connect("toggled", self._chk_grat_subdivisions_toggle)
        self.scl_intensity.connect("value-changed", self._scl_intensity_change)
        self.scl_grat_intensity.connect("value-changed", self._scl_grat_intensity_change)
        self.btn_disp_tog_dots.connect("clicked", self._btn_disp_tog_dots_click)
        self.btn_disp_tog_vectors.connect("clicked", self._btn_disp_tog_vectors_click)
        self.btn_disp_tog_fast.connect("clicked", self._btn_disp_tog_fast_click)
        self.btn_disp_tog_AA.connect("clicked", self._btn_disp_tog_AA_click)
        
        # i10n
        self.btn_disp_tog_dots.set_label(_("Dots"))                 # TRANSLATORS: 'Dots' means no lines between dots
        self.btn_disp_tog_vectors.set_label(_("Vectors"))           # TRANSLATORS: 'Vectors' means lines between dots
        self.btn_disp_tog_fast.set_label(_("Fast"))                 # TRANSLATORS: 'Fast' means faster rendering with downsampler (i.e. low-quality but fast)
        self.btn_disp_tog_AA.set_label(_("AA"))                     # TRANSLATORS: 'AA' means anti-aliased
        self.chk_crt_mode.set_label(_("Tube Display Mode"))         # TRANSLATORS: 'Tube' means Cathode Ray Tube
        self.chk_grat_crosshair.set_label(_("Crosshair"))           
        self.chk_grat_divisions.set_label(_("Divisions"))          
        self.chk_grat_subdivisions.set_label(_("Sub-Divisions"))
        self.lbl_render_fps.set_label("")
        self.lbl_render_arenadims.set_label("")
        self.lbl_render_time.set_label("")
        self.lbl_render_wfms.set_label("")
        self.frm_disp_intensity.get_label_widget().set_label(_("Intensity"))
        self.frm_disp_rendering.get_label_widget().set_label(_("Rendering"))
        self.frm_disp_graticule.get_label_widget().set_label(_("Graticule"))

        # Create a button containing a label which is placed in the tab label position
        # The button captures tab clicked events to activate our click tab action (channel enable/disable)
        self.lbl_tab = Gtk.Label()
        self.lbl_tab.set_angle(90)
        self.lbl_tab.set_label(_("Display"))
        self.lbl_btn = Gtk.Button()
        self.lbl_btn.add(lbl_tab)
        self.lbl_btn.connect("clicked", self.tab_clicked)
        self.lbl_btn.show_all()
        
        # Add all relevant widgets to the CSS manager
        self.css_manager = CSSManager.CSSManager(DISPLAY_TAB_CSS_FILE)
        self.css_manager.add_widget(self.notebook, None)
        self.css_manager.add_widget(self.vbox, None)
        
        # Refresh channel object connection
        self.refresh_object_attach()
        self._update_probe_atten_options()
    
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
    
    @__state_change
    def _chk_crt_mode_toggle(self, *args):
        self.root_mgr.arena.set_crt_mode(self.chk_crt_mode.get_active())

    @__state_change
    def _chk_grat_crosshair_toggle(self, *args):
        pass

    @__state_change
    def _chk_grat_divisions_toggle(self, *args):
        pass

    @__state_change
    def _chk_grat_subdivisions_toggle(self, *args):
        pass

    @__state_change
    def _btn_disp_tog_dots_click(self, *args):
        pass

    @__state_change
    def _btn_disp_tog_dots_click(self, *args):
        pass

    @__state_change
    def _btn_disp_tog_vectors_click(self, *args):
        pass

    @__state_change
    def _btn_disp_tog_fast_click(self, *args):
        pass

    @__state_change
    def _btn_disp_tog_AA_click(self, *args):
        pass

    @__state_change
    def _scl_intensity_change(self, *args):
        self.root_mgr.arena.set_wave_intensity(self.scl_intensity.get_value() * 0.01) # Value is from 0-100, scale to 0-1

    @__state_change
    def _scl_grat_intensity_change(self, *args):
        pass

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
