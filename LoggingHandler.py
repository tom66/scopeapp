"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import sys, logging

log = logging.getLogger()
log.setLevel(logging.DEBUG)

def set_file_logger(logger, file_name, level=logging.INFO):
    fh = BasicFileLogger(file_name)
    fh.setLevel(level)
    logger.addHandler(fh)

def set_console_logger(logger, level=logging.DEBUG):
    ch = ANSIColouredConsoleLogger()
    ch.setLevel(level)
    logger.addHandler(ch)

def get_logger():
    set_console_logger(log, logging.DEBUG)
    return log

class BasicFileLogger(logging.StreamHandler):
    start_time = None

    def __init__(self, file_name):
        super(BasicFileLogger, self).__init__()
        self.fp = open(file_name, "w")

    def emit(self, record):
        if self.start_time == None:
            self.start_time = record.created

        ev_time = record.created - self.start_time
        out = ""

        msg = (record.msg % record.args).replace("\r", "").replace("\n", "")
        loc = "~%s:%d" % (record.module, record.lineno)
        out += "[%8s %8.3f] %-12s %-22s %s\r\n" % (record.levelname, ev_time, "@" + record.threadName, loc, msg)
        self.fp.write(out)

    def flush(self):
        self.fp.flush()

# The below codes are optimised for PuTTY/KiTTY
ANSI_COLOUR_CRITICAL = "\033[95m"
ANSI_COLOUR_ERROR = "\033[31m"
ANSI_COLOUR_WARNING = "\033[33m"
ANSI_COLOUR_INFO = "\033[97m"
ANSI_COLOUR_DEBUG = "\033[37m"
ANSI_COLOUR_RESET = "\033[0m"

class ANSIColouredConsoleLogger(logging.StreamHandler):
    start_time = None

    def __init__(self):
        super(ANSIColouredConsoleLogger, self).__init__()

    def emit(self, record):
        if self.start_time == None:
            self.start_time = record.created

        if record.levelno >= logging.CRITICAL:
            code = ANSI_COLOUR_CRITICAL
        elif record.levelno >= logging.ERROR:
            code = ANSI_COLOUR_ERROR
        elif record.levelno >= logging.WARNING:
            code = ANSI_COLOUR_WARNING
        elif record.levelno >= logging.INFO:
            code = ANSI_COLOUR_INFO
        else:
            code = ANSI_COLOUR_DEBUG

        ev_time = record.created - self.start_time
        out = ""

        msg  = (record.msg % record.args).replace("\r", "").replace("\n", "")
        loc  = "~%s:%d" % (record.module, record.lineno)
        out  = "[%s%8s%s " % (code, record.levelname, ANSI_COLOUR_RESET)
        out += "%8.3f] %-12s %-22s %s%s%s\r\n" % (ev_time, "@" + record.threadName, log, code, msg, ANSI_COLOUR_RESET)
        sys.stdout.write(out)

        #if record.levelno >= logging.ERROR:
        #    sys.stderr.write(out)

    def flush(self):
        sys.stdout.flush()
        #sys.stderr.flush()

if __name__ == "__main__":
    set_file_logger("ScopeApp.log")
    set_console_logger(logging.DEBUG)

    while True:
        log.debug("This is a test of DEBUG level")
        log.info("This is a test of INFO level")
        log.warning("This is a test of WARNING level")
        log.error("This is a test of ERROR level")
        log.critical("This is a test of CRITICAL level")

