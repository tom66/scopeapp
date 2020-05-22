"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import time, random, struct

import ZynqScope.ZynqCommandSet as zcmd
import ZynqScope.ZynqSPI as zspi

class ZynqCommandException(Exception): pass
class ZynqCommandResponseParseError(ZynqCommandException): pass

class ZynqAcqStatus(object):
    num_acq = 0
    flags = 0
    
    def __repr__(self):
        return "<ZynqAcqStatus flags=0x%04x num_acq=%d>" % (self.flags, self.num_acq)

# Not all of these modes are currently implemented;  use only the 8-bit 1 channel mode for now
ACQ_MODE_8B_1CH  = 0x0021
ACQ_MODE_8B_2CH  = 0x0041
ACQ_MODE_8B_4CH  = 0x0081
ACQ_MODE_12B_1CH = 0x0022
ACQ_MODE_12B_2CH = 0x0042
ACQ_MODE_12B_4CH = 0x0082
ACQ_MODE_14B_1CH = 0x0024
ACQ_MODE_14B_2CH = 0x0044
ACQ_MODE_14B_4CH = 0x0084
ACQ_MODE_DOUBLE_BUFFER = 0x0800

ACQ_DATA_MODES = [ACQ_MODE_8B_1CH,  ACQ_MODE_8B_2CH,  ACQ_MODE_8B_4CH, 
                  ACQ_MODE_12B_1CH, ACQ_MODE_12B_2CH, ACQ_MODE_12B_4CH, 
                  ACQ_MODE_14B_1CH, ACQ_MODE_14B_2CH, ACQ_MODE_14B_4CH]

TRIG_CH_ADCSRC1 = 0x00
TRIG_CH_ADCSRC2 = 0x01
TRIG_CH_ADCSRC3 = 0x02
TRIG_CH_ADCSRC4 = 0x03
TRIG_CH_AC_LINE = 0xfe
TRIG_CH_EXT = 0xff

TRIG_CHANNELS = [TRIG_CH_ADCSRC1, TRIG_CH_ADCSRC2, TRIG_CH_ADCSRC3, TRIG_CH_ADCSRC4,
                 TRIG_CH_AC_LINE, TRIG_CH_EXT]

TRIG_EDGE_NEVER = 0
TRIG_EDGE_FALLING = 1
TRIG_EDGE_RISING = 2
TRIG_EDGE_BOTH = 3
TRIG_EDGE_NONE = 4

TRIG_EDGE_MODES = [TRIG_EDGE_NEVER, TRIG_EDGE_FALLING, TRIG_EDGE_RISING, 
                   TRIG_EDGE_BOTH, TRIG_EDGE_NONE]
 
TRIGLVL_MIN = 0
TRIGLVL_MAX = 2047

TRIG_HOLDOFF_MIN = 16
TRIG_HOLDOFF_MAX = 34359738367

COMP0_ACQ_STOP = 0x0001
COMP0_ACQ_GET_STATUS = 0x0002
COMP0_ACQ_REWIND = 0x0004
COMP0_ACQ_START_RESET_FIFO = 0x0008
COMP0_ACQ_START_NO_RESET_FIFO = 0x0010
COMP0_ACQ_SWAP_ACQ_LISTS = 0x0020
COMP0_CSI_TRANSFER_WAVES = 0x0040
COMP0_CSI_TRANSFER_BITPACK = 0x0080
COMP0_CSI_TRANSFER_TRIGPOS = 0x0100
COMP0_SPI_RESP_CSI_SIZE = 0x1000
COMP0_SPI_RESP_COUNTERS = 0x2000
COMP0_SPI_RESP_MEAS = 0x4000
COMP0_SPI_RESP_HEALTH = 0x8000

CSI_TPAT_NORWAY = 1
CSI_TPAT_ZEROES = 2
CSI_TPAT_ONES = 3
CSI_TPAT_BER = 4
CSI_TPAT_32B_COUNTER = 5
CSI_TPAT_16B_COUNTER = 6
CSI_TPAT_8B_COUNTER = 7

def _pack_64b_int_arg(arg):
    """Helper function to pack a 64-bit integer argument."""
    return ((arg >> 56) & 0xff), ((arg >> 48) & 0xff), ((arg >> 40) & 0xff), ((arg >> 32) & 0xff), \
           ((arg >> 24) & 0xff), ((arg >> 16) & 0xff), ((arg >> 8) & 0xff), (arg & 0xff)

def _pack_32b_int_arg(arg):
    """Helper function to pack a 32-bit integer argument."""
    return ((arg >> 24) & 0xff), ((arg >> 16) & 0xff), ((arg >> 8) & 0xff), (arg & 0xff)

def _pack_16b_int_arg(arg):
    """Helper function to pack a 16-bit integer argument."""
    return ((arg >> 8) & 0xff), (arg & 0xff)

def _pack_8b_int_arg(arg):
    """Helper function to pack an 8-bit integer argument."""
    return ((arg & 0xff),)
    
class ZynqCommands(object):
    def __init__(self):
        self.zspi = zspi.ZynqSPI()
        self.self_test()
    
    def self_test(self):
        """Self test of SPI interface and read back of software and bitstream version."""
        # Send two random integers: we expect the response to be two header bytes plus
        # these response bytes
        """
        r0 = random.randint(0, 255)
        r1 = random.randint(0, 255)
        resp = zspi.str2ordlist(self.zspi.send_command_read_response(zcmd._HELLO, [r0, r1]))
        
        print(resp)
        
        if len(resp) != 4:
            raise ZynqCommandResponseParseError("Wrong response length from HELLO (%r)" % resp) 
        
        if resp[0] != 0x55 or resp[1] != 0xcc:
            raise ZynqCommandResponseParseError("Wrong response header from HELLO (%r)" % resp)
        
        if resp[2] != r0 or resp[3] != r1:
            raise ZynqCommandResponseParseError("Wrong response echo from HELLO (%r)" % resp)
        """
        
        # Read version information
        resp = self.zspi.send_command_read_response(zcmd._VERSION)
        unpack_resp = struct.unpack("IIII", resp)
        self.ver_bitstream_id = unpack_resp[0]
        self.ver_bitstream_usraccess = unpack_resp[1]
        self.ver_ps_app_id = unpack_resp[2]
        self.ver_timestamp = unpack_resp[3]
        
        print("Zynq: FPGA (PL): Bitstream 0x%08x, usraccess 0x%08x" % (self.ver_bitstream_id, self.ver_bitstream_usraccess))
        print("Zynq:  ARM (PS): Appl. ID  0x%08x, timestamp 0x%08x" % (self.ver_ps_app_id, self.ver_timestamp))
    
    def setup_triggered_acquisition(self, pre_size, post_size, number_acq, data_mode):
        """
        Setup a triggered acquisition.  Current acquisition is stopped, and new
        settings for the acquisition are configured.
        """
        assert (data_mode & ~ACQ_MODE_DOUBLE_BUFFER) in ACQ_DATA_MODES
        
        print("setup_triggered_acquisition(pre=%d, post=%d, n=%d, mode=0x%02x)"% (pre_size, post_size, number_acq, data_mode))
        
        self.zspi.send_command_ignore_response(zcmd._ACQ_STOP)
        self.zspi.send_command_ignore_response(zcmd._ACQ_SETUP_TRIGGERED, \
            _pack_32b_int_arg(pre_size) + \
            _pack_32b_int_arg(post_size) + \
            _pack_32b_int_arg(number_acq) + \
            _pack_16b_int_arg(data_mode))
    
    def start_acquisition(self, reset_fifo=1):
        """Start the acquisition.  The acquisition should have already been configured, 
        otherwise this will break things. Note: to execute this immediately the queue 
        must be flushed."""
        assert (reset_fifo == 0 or reset_fifo == 1)
        self.zspi.queue_command_ignore_response(zcmd._ACQ_START, args=[reset_fifo])

    def stop_acquisition(self):
        """Stop the acquisition.  The acquisition should be running already, although
        stopping an already stopped acquisition has no effect. Note: to execute this 
        immediately the queue must be flushed."""
        self.zspi.queue_command_ignore_response(zcmd._ACQ_STOP)
    
    def rewind_acquisition(self):
        """Rewind the current acquisition, allowing an existing configuration to be
        reused.  Existing buffers remain and no data is erased. Note: to execute 
        this immediately the queue must be flushed."""
        self.zspi.queue_command_ignore_response(zcmd._ACQ_REWIND)

    def setup_trigger_always(self):
        """Setup an always trigger."""
        self.zspi.queue_command_ignore_response(zcmd._TRIG_CONFIGURE_ALWAYS)
    
    def setup_trigger_holdoff(self, holdoff):
        """Setup the trigger holdoff.  Holdoff is specified in nanoseconds and
        has a range from 16 ns to 34.35 seconds.  Values out of range raise exceptions."""
        if holdoff < TRIG_HOLDOFF_MIN or holdoff > TRIG_HOLDOFF_MAX:
            raise ValueError("Holdoff out of bounds")
        
        self.zspi.queue_command_ignore_response(zcmd._TRIG_CONFIGURE_HOLDOFF, \
            _pack_64b_int_arg(holdoff))
    
    def setup_trigger_edge(self, ch, level, hyst, edge):
        """Setup the edge trigger."""
        assert ch in TRIG_CHANNELS
        assert edge in TRIG_EDGE_MODES
        
        if level < TRIGLVL_MIN or level > TRIGLVL_MAX:
            raise ValueError("Trigger level out of bounds")
        
        if (hyst / 2) > level:
            raise ValueError("Hysteresis too large for selected trigger level (would exceed valid range)")
         
        self.zspi.queue_command_ignore_response(zcmd._TRIG_CONFIGURE_EDGE, \
            _pack_8b_int_arg(ch) + \
            _pack_8b_int_arg(edge) + \
            _pack_16b_int_arg(level) + \
            _pack_16b_int_arg(hyst))
    
    def trigger_arm(self):
        """Arm the trigger.  Note: to execute this immediately the queue must be flushed."""
        self.zspi.queue_command_ignore_response(zcmd._TRIG_ARM)
        
    def trigger_disarm(self):
        """Disarm the trigger.  Note: to execute this immediately the queue must be flushed."""
        self.zspi.queue_command_ignore_response(zcmd._TRIG_DISARM)
    
    def trigger_force(self):
        """Force the trigger.  Note: to execute this immediately the queue must be flushed."""
        self.zspi.queue_command_ignore_response(zcmd._TRIG_FORCE)
    
    def acq_status(self):
        """Return an ZynqAcqStatus object representing the acquisition engine status (or None if
        an error occurs.)"""
        try:
            resp = self.zspi.send_command_read_response(zcmd._ACQ_STATUS, args=[], expected_resp_size=6)
        except ZynqCommandResponseParseError as e:
            print("Exception reading Zynq acquistion status, ignored and returning None: %r" % e)
            return None

        #print(repr(resp))
        status = ZynqAcqStatus()
        status.num_acq, status.flags = struct.unpack("Ih", resp)
        
        return status

    def csi_setup_test_pattern(self, testpatt, size = 0, init_value = 0):
        """Queue command to setup a test pattern stream via CSI."""
        self.zspi.queue_command_ignore_response(zcmd._CSI_SETUP_TESTPATT, \
            _pack_32b_int_arg(size) + \
            _pack_32b_int_arg(init_value) + \
            _pack_8b_int_arg(testpatt))

    def csi_setup_addr_range(self, start, end):
        """Queue command to setup an address range CSI transfer.  This can be used
        for diagnostics, to read the raw memory of the Zynq, for instance.  There is
        no handling for invalid addresses, besides ensuring that the start and end
        values are consecutive and that they are 32-bit aligned."""
        if start > end:
            raise ValueError("Start address higher than end address")

        if (start % 4) != 0 or (end % 4) != 0:
            raise ValueError("Start or end address not 32-bit aligned")
        
        self.zspi.queue_command_ignore_response(zcmd._CSI_SETUP_ADDR_RANGE, \
            _pack_32b_int_arg(start), # err, is this correct?
            _pack_32b_int_arg(end))
    
    def csi_setup_wave_range(self, start, end):
        """Queue command to setup a waveform export range CSI transfer.  This
        is used to retrieve trigger-point corrected waveforms from the acquisition
        memory.  The size of the returned transfer should be equal to the
        size of any one waveform multiplied by the number of waves requested."""
        if start > end:
            raise ValueError("Start waveindex higher than end waveindex")

        self.zspi.queue_command_ignore_response(zcmd._CSI_SETUP_WAVE_RANGE, \
            _pack_32b_int_arg(start), # err, is this correct?
            _pack_32b_int_arg(end))

    def csi_stream_unpop_start(self):
        """Queue command to stop streaming CSI data from the earliest command in queue.
        Check the status to see if the CSI controller is still running."""
        self.zspi.queue_command_ignore_response(zcmd._CSI_STREAM_START)
    
    def csi_stream_unpop_start_all(self):
        """Cause all CSI commands to be executed in the queue and sent in the order they
        were enqueued."""
        self.zspi.queue_command_ignore_response(zcmd._CSI_STREAM_START_ALL)

    def csi_status(self):
        """Retrieve the CSI module status from the Zynq."""
        try:
            resp = self.zspi.send_command_read_response(zcmd._CSI_STATUS, args=[], expected_resp_size=8)
        except ZynqCommandResponseParseError as e:
            print("Exception reading Zynq acquistion status, ignored and returning None: %r" % e)
            return None
        
        return resp

    def csi_setup_params(self, wordcount, data_type):
        self.zspi.queue_command_ignore_response(zcmd._CSI_SET_PARAMS_QUEUE, \
            _pack_16b_int_arg(wordcount) + (data_type,))

    def comp_acq_control(self, flags):
        """Composite acquisition control and CSI data transfer."""
        # The response takes time to generate, and varies according to the flags, so set the expected response size to None
        resp = self.zspi.send_command_read_response(zcmd._COMP0, args=_pack_16b_int_arg(flags), expected_resp_size=None) 
        print(repr(resp))
    
    def nop_mark(self):
        """Emit 0xfe into the queue as a debugging NOP."""
        self.zspi.queue_command_ignore_response(zcmd._NOP_MARK)

    def flush(self):
        self.zspi.flush_command_queue()
