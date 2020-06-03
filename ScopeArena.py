"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

gi.require_foreign("cairo")

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
    def __init__(self, pack_widget, pack_zone, pack_args=(,)):
        self.gtk_img = Gtk.Image()
        call_ = getattr(pack_widget, pack_zone)
        assert(callable(call_))
        call_(self.gtk_img, *pack_args)
