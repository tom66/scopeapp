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
    """Default Y-T Render Engine using ArmWave."""
    def __init__(self):
        self._shm_name = b"scopeapp_aw_dispbuff"
        self._shm_id = None
        self._shm_size = 0
        self._mmap = None
        # Free existing memory if present
        #if self._shm_id != None:
        #    self._mmap.close()

        try:
            shm_unlink(self._shm_name)
            log.info("shm_unlinked")
        except:
            pass

        #try:
        #    self._mmap.close()
        #    os.close(self._shm_id)
        #    log.info("_mmap close()")
        #except:
        #    pass

        self._shm_id = shm_open(self._shm_name)

        # default wave parameters
        self.wave_params = (0, 2048, 64, 2048)
        aw.init()

        self.done_test_wave = False

    def update_wave_params(self, start_t, end_t, n_waves, wave_stride):
        self.wave_params = (start_t, end_t * 2, n_waves, wave_stride * 2)
        #log.info("update_wave_params: new %s" % repr(self.wave_params))

    def set_channel_colour(self, index, colour, brightness):
        col = list(colour)
        col = map(lambda x: x * brightness, col)
        aw.set_channel_colour(index, *col)

    def set_target_dimensions(self, width, height):
        new_size = width * height * 4  # 4 bytes per pixel
        if self._shm_size == new_size:
            return
        self._shm_size = new_size
        try:
            self._mmap.close()
            #os.close(self._shm_id)
            log.info("_mmap close()")
        except:
            pass
        os.ftruncate(self._shm_id, self._shm_size)
        self._mmap = mmap.mmap(self._shm_id, self._shm_size)

        log.info("available_wave_params: new %s" % repr(self.wave_params))
        #log.info("_shm_id: %d" % self._shm_id)

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, 0)
        log.info("setup_render done")

        # setup test wavesets
        self.test_waveset_count = 10
        log.info("start generating %d wavesets" % self.test_waveset_count)

        aw.test_create_am_sine(0.1, 10e-6, self.test_waveset_count)
        log.info("done generating %d wavesets" % self.test_waveset_count)

    """
    def render_test_to_ppm(self, fn):
        # clear the buffer to black
        log.info("clear_buffer")
        aw.clear_buffer(0)

        # allocate buffer for test waveform
        log.info("test_buffer_alloc")
        aw.test_buffer_alloc()

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
    """

    def render_test(self, index):
        log.info("clear_buffer")
        aw.clear_buffer(0)

        #log.info("test_buffer_alloc")
        #aw.test_buffer_alloc()

        #log.info("test_create_am_sine")

        log.info("set_wave_pointer_as_testbuf %d" % index)
        aw.set_wave_pointer_as_testbuf(index % self.test_waveset_count)

        log.info("test_generate")
        aw.test_generate()

        # filling the mmap pointer with the rendered buffer (renders into the buffer)
        log.info("fill_pixbuf_into_pybuffer(%r)" % self._mmap)

        if not aw.fill_pixbuf_into_pybuffer(self._mmap):
            raise RuntimeError("fail")

        #print(bytes(self._mmap))

        log.info("done")

    def render_test_pb(self, gdkbuf, index):
        #log.info("clear_buffer")
        aw.clear_buffer(0)

        #log.info("test_buffer_alloc")
        #aw.test_buffer_alloc()

        #log.info("test_create_am_sine")
        #if not self.done_test_wave:
        #    aw.test_create_am_sine(mod, noise)
        #    self.done_test_wave = True

        #log.info("set_wave_pointer_as_testbuf %d" % index)
        aw.set_wave_pointer_as_testbuf(index % self.test_waveset_count)

        #log.info("test_generate")
        aw.test_generate()

        # filling the mmap pointer with the rendered buffer (renders into the buffer)
        #log.info("fill_pixbuf_into_pybuffer(%r)" % self._mmap)

        aw.test_fill_gdkbuf(gdkbuf)

        #print(bytes(self._mmap))

        #log.info("done")

    """
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
    """

    def get_shm_name(self):
        return self._shm_name

    def get_shm_id(self):
        return self._shm_id

    def get_shm_size(self):
        return self._shm_size
