"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GdkPixbuf, GLib

import sys, os, time, mmap

gi.require_foreign("cairo")
import cairo

GRAT_RENDER_FRAME = 0x01
GRAT_RENDER_CROSSHAIR = 0x02
GRAT_RENDER_DIVISIONS = 0x04
GRAT_RENDER_SUBDIVISIONS = 0x08

MIN_WAVE_INTENSITY = 0.25
MAX_WAVE_INTENSITY = 5

PLT_SINGLE_COLOUR = 0
PLT_SINGLE_COLOUR_COMPRESS = 1
PLT_INVERT_SINGLE_COLOUR = 2
PLT_RAINBOW_THERMAL = 3

import Utils
import ZynqScope.ArmwaveRenderEngine as awre
import ZynqScope.ZynqScopeTask as zst

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
        self.render_cr = None
        self.output_cr = None
        self.dims = (0, 0)
        self.render_queued = False

    def set_context(self, cr, dims):
        """Set the Cairo context; if source dimensions have changed then True is returned, otherwise False."""
        if self.output_cr != None:
            pass # TODO: Cleanup?

        self.cr = cr

        if dims != self.dims:
            log.info("New dims.: %d x %d (cr:%r)" % (dims[0], dims[1], cr)) 
            self.dims = dims
            return True
        else:
            return False

    def apply_settings(self, hdiv, vdiv, hsubdiv, vsubdiv, xmarg, ymarg, ytopoff, grat_flags, grat_main_col, grat_sub_col, \
            grat_div_col, grat_brightness, grat_subsize):
        self.hdiv = int(hdiv)
        self.vdiv = int(vdiv)
        self.hsubdiv = int(hsubdiv)
        self.vsubdiv = int(vsubdiv)
        self.xmarg = int(xmarg)
        self.ymarg = int(ymarg)
        self.ytopoff = int(ytopoff)
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

        self.render_queued = True

    def sharp_line_to(self, x, y):
        self.cr.line_to(int(x) + 0.5, int(y) + 0.5)

    def sharp_move_to(self, x, y):
        self.cr.move_to(int(x) + 0.5, int(y) + 0.5)

    def get_wave_arena_dims(self):
        """Return the x,y origin for the wave arena, plus the width and height, as a 2-2-tuple."""
        x = self.xmarg
        y = self.ymarg + self.ytopoff
        w = self.dims[0] - self.xmarg - x
        h = self.dims[1] - self.ymarg - y - self.ytopoff
        return ((x, y), (w, h))

    def render(self):
        #if self.render_queued:
        #    self.cr = cairo.Context(cairo.Surface.create_similar(cairo.CONTENT_COLOR, self.dims[0], self.dims[1]))
        #    self._int_render()
        #    self.render_queued = False

        # copy working cr into output cr
        self._int_render()
        #self.render_queued = False

    def _int_render(self):
        #log.critical("ScopeArenaYTGraticuleRender render()")

        t0 = time.time()
        self.cr.set_line_width(1)

        x0 = self.xmarg
        x1 = self.dims[0] - self.xmarg
        xh = (x0 + x1) / 2
        y0 = self.ymarg + self.ytopoff
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
                xx = x0 + ((h + 1) * h_major_step)
                self.cr.new_path()
                self.sharp_move_to(xx, y0)
                self.sharp_line_to(xx, y1)
                self.cr.stroke()

            for v in range(self.vdiv - 1):
                yy = y0 + ((v + 1) * v_major_step)
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

                for v in range(self.vdiv):
                    y = y0 + (v * v_major_step)

                    for vsub in range(self.vsubdiv):
                        yy = y + (vsub * (v_major_step / self.vsubdiv))

                        self.cr.new_path()
                        self.sharp_move_to(xh - s, yy)
                        self.sharp_line_to(xh + s, yy)
                        self.cr.stroke()

                for h in range(self.hdiv):
                    x = x0 + (h * h_major_step)

                    for hsub in range(self.hsubdiv):
                        xx = x + (hsub * (h_major_step / self.hsubdiv))

                        self.cr.new_path()
                        self.sharp_move_to(xx, yh - s)
                        self.sharp_line_to(xx, yh + s)
                        self.cr.stroke()

        t1 = time.time()
        #log.info("Took %.1f ms to render graticule" % ((t1 - t0) * 1000))

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

    Most settings for the module are set via the configuration file but a few are passed via the 
    JSON configurator to allow configurations to be saved between devices.
    """

    mode_antialias = False
    mode_line = False
    wave_intensity = 0.5
    grat_intensity = 0.5
    palette_mode = 0

    pack_vars_types = {
        "wave_intensity":       [(float,), 0, 1],
        "grat_intensity":       [(float,), 0, 1],
        "mode_antialias":       [(bool,)],
        "mode_line":            [(bool,)],
        "palette_mode":         [(int,), 0, 3]
    } 

    def __init__(self, ctrl, cfg):
        self.cfg = cfg
        self.ctrl = ctrl

        # Default intensities and settings - some loaded from config
        self.grat_intensity = cfg.Render.GratDefaultIntensity
        self.wave_intensity = cfg.Render.WaveDefaultIntensity

        #self.local_aobj = awre.ArmwaveRenderEngine()

        self.grat_rdr = ScopeArenaYTGraticuleRender()
        self.grat_rdr.apply_settings(\
            cfg.Render.DisplayHDivisionsYT, cfg.Render.DisplayVDivisionsYT, \
            cfg.Render.DisplayHSubDivisionsYT, cfg.Render.DisplayVSubDivisionsYT, \
            cfg.Render.XMargin, cfg.Render.YMargin, cfg.Render.YTopOffset, cfg.Render.GratFlags, \
            cfg.Render.GratMainColour, cfg.Render.GratSubColour, cfg.Render.GratDivColour, \
            self.grat_intensity, cfg.Render.GratSubTickSize)

        self.size_allocated = False
        self.size_alloc = (0, 0)
        self.last_target_dims = (0, 0)
        self.first_draw = False
        self.test_mod = 0.0
        self.stat_waves = 0

        self.wave_pb = None
        self.xid = None
        self.dims = None

        self.set_wave_intensity(self.wave_intensity)
        self.set_graticule_intensity(self.grat_intensity)

    def gtk_attach(self, window, pack_widget, pack_zone, pack_args=()):
        self.fixed = Gtk.Layout()

        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.fixed, *pack_args)
        self.window = window

        """
        self.grat_da = Gtk.DrawingArea()
        self.grat_da.connect('draw', self._draw)
        self.fixed.put(self.grat_da, 0, 0)
        """

        self.img = Gtk.Image()
        #self.img.set_size_request(200, 200)
        self.fixed.put(self.img, 0, 0)
        #self.img.show()

        self.da = Gtk.DrawingArea()
        self.da.set_size_request(200, 200)
        self.fixed.put(self.da, 0, 0)

    def prepare_state(self):
        return Utils.pack_dict_json(self, self.pack_vars_types)
    
    def restore_state(self, json_dict):
        try:
            Utils.unpack_json(self, json_dict, self.pack_vars_types)
            self.set_wave_intensity(self.wave_intensity)
        except Exception as e:
            raise Utils.StateSaveFileCorrupted(_("Unable to restore configuration file for ScopeArena: Exception - %s" % str(e)))

        self.set_graticule_intensity(self.grat_intensity)
        self.set_wave_intensity(self.wave_intensity)
        self.set_palette_mode(self.palette_mode)

        log.critical("grat/wave restored intensity: %.3f, %.3f" % (self.grat_intensity, self.wave_intensity))
    
    def set_crt_mode(self, state):
        log.critical("CRT mode adjustment not implemented")

    def set_graticule_intensity(self, intensity):
        if self.ctrl.zst != None:
            intensity = min(intensity, 1.0) 
            self.ctrl.zst.setup_render_graticule_base_colour(Utils.get_rgb_tuple_from_hex(int(self.cfg.Render.GratMainColour, 0)))
            self.ctrl.zst.setup_render_graticule_intensity(intensity)
            self.grat_intensity = intensity

    def set_wave_intensity(self, intensity):
        if self.ctrl.zst != None:
            intensity = min(intensity, 1.0) 
            self.ctrl.zst.setup_render_channel_intensity(1, intensity)
            self.wave_intensity = intensity

    def set_palette_mode(self, pmode):
        if self.ctrl.zst != None:
            self.ctrl.zst.setup_render_palette_mode(1, pmode)
            self.palette_mode = pmode

    def notify_resize(self):
        """Resize notifier."""
        log.warn("notify_resize")
        self.update_size_allocation()
        #self.grat_da.queue_draw()

    def notify_channel_colour_change(self):
        """Update channel colour if an intensity has changed."""
        # We only support 1ch for now
        #self.local_aobj.set_channel_colour(1, self.ctrl.channels[0].get_rgb_colour())
        if self.ctrl.zst != None:
            log.info("notify_channel_colour_change() - updating channel colour")
            self.ctrl.zst.setup_render_channel_colour(1, self.ctrl.channels[0].get_rgb_colour())

    def update_size_allocation(self):
        rect = self.fixed.get_allocated_size().allocation

        # if no size allocated, don't change anything
        if rect.width <= 0 or rect.height <= 0:
            log.warn("Waveform zone size is zero, not allocating yet")
            return False

        new_alloc = (rect.width, rect.height)
        log.info("new_alloc: %s" % repr(new_alloc))

        if self.size_alloc != new_alloc:
            #log.debug("New alloc: %d x %d" % new_alloc)
            #self.grat_da.set_size_request(rect.width, rect.height)
            self.size_alloc = (rect.width, rect.height)
            self.size_allocated = True
            return True
        
        return False

    def update(self):
        #if not self.first_draw:
        #    log.warn("Not done first redraw, skipping update")
        #    return
        xid = self.window.get_window()
        alloc = self.fixed.get_allocation()
        new_dims = (alloc.x, alloc.y, alloc.width, alloc.height)

        #log.info("allocation: %d,%d" % (alloc.width, alloc.height))
        #log.info("positions:  %d,%d" % (alloc.x, alloc.y))

        if xid != None:
            if self.xid != xid.get_xid():
                log.info("New window: %s (XID: %d)" % (repr(xid), xid.get_xid()))
                self.ctrl.zst.set_xid(xid.get_xid())
                self.xid = xid.get_xid()

            if self.dims != new_dims:
                self.ctrl.zst.set_draw_dims(*new_dims)
                self.dims = new_dims

    def _draw(self, wdg, cr):
        """Draw/expose callback"""
        #log.info("_draw()")

        # need to also check for general invalidation
        #if not self.update_size_allocation():
        #   log.warn("Skip grat. redraw - no size change")
        #    return

        # Redraw graticule if size has changed
        if cr != None:
            self.grat_rdr.set_context(cr, self.size_alloc)
            #self.grat_da.set_size_request(self.size_alloc[0], self.size_alloc[1])
            #self.grat_rdr.render()
            #self.grat_da.queue_draw()

        targ_dims = self.grat_rdr.get_wave_arena_dims()
        width, height = targ_dims[1]
        #log.info("set_target_dimensions(%d x %d)" % (width, height))

        ox, oy = targ_dims[0]
        self.fixed.move(self.img, ox, oy)
        
        # Drive the renderer
        #if width != self.last_target_dims[0] or height != self.last_target_dims[1]:
        #    self.ctrl.zst.setup_render_dimensions(width, height)

        #self.local_aobj.update_wave_params(0, width, 96, width)
        #self.local_aobj.set_target_dimensions(width, height)
        
        self.first_draw = True
        self.last_target_dims = (width, height)

        # Make a new pixbuf and force a redraw(?)
        #self.wave_pb = GdkPixbuf.Pixbuf.new_from_bytes(GLib.Bytes(bytes(mmap_obj)), GdkPixbuf.Colorspace.RGB, True, 8, width, height, width * 4)
        #self.wave_pb = GdkPixbuf.Pixbuf.new(GdkPixbuf.Colorspace.RGB, True, 8, width, height)

