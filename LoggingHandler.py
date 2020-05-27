"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import sys, logging

log = logging.getLogger(__name__)
log.setLevel(logging.INFO)

def set_file_logger(file_name, level=logging.INFO):
    fh = logging.FileHandler(file_name)
    fh.setLevel(level)
    log.addHandler(fh)

def set_console_logger(level=logging.DEBUG):
    ch = ANSIColouredConsoleLogger()
    ch.setLevel(level)
    log.addHandler(ch)

class ANSIColouredConsoleLogger(logging.StreamHandler):
    def __init__(self):
        super(ANSIColouredConsoleLogger, self).__init__()

    def emit(self, record):
        print("LoggingRecord %r" % record)

if __name__ == "__main__":    
    set_console_logger(logging.INFO)
    log.info("This is a test of INFO level")
    log.debug("This is a test of DEBUG level")
    log.warning("This is a test of WARNING level")
    log.error("This is a test of ERROR level")
    log.critical("This is a test of CRITICAL level")
