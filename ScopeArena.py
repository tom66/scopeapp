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

    return (red, grn, blu, alp)

class ScopeArenaYTGraticuleRender(object):
    def __init__(self):
        self.cr = None
        self.dims = (0, 0)

    def set_context(self, cr, dims):
        dims = (dims[0].width, dims[0].height)
        log.warn(repr(dims))

        if self.cr != None:
            pass # TODO: Cleanup?

        self.cr = cr
        log.info("New dims.: %d x %d" % (dims[0], dims[1])) 
        #self.cr.scale(dims[0], dims[1])
        self.dims = dims

    def apply_settings(self, hdiv, vdiv, hsubdiv, vsubdiv, xmarg, ymarg, grat_flags, grat_main_col, grat_sub_col, \
            grat_div_col, grat_brightness, grat_subsize):
        self.hdiv = int(hdiv)
        self.vdiv = int(vdiv)
        self.hsubdiv = hsubdiv
        self.vsubdiv = vsubdiv
        self.xmarg = xmarg
        self.ymarg = ymarg
        self.grat_flags = int(grat_flags, 0)
        self.grat_subsize = grat_subsize

        if (self.hdiv % 2) != 0:
            raise ValueError("Horizontal division count must be even")

        if (self.vdiv % 2) != 0:
            raise ValueError("Vertical division count must be even")

        # Compute actual main colour with brightness
        #log.info("%r" % grat_main_col)
        #log.info("%r" % grat_sub_col)

        self.grat_main_col = colour32_to_cairo(scale_colour_ignore_alpha(int(grat_main_col, 0), grat_brightness))
        self.grat_div_col = colour32_to_cairo(scale_colour_ignore_alpha(int(grat_div_col, 0), grat_brightness))
        self.grat_sub_col = colour32_to_cairo(scale_colour_ignore_alpha(int(grat_sub_col, 0), grat_brightness))

        log.info("Graticule: flags: 0x%02x, main colour: %r, sub colour %r (computed from brightness %.1f)" % \
            (self.grat_flags, self.grat_main_col, self.grat_sub_col, grat_brightness))

    def sharp_line_to(self, x, y):
        self.cr.line_to(int(x) + 0.5, int(y) + 0.5)

    def sharp_move_to(self, x, y):
        self.cr.move_to(int(x) + 0.5, int(y) + 0.5)

    def render(self):
        # Select main colour
        self.cr.set_line_width(1)

        x0 = self.xmarg
        x1 = self.dims[0] - self.xmarg
        xh = (x0 + x1) / 2
        y0 = self.ymarg
        y1 = self.dims[1] - self.ymarg - 1
        yh = (y0 + y1) / 2

        # Draw outer frame
        if self.grat_flags & GRAT_RENDER_FRAME:
            self.cr.set_source_rgba(*self.grat_main_col)
            self.cr.new_path()
            self.sharp_move_to(x0, y0)
            self.sharp_line_to(x1, y0)
            self.sharp_line_to(x1, y1)
            self.sharp_line_to(x0, y1)
            self.cr.close_path()
            self.cr.stroke()

        # Draw major grids
        if self.grat_flags & GRAT_RENDER_DIVISIONS:
            self.cr.set_source_rgba(*self.grat_div_col)

            h_major_step = (x1 - x0) / self.hdiv
            v_major_step = (y1 - y0) / self.vdiv
            xx = 0
            yy = 0

            for h in range(self.hdiv - 1):
                xx = self.xmarg + ((h + 1) * h_major_step)
                self.cr.new_path()
                self.sharp_move_to(xx, y0)
                self.sharp_line_to(xx, y1)
                self.cr.stroke()

            for v in range(self.vdiv - 1):
                yy = self.ymarg + ((v + 1) * v_major_step)
                self.cr.new_path()
                self.sharp_move_to(x0, yy)
                self.sharp_line_to(x1, yy)
                self.cr.stroke()

        # Draw inner crosshair
        if self.grat_flags & GRAT_RENDER_CROSSHAIR:
            self.cr.set_source_rgba(*self.grat_main_col)
            self.cr.new_path()
            self.sharp_move_to(xh, y0)
            self.sharp_line_to(xh, y1)
            self.cr.close_path()
            self.cr.stroke()
            self.cr.new_path()
            self.sharp_move_to(x0, yh)
            self.sharp_line_to(x1, yh)
            self.cr.close_path()
            self.cr.stroke()

            if self.grat_flags & GRAT_RENDER_SUBDIVISIONS:
                h_major_step = (x1 - x0) / self.hdiv
                v_major_step = (y1 - y0) / self.vdiv
                s = self.grat_subsize * 0.5

                for vdiv in range(self.vdiv - 1):
                    y = self.ymarg + ((v + 1) * v_major_step)

                    for vsub in range(self.vsubdiv):
                        yy = y + (vsub * (v_major_step / self.vsubdiv))

                        self.cr.new_path()
                        self.sharp_move_to(xh - s, yy)
                        self.sharp_line_to(xh + s, yy)
                        self.cr.stroke()

class ScopeArenaController(object):
    """
    ScopeArena:
    
    This module contains classes to render the "arena" of the instrument, which is the waveform and 
    graticule display.
    
    Static content is rendered using Cairo and committed to a surface.  The waveform data is rendered 
    atop this static image using X Window System compositing.  The static image is updated if user
    input requires, but generally stays the same if settings are not changed.  Side widgets and cursors
    are added via another compositing layer.  The hope is that this maximises performance on limited
    hardware.
    """
    def __init__(self, cfg, window, pack_widget, pack_zone, pack_args=()):
        self.fixed = Gtk.Fixed()
        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.fixed, *pack_args)
        
        self.grat_da = Gtk.DrawingArea()
        self.grat_da.connect('draw', self._draw)
        self.fixed.put(self.grat_da, 0, 0)

        self.size_allocated = False

        self.cfg = cfg
        self.window = window

        self.grat_rdr = ScopeArenaYTGraticuleRender()
        self.grat_rdr.apply_settings(\
            cfg.Render.DisplayHDivisionsYT, cfg.Render.DisplayVDivisionsYT, \
            cfg.Render.DisplayHSubDivisionsYT, cfg.Render.DisplayVSubDivisionsYT, \
            cfg.Render.XMargin, cfg.Render.YMargin, cfg.Render.GratFlags, \
            cfg.Render.GratMainColour, cfg.Render.GratSubColour, cfg.Render.GratDivColour, \
            cfg.Render.GratBrightness, cfg.Render.GratSubTickSize)

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
        self.grat_da.set_size_request(rect.width, rect.height)
        #self.grat_surf = self.window.get_window().create_similar_surface(cairo.Content.COLOR_ALPHA, rect.width, rect.height)
        #self.grat_cr = cairo.Context(self.grat_surf)
        #self.grat_rdr.set_context(self.grat_cr, (rect.width, rect.height))
        #print(self.grat_cr)

        self.size_allocated = True
        self.grat_da.queue_draw()

        #pb = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, True, 8, rect.width, rect.height)
        #
        #self.gratrdr.render_to_pixbuf(pb)
        #
        #log.error("PixBuf: %r (%r)" % (repr(pb), rect))
        #
        #self.gtk_img.set_from_pixbuf(pb)
        #self.gtk_img.queue_draw()

    def _draw(self, wdg, cr):
        log.info("Cairo redraw arena")
        self.grat_rdr.set_context(cr, wdg.get_allocated_size())
        self.grat_rdr.render()