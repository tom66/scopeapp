"""
This file is part of YAOS and is licenced under the MIT licence.
"""

from datetime import datetime
import sys

if sys.version_info.major < 3 or sys.version_info.minor < 8:
    raise EnvironmentError("Python 3.8 or higher required.  Try running with python3 or python3.8.")

import UIController
import AppConfigManager

# configure logger
import LoggingHandler

LoggingHandler.set_console_logger(log, logging.DEBUG)
log = logging.getLogger()

class ScopeAppLauncher(object):
    def __init__(self):
        self.cfgmgr = AppConfigManager.AppConfigManager()
        self.uiapp = UIController.MainApplication(self.cfgmgr)

    def run(self):
        self.uiapp.run()

if __name__ == "__main__":
    log.info("Starting YAOS Application on %s" % datetime.now().strftime("%c"))
    log.info("Python %s" % sys.version)

    launcher = ScopeAppLauncher()
    launcher.run()
