"""
This file is part of YAOS and is licenced under the MIT licence.
"""

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
