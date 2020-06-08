"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, os, mmap, ctypes, stat
from ctypes import util, cdll

import ZynqScope.ZynqScope as zs
import ZynqScope.armwave.armwave as aw

import multiprocessing

# catch SIGSEGV, SIGABRT, etc.
import faulthandler
faulthandler.enable()

import logging
log = logging.getLogger()

SHM_NAME_TEMPLATE = b"scopeapp_aw_dbuff%d_x"

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
    _shm_buffers = []
    _shm_size = 0
    _shm_working_index = None
    _shm_display_index = None

    def __init__(self):
        log.info("Initialising ArmwaveRenderEngine")

        # default size
        self._create_shms(640 * 480 * 4)

        # Initialise ArmWave
        aw.init()

        self.done_test_wave = False

        self.channel_colours = {}
        self.channel_ints = {}

        # TODO:  Pass # of expected channels
        for n in range(4):
            self.channel_colours[n + 1] = (0, 255, 0)
            self.channel_ints[n + 1] = 10

    def _create_shms(self, size):
        self._shm_buffers = []
        self._shm_working_index = 0
        self._shm_display_index = 1
        self._shm_size = size

        lock_mgr = multiprocessing.Manager()

        for i in range(2):
            # Create a new shm and store the fd (ID) and shm name
            shm_name = SHM_NAME_TEMPLATE % i
            shm_id = shm_open(shm_name)
            os.ftruncate(shm_id, size)
            #m = mmap.mmap(shm_id, size)
            sem = lock_mgr.Lock()

            self._shm_buffers.append((shm_name, shm_id, sem, size))
            log.info("Create SHM by name %s id %d (%d bytes)" % (shm_name, shm_id, size))

    def _resize_shms(self, size):
        new_shm = []

        for shm in self._shm_buffers:
            log.info("Resize SHM by name %s id %d to %d bytes (was %d bytes)" % (shm[0], shm[1], size, shm[3]))
            os.ftruncate(shm[1], size)
            new_shm.append((shm[0], shm[1], shm[2], size))

        self._shm_buffers = new_shm

    def update_wave_params(self, start_t, end_t, n_waves, wave_stride):
        self.wave_params = (start_t, end_t, n_waves, wave_stride)
        log.info("update_wave_params: new %s" % repr(self.wave_params))

    def set_channel_colour(self, index, colour):
        col = list(colour)
        col = map(lambda x: int(x * self.channel_ints[index]), col)
        self.channel_colours[index] = colour  # Store colour
        aw.set_channel_colour(index, *col)

    def set_channel_brightness(self, index, brightness):
        # Global brightness or independent brightness?  Why not both?
        colour = self.channel_colours[index]
        col = list(colour)
        col = map(lambda x: int(x * brightness), col)
        self.channel_ints[index] = brightness
        aw.set_channel_colour(index, *col)

    def set_target_dimensions(self, width, height):
        """Set new target dimensions and return requested size."""
        new_size = width * height * 4  # 4 bytes per pixel
        if self._shm_size == new_size:
            return
        self._shm_size = new_size

        self._resize_shms(new_size)

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, 0)
        log.info("setup_render done")

        # setup test wavesets
        #self.test_waveset_count = 10
        #log.info("start generating %d wavesets" % self.test_waveset_count)

        #aw.test_create_am_sine(0.1, 10e-6, self.test_waveset_count)
        #log.info("done generating %d wavesets" % self.test_waveset_count)

        return new_size

    def get_requested_shms(self):
        """Return the list of requested SHMs for the parent process to create for us.  This ensures that
        the fds are accessible from both parent and child."""
        shms = []

        for i in range(2):
            shm_name = SHM_NAME_TEMPLATE % i
            shms.append((shm_name, self._shm_size))

        return shms

    def render_single_mmal(self, mmal_data_ptr):
        # Acquire the presently working shm.  Block until it is available.
        self._shm_buffers[self._shm_working_index][2].acquire()
        buf = self._shm_buffers[self._shm_working_index]

        mmap_obj = mmap.mmap(buf[1], buf[3])

        log.info("mmap_obj: %s length %d" % (repr(mmap_obj), len(mmap_obj)))

        aw.clear_buffer(0)
        aw.set_wave_pointer_u32(mmal_data_ptr)
        aw.generate()

        log.info("start fill into pixbuf")

        if not aw.fill_pixbuf_into_pybuffer(mmap_obj):
            mmap_obj.close()
            raise RuntimeError("Pixbuf render failed with PyFalse: possibly corrupt pointer?")

        # Close the mmap.  We're done working with it.
        #mmap_obj.close()

        # Release the working shm.  Swap buffers.
        working = self._shm_working_index
        self._shm_swap()
        self._shm_buffers[working][2].release()

        # ONLY use the display shm returned by this call as it is not otherwise guaranteed to be 
        # synchronised with the correct buffer.
        return self._shm_get_display()

    def _shm_get_display(self):
        return self._shm_buffers[self._shm_display_index]

    def _shm_get_working(self):
        return self._shm_buffers[self._shm_working_index]

    def _shm_swap(self):
        log.info("shms: %d %d" % (self._shm_display_index, self._shm_working_index))
        temp = self._shm_display_index
        self._shm_working_index = self._shm_display_index
        self._shm_display_index = temp
