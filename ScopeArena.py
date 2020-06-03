"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GdkPixbuf

import sys, os, time

gi.require_foreign("cairo")
import cairo

GRAT_RENDER_FRAME = 0x01
GRAT_RENDER_CROSSHAIR = 0x02
GRAT_RENDER_DIVISIONS = 0x04
GRAT_RENDER_SUBDIVISIONS = 0x08

import Utils

# Load debug logger
import logging
log = logging.getLogger()

def scale_colour_ignore_alpha(col, scale):
    scale = Utils.clamp(scale, 0.0, 1.0)
     
    red =  col & 0x000000ff
    grn = (col & 0x0000ff00) >> 8
    blu = (col & 0x00ff0000) >> 16
    alp =  col & 0xff000000

    #log.info("%s" % repr([col, red, grn, blu, alp]))

    # scale values and clamp
    red *= scale
    red  = int(Utils.clamp(red, 0, 255))
    grn *= scale
    grn  = int(Utils.clamp(grn, 0, 255))
    blu *= scale
    blu  = int(Utils.clamp(blu, 0, 255))
    
    return alp | (blu << 16) | (grn << 8) | red

def colour32_to_cairo(col):
    red  =  col & 0x000000ff
    grn  = (col & 0x0000ff00) >> 8
    blu  = (col & 0x00ff0000) >> 16
    alp  = (col & 0xff000000) >> 24

    red *= 1.0 / 255.0
    grn *= 1.0 / 255.0
    blu *= 1.0 / 255.0
    alp *= 1.0 / 255.0

    return (alp, red, grn, blu)

class ScopeArenaYTGraticuleRender(object):
    def __init__(self):
        self.cr = None

    def set_context(self, cr):
        if self.cr != None:
            self.cr.finish()
        self.cr = cr

    def apply_settings(self, hdiv, vdiv, xmarg, ymarg, grat_flags, grat_main_col, grat_sub_col, grat_brightness):
        self.hdiv = hdiv
        self.vdiv = vdiv
        self.xmarg = xmarg
        self.ymarg = ymarg
        self.grat_flags = int(grat_flags, 0)

        # Compute actual main colour with brightness
        #log.info("%r" % grat_main_col)
        #log.info("%r" % grat_sub_col)

        self.grat_main_col = scale_colour_ignore_alpha(int(grat_main_col, 0), grat_brightness)
        self.grat_sub_col = scale_colour_ignore_alpha(int(grat_sub_col, 0), grat_brightness)

        log.info("Graticule: flags: 0x%02x, main colour: 0x%08x, sub colour: 0x%08x (computed from brightness %.1f)" % \
            (self.grat_flags, self.grat_main_col, self.grat_sub_col, grat_brightness))

    def render_to_pixbuf(self, pb):
        for n in range(10):
            t0 = time.time()
            pb.fill(0xff000000)
            t1 = time.time()
            print(t1 - t0)

class ScopeArenaController(object):
    """
    ScopeArena:
    
    This module contains classes to render the "arena" of the instrument, which is the waveform and 
    graticule display.
    
    Static content is rendered using Cairo and committed to a GdkBuffer.  The waveform data is rendered 
    atop this static image using X Window System compositing.  The static image is updated if user
    input requires, but generally stays the same.
    """
    def __init__(self, cfg, window, pack_widget, pack_zone, pack_args=()):
        self.fixed = Gtk.Fixed()
        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.fixed, *pack_args)

        self.cfg = cfg
        self.window = window

        self.grat_rdr = ScopeArenaYTGraticuleRender()
        self.grat_rdr.apply_settings(\
            cfg.Render.DisplayHDivisionsYT, cfg.Render.DisplayVDivisionsYT, \
            cfg.Render.XMargin, cfg.Render.YMargin, cfg.Render.GratFlags, \
            cfg.Render.GratMainColour, cfg.Render.GratSubColour, cfg.Render.GratBrightness)

    def notify_resize(self, size_available):
        """Resize notifier.  The `size_available` parameter encodes the available space
        for waveform rendering, after the menus and toolbars etc are removed."""
        # request a size slightly smaller than the size_available figure
        self.fixed.set_size_request(size_available[0] - 16, size_available[1] - 16)
        rect = self.fixed.get_allocated_size().allocation

        # if no size allocated, don't change anything
        if rect.width <= 0 or rect.height <= 0:
            log.warn("Waveform zone size is zero, not allocating yet")
            return

        # create a Cairo surface which is similar to our window surface for best performance
        # we use get_window() to get the GdkWindow of the GtkWindow, and no, that's not confusing at all.
        self.grat_cr = self.window.get_window().create_similar_surface(cairo.Content.COLOR_ALPHA, rect.width, rect.height)
        self.grat_rdr.set_context(self.grat_cr)

        #pb = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, True, 8, rect.width, rect.height)
        #
        #self.gratrdr.render_to_pixbuf(pb)
        #
        #log.error("PixBuf: %r (%r)" % (repr(pb), rect))
        #
        #self.gtk_img.set_from_pixbuf(pb)
        #self.gtk_img.queue_draw()