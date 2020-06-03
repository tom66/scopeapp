"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GdkPixbuf

gi.require_foreign("cairo")

GRAT_RENDER_FRAME = 0x01
GRAT_RENDER_CROSSHAIR = 0x02
GRAT_RENDER_DIVISIONS = 0x04
GRAT_RENDER_SUBDIVISIONS = 0x08

import Utils

# Load debug logger
import logging
log = logging.getLogger()

def scale_gdkcolour_ignore_alpha(col, scale):
    scale = Utils.clamp(scale, 0.0, 1.0)
     
    red =  col & 0x000000ff
    grn = (col & 0x0000ff00) >> 8
    blu = (col & 0x00ff0000) >> 16
    alp =  col & 0xff000000

    log.info("%s" % repr(red, grn, blu, alp))

    # scale values and clamp
    red *= scale
    red  = Utils.clamp(red, 0, 255)
    grn *= scale
    grn  = Utils.clamp(grn, 0, 255)
    blu *= scale
    blu  = Utils.clamp(blu, 0, 255)
    
    return alp | (blu << 16) | (grn << 8) | red

class ScopeArenaGraticuleRender(object):
    def __init__(self):
        pass

    def apply_settings(self, hdiv, vdiv, xmarg, ymarg, grat_flags, grat_main_col, grat_sub_col, grat_brightness):
        self.hdiv = hdiv
        self.vdiv = vdiv
        self.xmarg = xmarg
        self.ymarg = ymarg
        self.grat_flags = int(grat_flags, 0)

        # Compute actual main colour with brightness
        self.grat_main_col = scale_gdkcolour_ignore_alpha(int(grat_main_col, 0), grat_brightness)
        self.grat_sub_col = scale_gdkcolour_ignore_alpha(int(grat_sub_col, 0), grat_brightness)

        log.info("Graticule: flags: 0x%02x, main colour: 0x%08x, sub colour: 0x%08x (computed from brightness %.1f)" % \
            (self.grat_flags, self.grat_main_col, self.grat_sub_col, grat_brightness))

    def render_to_pixbuf(self, pb):
        pass

class ScopeArenaController(object):
    """
    ScopeArena:
    
    This module contains classes to render the "arena" of the instrument, which is the waveform and 
    graticule display.
    
    Static content is rendered using Cairo and committed to a GdkBuffer.  The waveform data is rendered 
    atop this static image using X Window System compositing.  The static image is updated if user
    input requires, but generally stays the same.
    """
    def __init__(self, cfg, pack_widget, pack_zone, pack_args=()):
        self.gtk_img = Gtk.Image()
        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.gtk_img, *pack_args)

        self.cfg = cfg
        self.gratrdr = ScopeArenaGraticuleRender()
        self.gratrdr.apply_settings(\
            cfg.Render.DisplayHDivisionsYT, cfg.Render.DisplayVDivisionsYT, \
            cfg.Render.XMargin, cfg.Render.YMargin, cfg.Render.GratFlags, \
            cfg.Render.GratMainColour, cfg.Render.GratSubColour, cfg.Render.GratBrightness)

        self.notify_resize()

    def notify_resize(self):
        # BUG: Since our widget expands to the requested size, it is difficult to resize the window.
        # We need to find a way to support resizing, at some point in the future.
        rect = self.gtk_img.get_allocated_size().allocation
        log.info("New waveform zone size: %d x %d" % (rect.width, rect.height))

        # if no size allocated, don't generate pb
        if rect.width <= 0 or rect.height <= 0:
            log.warn("Waveform zone size is zero, not allocating yet")
            return

        pb = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, True, 8, rect.width, rect.height)
        pb.fill(0xff0000ff)

        log.error("PixBuf: %r (%r)" % (repr(pb), rect))

        self.gtk_img.set_from_pixbuf(pb)
        self.gtk_img.queue_draw()