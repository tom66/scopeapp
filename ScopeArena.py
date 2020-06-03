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

# Load debug logger
import logging
log = logging.getLogger()

class ScopeArenaGraticuleRender(object):
    def __init__(self, hdiv, vdiv, xmarg, ymarg, grat_flags, grat_main_col, grat_sub_col):
        self.hdiv = hdiv
        self.vdiv = vdiv
        self.xmarg = xmarg
        self.ymarg = ymarg
        self.grat_flags = grat_flags
        self.grat_main_col = grat_main_col
        self.grat_sub_col = grat_sub_col
        log.info("Graticule: flags: 0x%02x, main colour: 0x%08x, sub colour: 0x%08x" % self.grat_flags, self.grat_main_col, self.grat_sub_col)

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
        self.gratrdr = ScopeArenaGraticuleRender(\
            cfg.Render.DisplayHDivisionsYT, cfg.Render.DisplayVDivisionsYT, \
            cfg.Render.XMargin, cfg.Render.YMargin, cfg.Render.GratFlags, \
            cfg.Render.GratMainColour, cfg.Render.GratSubColour)

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