"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, os, mmap, ctypes, stat
from ctypes import util, cdll

import ZynqScope.ZynqScope as zs
import ZynqScope.armwave.armwave as aw

import logging
log = logging.getLogger()

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
    def __init__(self):
        self._shm_name = b"scopeapp_aw_dispbuff"
        self._shm_id = None
        self._shm_size = 0
        self._mmap = None

        self.wave_params = (0, 2048, 64, 2048)
        aw.init()

    def set_channel_colour(self, index, colour, brightness):
        col = list(colour)
        col = map(lambda x: x * brightness, col)
        aw.set_channel_colour(index, *col)

    def set_target_dimensions(self, width, height):
        # Free existing memory if present
        if self._shm_id != None:
            self._mmap.close()

        try:
            shm_unlink(self._shm_name)
        except:
            pass

        self._shm_id = shm_open(self._shm_name)
        self._shm_size = width * height * 4  # 4 bytes per pixel
        os.ftruncate(self._shm_id, self._shm_size)
        self._mmap = mmap.mmap(self._shm_id, self._shm_size)

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, 0)
        log.info("setup_render done")

    def render_test_to_ppm(self, fn):
        # clear the buffer to black
        log.info("clear_buffer")
        aw.clear_buffer(0)

        # create a test sine wave
        log.info("test_create_am_sine")
        aw.test_create_am_sine(0.25, 1e-6)

        # set the wavepointer
        log.info("set_wave_pointer_as_testbuf")
        aw.set_wave_pointer_as_testbuf()

        # generate the rendered pre-targets
        log.info("test_generate")
        aw.test_generate()

        # generate the final image into the working buffer
        log.info("test_fill_outbuf")
        aw.test_fill_outbuf()

        # dump the working buffer into a ppm
        log.info("test_dump_buffer_to_ppm(%s)" % fn)
        aw.test_dump_buffer_to_ppm(fn)

        log.info("done")

    def render_test(self):
        log.info("clear_buffer")
        aw.clear_buffer(0)

        log.info("test_create_am_sine")
        #aw.test_create_am_sine(0.25, 1e-6)

        log.info("set_wave_pointer_as_testbuf")
        #aw.set_wave_pointer_as_testbuf()

        log.info("test_generate")
        aw.test_generate()

        # filling the mmap pointer with the rendered buffer (renders into the buffer)
        log.info("fill_pixbuf_into_pybuffer(%r)" % self._mmap)
        if not aw.fill_pixbuf_into_pybuffer(self._mmap):
            raise RuntimeError("fail")

        log.info("done")

    def render_block(self, data_ptr):
        log.info("src data_ptr=%d" % data_ptr)

        log.info("clear_buffer")
        aw.clear_buffer(0)

        log.info("set_wave_pointer_u32")
        aw.set_wave_pointer_u32(data_ptr)

        log.info("test_generate")
        aw.test_generate()

        log.info("fill_pixbuf_into_pybuffer(%r)" % self._mmap)
        aw.fill_pixbuf_into_pybuffer(self._mmap)

        log.info("done")

    def get_shm_name(self):
        return self._shm_name
