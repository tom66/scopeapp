"""
This file is part of YAOS and is licenced under the MIT licence.
"""

from datetime import datetime
import sys, strftime

if sys.version_info.major < 3 or sys.version_info.minor < 8:
    raise EnvironmentError("Python 3.8 or higher required.  Try running with python3 or python3.8.")

import UIController

# configure logger
import LoggingHandler
import logging

# Default logger configuration
log = logging.getLogger(__name__)
log.setLevel(logging.NOTSET)

class ScopeAppLauncher(object):
    def __init__(self):
        self.uiapp = UIController.MainApplication()
    
    def run(self):
        self.uiapp.run()

if __name__ == "__main__":
    log.info("Starting YAOS Application on %s" % datetime.now().strftime("%c"))
    log.info("Python %s" % sys.version)

    launcher = ScopeAppLauncher()
    launcher.run()
