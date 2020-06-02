import sys, operator, math

sys.path.append('..')

import ZynqScope.ArmwaveRenderEngine as awre

# configure logger
import LoggingHandler, logging
log = logging.getLogger()
LoggingHandler.set_console_logger(log, logging.DEBUG)

# create armwave object
aobj = awre.ArmwaveRenderEngine()

def main():
    print("aobj set_channel_colour")
    aobj.set_channel_colour(1, (25, 180, 250), 10)
    print("aobj set_target_dimensions")
    aobj.set_target_dimensions(2048, 768)
    print("aobj test_create_am_sine")
    aobj.test_create_am_sine()
    print("aobj render_test_to_ppm")
    aobj.render_test_to_ppm("armwave_test.ppm")
    print("aobj render_test")
    aobj.render_test()
    print("all done")

if __name__ == "__main__":
    main()
