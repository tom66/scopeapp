"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import configparser

DEFAULT_CONFIG_FILENAME = "main.cfg"

config_defaults = {}

def infer_type(x):
    """For a given value `x' attempt to infer the type.  Return either a float value
    or a string value."""
    try:
        return float(x)
    except ValueError:
        return str(x)

class ConfigSubClass(object):
    __dict = None
    __depth = 0
    __name = ""
    
    def __init__(self, _dict, _depth, _name):
        self.__dict = _dict
        self.__depth = _depth
        self.__name = _name

    def __getattr__(self, key):
        # Determine if key exists; if not raise an AttributeError
        if key not in self.__dict.keys():
            raise AttributeError("Key %r not an element of ConfigParser dict" % key)
        
        # If the key contains no subitems (the item is not a Section) return the key directly
        if not isinstance(self.__dict[key], configparser.SectionProxy):
            return infer_type(self.__dict[key])
        
        # Otherwise, create a new ConfigSubClass
        sub = ConfigSubClass(self.__dict[key], self.__depth + 1, key)
        return sub

    def __repr__(self):
        out = []
        
        for key in self.__dict:
            if key != "__dict":
                out.append(repr(key))
        
        return "<ConfigSubClass %s [%s]>" % (self.__name, ", ".join(out))

class AppConfigManager(object):
    """
    This class handles management of the config files.  It supports saving
    existing config files to disk, and loading and applying new config files.
    
    It uses configparser as its core, which is a native Python INI file parser.
    """
    def __init__(self, filename=DEFAULT_CONFIG_FILENAME):
        self.c = configparser.ConfigParser(config_defaults, interpolation=configparser.ExtendedInterpolation())
        self.c.read(filename)
        self.subclass = ConfigSubClass(self.c, 0, "root")
    
    def __getitem__(self, key):
        return self.c[key]

    def __getattr__(self, key):
        return getattr(self.subclass, key)