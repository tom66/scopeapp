"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys, os, mmap, ctypes, stat
from ctypes import util, cdll

import ZynqScope.ZynqScope as zs
import ZynqScope.armwave.armwave as aw

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
        ctypes.c_int(os.O_RDWR | os.O_CREAT | os.O_EXCL),
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
            shm_unlink(self._shm_name)
            self._mmap.close()

        try:
            self._shm_id = shm_open(self._shm_name)
        except RuntimeError:
            # try again after unlinking the shm name, in case we didn't exit cleanly last time
            shm_unlink(self._shm_name)
            self._shm_id = shm_open(self._shm_name)  

        self._shm_size = width * height * 4  # 4 bytes per pixel
        os.ftruncate(self._shm_id, self._shm_size)
        self._mmap = mmap.mmap(self._shm_id, self._shm_size)

        # Setup armwave
        aw.cleanup()
        aw.setup_render(self.wave_params[0], self.wave_params[1], self.wave_params[2], self.wave_params[3], width, height, 0)

    def render_block(self, data_ptr):
        aw.clear_buffer(0)
        aw.set_wave_pointer(data_ptr)
        aw.fill_pixbuf_into_pybuffer(self._mmap)

    def get_shm_name(self):
        return self._shm_name