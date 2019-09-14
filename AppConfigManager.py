"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import configparser

DEFAULT_CONFIG_FILENAME = "main.cfg"
DEFAULT_THEME_FILENAME = "theme_dark.cfg"

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
        
        self.t = configparser.ConfigParser(interpolation=configparser.ExtendedInterpolation())
            
        # Read the theme defined in the config file.  If that can't be read then try to fall
        # over to the DEFAULT_THEME_FILENAME.
        try:
            self.theme_name = self.c.get('Theme', 'theme_file')
            self.t.read(self.theme_name)
        except:
            self.theme_name = DEFAULT_THEME_FILENAME
            self.t.read(self.theme_name)