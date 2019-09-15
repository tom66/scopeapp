"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import gettext
gettext.bindtextdomain('yaosapp', '/lang')
gettext.textdomain('yaosapp')
_ = gettext.gettext

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

LAYOUT_FILE = "Layout1.gtkbuilder"

# Import configuration manager
import AppConfigManager

class MainApplication(object):
    """
    MainApplication handles the main application UI thread as well as starting the
    various service tasks that run the oscilloscope application.  
    
    It doesn't handle anything to do with waveform acquisition or rendering.  Those
    are handled from within WaveApp and the GL application.
    """
    
    def __init__(self):
        """
        Init function.  This loads the GUI configuration, the application configurator,
        and the theme engine.
        """
        # Create a configuration manager.  The configuration manager loads the default
        # configuration file and the theme defined in the configuration file.
        self.cfgmgr = AppConfigManager.AppConfigManager()
        
        # Load the GtkBuilder application object.
        self.builder = Gtk.Builder()
        self.builder.add_from_file(LAYOUT_FILE)
    
    def run(self):
        """
        Start the MainApplication.  This launches all required threads and shows the user interface.
        """
        self.builder.show_all()
        Gtk.main_loop()
