"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GdkPixbuf

gi.require_foreign("cairo")

# Load debug logger
import logging
log = logging.getLogger()

def draw_pixel_line(cr, sx, sy, ex, ey):
    pass

class ScopeArenaGraticuleRender(object):
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
    def __init__(self, pack_widget, pack_zone, pack_args=()):
        self.gtk_img = Gtk.Image()
        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.gtk_img, *pack_args)

        self.notify_resize()

    def notify_resize(self):
        rect = self.gtk_img.get_allocated_size().allocation
        log.info("New waveform zone size: %d x %d" % (rect.width, rect.height))

        # if no size allocated, don't generate pb
        if rect.width <= 0or rect.height <= 0:
            return

        pb = GdkPixbuf.Pixbuf()
        pb.new(GdkPixbuf.Colorspace.RGB, True, 8, rect.width, rect.height)
        pb.fill(0xffffffff)
        self.gtk_img.set_from_pixbuf(pb)