"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, os, mmap, ctypes, stat, time, random
from ctypes import util, cdll

import ZynqScope.ZynqScope as zs
import ZynqScope.armwave.armwave as aw

import multiprocessing

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

        # TODO:  Pass # of expected channels
        for n in range(4):
            self.channel_colours[n + 1] = (0, 255, 0)
            self.channel_ints[n + 1] = 10

    def update_wave_params(self, start_t, end_t, n_waves, wave_stride):
        self.wave_params = (start_t, end_t, n_waves, wave_stride)
        log.info("update_wave_params: new %s" % repr(self.wave_params))

    def set_channel_colour(self, index, colour):
        col = list(colour)
        col = list(map(lambda x: int(x * self.channel_ints[index]), col)) + [1.0,]
        self.channel_colours[index] = colour  # Store colour
        aw.set_channel_colour(index, *col)

    def set_channel_brightness(self, index, brightness):
        # Global brightness or independent brightness?  Why not both?
        colour = self.channel_colours[index]
        col = list(colour)
        col = list(map(lambda x: int(x * brightness), col)) + [1.0,]
        self.channel_ints[index] = brightness
        aw.set_channel_colour(index, *col)

    def set_xid(self, xid):
        log.critical("Trying to grab xid %d [NAWT]" % xid)
        #aw.grab_xid(xid)
        aw.create_xwindow()
        aw.set_graticule_colour(90, 90, 90)
        aw.set_graticule_dims(0, 12, 8, 5, 5, 0.2)
        log.critical("Completed")

    def set_target_dimensions(self, width, height):
        """Set new target dimensions and return requested size."""
        log.info("set_target_dimensions(%d,%d)" % (width, height))

        if width == 0 and height == 0:
            raise ValueError("zero size buffer in set_target_dimensions")

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, \
            aw.AM_FLAG_GRAT_RENDER_FRAME | aw.AM_FLAG_GRAT_RENDER_DIVS)
        aw.init_xvimage_shared(width, height)
        aw.test_create_am_sine(0.25, 1e-5, 8)
        log.warning("setup_render done")

        # setup test wavesets
        #self.test_waveset_count = 10
        #log.info("start generating %d wavesets" % self.test_waveset_count)

        #aw.test_create_am_sine(0.1, 10e-6, self.test_waveset_count)
        #log.info("done generating %d wavesets" % self.test_waveset_count)

        return (0, 0)

    def render_single_mmal(self, mmal_data_ptr):
        # Acquire the presently working shm.  Block until it is available.
        #self._shm_buffers[self._shm_working_index][2].acquire()
        #buf = self._shm_buffers[self._shm_working_index]

        #aw.render_frame_x11()

        #mmap_obj = mmap.mmap(buf[1], buf[3])

        #log.info("mmap_obj: %s length %d" % (repr(mmap_obj), len(mmap_obj)))

        """
        t0 = time.time()
        aw.clear_buffer(0)
        t1 = time.time()
        #log.info("TA: %.1f" % ((t1 - t0) * 1000))

        aw.set_wave_pointer_u32(mmal_data_ptr)
        
        t0 = time.time()
        aw.generate()
        t1 = time.time()
        #log.info("TB: %.1f" % ((t1 - t0) * 1000))

        #log.info("start fill into pixbuf")

        t0 = time.time()
        if not aw.fill_pixbuf_into_pybuffer(mmap_obj):
            mmap_obj.close()
            raise RuntimeError("Pixbuf render failed with PyFalse: possibly corrupt pointer?")
        t1 = time.time()
        #log.info("TC: %.1f" % ((t1 - t0) * 1000))
        """

        # Close the mmap.  We're done working with it.
        #mmap_obj.close()

        # Release the working shm.  Swap buffers.
        #working = self._shm_working_index
        #self._shm_swap()
        #self._shm_buffers[working][2].release()

        # ONLY use the display shm returned by this call as it is not otherwise guaranteed to be 
        # synchronised with the correct buffer.
        #return self._shm_get_display()

        aw.render_frame_x11()
        return None