#!/usr/bin/env python3

"""
setup.py file for SWIG example
"""

from distutils.core import setup, Extension

armwave_module = Extension('_armwave',
                          include_dirs=['/opt/vc/include'],
                          sources=['armwave_wrap.c', 'armwave.c'],
                          libraries=[],
                          library_dirs=['/opt/vc/lib'],
)

setup (name = 'armwave',
       version = '0.0.1',
       author      = "T",
       description = """ARM based fast analogue waveform renderer""",
       ext_modules = [armwave_module],
       py_modules = ["armwave"],
       )
