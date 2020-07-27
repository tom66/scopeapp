"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, os, mmap, ctypes, stat, time, random
from ctypes import util, cdll

import ZynqScope.ZynqScope as zs
import ZynqScope.armwave.armwave as aw

import multiprocessing

DEFAULT_SCALED_INTENSITY = 5

# catch SIGSEGV, SIGABRT, etc.
import faulthandler
faulthandler.enable()

import logging
log = logging.getLogger()

SHM_NAME_TEMPLATE = b"scopeapp_aw_dbuff%d_0x%08x"

# Portions based on:-
# https://gist.github.com/jakirkham/100a7f5e86b0ff2a22de0850723a4c5c
# ** Licence unclear **

lib = util.find_library('rt')
assert(lib != None)

rtld = cdll.LoadLibrary(lib)
_shm_open = rtld.shm_open
_shm_unlink = rtld.shm_unlink

def shm_open(name):
    name = ctypes.create_string_buffer(name)

    result = _shm_open(
        name,
        ctypes.c_int(os.O_RDWR | os.O_CREAT),  #  | os.O_EXCL
        ctypes.c_ushort(stat.S_IRUSR | stat.S_IWUSR)
    )

    if result == -1:
        raise RuntimeError(os.strerror(ctypes.get_errno()))

    return result

def shm_unlink(name):
    name = ctypes.create_string_buffer(name)
    result = _shm_unlink(name)

    if result == -1:
        raise RuntimeError(os.strerror(ctypes.get_errno()))

class ArmwaveRenderEngine(zs.BaseRenderEngine):
    """Default Y-T Render Engine using ArmWave."""

    def __init__(self):
        log.info("Initialising ArmwaveRenderEngine")

        # Initialise ArmWave
        aw.init()
        aw.init_x11()

        self.done_test_wave = False

        self.channel_colours = {}
        self.channel_ints = {}
        self.xid = None
        self.last_draw_dims = None

        # TODO:  Pass # of expected channels
        for n in range(4):
            self.channel_colours[n + 1] = (0, 255, 0)
            self.channel_ints[n + 1] = 10

    def update_wave_params(self, start_t, end_t, n_waves, wave_stride):
        self.wave_params = (start_t, end_t, n_waves, wave_stride)
        log.info("update_wave_params: new %s" % repr(self.wave_params))

    def set_channel_colour(self, index, colour):
        col = list(colour)
        col = list(map(lambda x: int(x * DEFAULT_SCALED_INTENSITY), col)) + [1.0, 1]
        self.channel_colours[index] = colour  # Store colour
        aw.set_channel_colour(index, *col)
        aw.set_channel_palette(index, aw.PLT_SINGLE_COLOUR_COMPRESS)

    def set_channel_brightness(self, index, brightness):
        # Global brightness or independent brightness?  Why not both?
        #colour = self.channel_colours[index]
        #col = list(colour)
        #col = list(map(lambda x: int(x * brightness), col)) + [1.0, 1]
        self.channel_ints[index] = brightness
        #aw.set_channel_colour(index, *col)
        #aw.set_channel_palette(index, aw.PLT_SINGLE_COLOUR)
        if (brightness > 1.0):
            raise ValueError("Intensity out of range %.3f" % brightness)
        aw.set_channel_render_intensity(index, int(brightness * 255))

    def set_xid(self, xid):
        #log.critical("Trying to grab xid %d [NAWT]" % xid)
        log.critical("doing XWindow stuff %s" % repr(xid))
        if xid != None:
            aw.grab_xid(xid)
            #aw.create_xwindow()
            aw.init_xvimage_shared(1216, 256)
            aw.set_graticule_dims(10, 12, 8, 5, 5, 0.2)
            log.critical("Completed")
            self.xid = xid

    def set_draw_dims(self, x, y, w, h):
        log.info("set_draw_dims(%d,%d,%d,%d)" % (x, y, w, h))
        aw.set_draw_dims(x, y, w, h)
        self.last_draw_dims = (x, y, w, h)

    def set_target_dimensions(self, width, height):
        """Set new target dimensions and return requested size."""
        log.info("set_target_dimensions(%d,%d)" % (width, height))

        if width == 0 and height == 0:
            raise ValueError("zero size buffer in set_target_dimensions")

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, \
            aw.AM_FLAG_GRAT_RENDER_FRAME | aw.AM_FLAG_GRAT_RENDER_DIVS | aw.AM_FLAG_GRAT_RENDER_SUBDIV)
        #aw.test_create_am_sine(0.25, 1e-5, 8)
        aw.init_xvimage_shared(64, 256)
        log.warning("setup_render done")

        # setup test wavesets
        #self.test_waveset_count = 10
        #log.info("start generating %d wavesets" % self.test_waveset_count)

        #aw.test_create_am_sine(0.1, 10e-6, self.test_waveset_count)
        #log.info("done generating %d wavesets" % self.test_waveset_count)

        return (0, 0)

    def fixup_timebase(self):
        """Sort out anything else that needs to be cleaned up after a timebase change."""
        if self.last_draw_dims != None:
            aw.set_draw_dims(*self.last_draw_dims)

    def set_nwaves(self, nwaves):
        aw.inform_waves(nwaves)

    def render_single_mmal(self, mmal_data_ptr, mmal_trig_buff_ptr):
        if self.xid:
            log.info("mmal=0x%08x" % mmal_data_ptr)
            aw.set_wave_pointer_u32(mmal_data_ptr)
            aw.set_trig_corr_buffer_u32(mmal_trig_buff_ptr)
            aw.set_graticule_colour(90, 90, 90)
            aw.render_frame_x11()

        return None