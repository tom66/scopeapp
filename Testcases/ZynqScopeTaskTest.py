import sys
import multiprocessing as mp

sys.path.append('..')

import ZynqScope.ZynqScopeTask as zst

# Load debug logger
import logging
log = logging.getLogger()

log.info("ZynqScoepTaskTest initialise")

evq = mp.Queue()
rsq = mp.Queue()
acqrsp = mp.Queue()
renq = mp.Queue()
mdict = mp.Manager().dict()

obj = zst.ZynqScopeSubprocess(evq, rsq, acqrsp, renq, mdict, (2048, 12))

evq.put(zst.ZynqScopeInitTrigger())
evq.put(zst.ZynqScopeStartAutoAcquisition())

zst.run()