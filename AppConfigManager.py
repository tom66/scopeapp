"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import configparser

DEFAULT_CONFIG_FILENAME = "main.cfg"

config_defaults = {}

class AppConfigManager(object):
    """
    This class handles management of the config files.  It supports saving
    existing config files to disk, and loading and applying new config files.
    
    It uses configparser as its core, which is a native Python INI file parser.
    """
    def __init__(self, filename=DEFAULT_CONFIG_FILENAME):
        self.c = configparser.ConfigParser(config_defaults, interpolation=configparser.ExtendedInterpolation())
        self.c.read(filename)
        
    def __getitem__(self, key):
        return self.c[key]