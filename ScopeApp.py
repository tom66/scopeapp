"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import sys

if sys.version_info.major < 3 and sys.version_info.minor <= 8:
    raise EnvironmentError("Python 3.8 or higher required.  Try running with python3 or python3.8.")

import UIController

class ScopeAppLauncher(object):
    def __init__(self):
        self.uiapp = UIController.MainApplication()
    
    def run(self):
        self.uiapp.run()

if __name__ == "__main__":
    print("Starting YAOS Application...")
    launcher = ScopeAppLauncher()
    launcher.run()
