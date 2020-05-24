"""
This file is part of YAOS and is licenced under the MIT licence.
"""

import spidev, time, copy
from crccheck.crc import Crc8Maxim

STATE_CMD_IDLE = 0
STATE_CMD_OUTPUT = 1
STATE_CMD_READ_FIRST = 2
STATE_CMD_READ = 3

STATE_RESP_IDLE = 0
STATE_RESP_WAIT_FOR_SIZE = 1
STATE_RESP_READ_SIZE_1 = 2
STATE_RESP_READ_SIZE_2 = 3
STATE_RESP_READ_DATA = 4
STATE_RESP_DONE = 5

# TODO: These might need to be configurable
SPI_DEVICE_ID = 0
SPI_DEVICE_CS = 1
SPI_MODE = 1
SPI_SPEED_HZ = 18000000

SPI_DEFAULT_TIMEOUT = 2.0
SPI_DEFAULT_BURST_SIZE = 8
SPI_LONGEST_COMMAND = 18

SPI_READ_BLOCK_SIZE_INITIAL = 32

SPI_SMALL_PACKET_SIZE = 128
SPI_LARGE_PACKET_SIZE = 32383

# Time required for processor to prepare response
SPI_RESP_DELAY = 60e-6

# Initial number of NOPS to write on start up to flush any FIFOs and get state machine
# into right state.
SPI_INIT_NOPS = 4095

def prepare_buf(size):
    """Return an empty buffer of `size' bytes."""
    return copy.copy([0] * size)

def str2ordlist(x):
    """Convert bytestring to list of values"""
    return list(map(ord, x))

class ZynqSPIException(Exception): pass
class ZynqSPITimeoutException(ZynqSPIException): pass

class ZynqSPI(object):
    def __init__(self):
        self.spi = spidev.SpiDev()
        self.spi.open(SPI_DEVICE_ID, SPI_DEVICE_CS)
        self.spi.max_speed_hz = SPI_SPEED_HZ
        self.spi.mode = SPI_MODE
        self.spi.loop = False
        self.spi_burst_size = SPI_DEFAULT_BURST_SIZE
        self.spi_timeout = SPI_DEFAULT_TIMEOUT
        self.cmd_queue = []
        self.init_nop_purge()  # This fixes things, most of the time
    
    def init_nop_purge(self):
        # Write a large number of NOPs to purge data from the FIFO before starting
        #print("NOP Purge")
        self.spi.xfer2(prepare_buf(SPI_INIT_NOPS), self.spi.max_speed_hz, 0, 8)
        self.flush_command_queue()

    def start_timeout(self):
        self.event_start = time.time()
    
    def exceed_timeout(self, timeout):
        return (time.time() - self.event_start) > self.spi_timeout
    
    def exceed_timeout_exception(self, timeout):
        if (time.time() - self.event_start) > self.spi_timeout:
            raise ZynqSPITimeoutException
    
    def _pack_command(self, cmd, args=[]):
        """Pack a command into a SPI bytestring."""
        #assert(len(args) <= 16)
        cmd_pack = [cmd] + list(args)
        crc = Crc8Maxim.calc(cmd_pack)
        #crc = 0xff
        cmd_pack += [crc, 0x00]
        return cmd_pack
        #return [0x70, 0xf8, 0x00]
    
    def queue_command_ignore_response(self, cmd, args=[]):
        """
        Packs a command into the command queue.  If the command queue is getting too
        long, it flushes the queue out to the Zynq.
        """
        self.cmd_queue.append(self._pack_command(cmd, args))
        
        if len(self.cmd_queue) > 128:
            # Flush the queue.
            self.flush_command_queue()
    
    def flush_command_queue(self):
        """
        Send any pending commands in the queue as one bulk SPI transfer.
        """
        cmd_out = []
        
        for cmd in self.cmd_queue:
            cmd_out += cmd
        
        #print("Queue:", cmd_out)

        # For every command add an additional 2 NOPs to allow the engine to process data (as it is interrupt driven)
        cmd_out += [0x00, 0x00] * len(self.cmd_queue)
        
        if len(cmd_out) > 0:
            self.spi.xfer(cmd_out, self.spi.max_speed_hz, 0, 8)
            self.cmd_queue = []
    
    def send_command_ignore_response(self, cmd, args=[]):
        """
        Send a command via the SPI port but ignore any response.  This should ONLY
        be used for commands that do not generate a response.  If the command 
        generates a response and this is not read, then corruption of future responses
        could happen as the state machine on the Zynq will be in the wrong state.
        """
        self.spi.xfer(self._pack_command(cmd, args), self.spi.max_speed_hz, 0, 8)
    
    def send_command_read_response(self, cmd, args=[], expected_resp_size=None):
        """
        Send a command via SPI and read the response from the Zynq using burst 
        read operations.
        
        If `expected_resp_size` is passed, this hints to the reader as to how many
        bytes to try to read back (excluding sync and size bytes).  If the 
        response isn't ready in time, then the reader will default to the regular
        read size.  This size is adjusted for 1-byte and 2-byte size headers.
        """
        assert(len(args) <= 16)
        assert(expected_resp_size == None or (isinstance(expected_resp_size, int) and expected_resp_size < SPI_LARGE_PACKET_SIZE))
        
        # Prepare command, packed to the length of the longest command with zeroes
        #cmd_pack = [cmd] + list(args)
        #crc = Crc8Maxim.calc(cmd_pack)
        #cmd_pack += [crc, 0x00]
        #cmd_pack += prepare_buf(SPI_LONGEST_COMMAND + 1 - len(cmd_pack))
        #cmd_pack = [0x70, 0xf8, 0x00]
        #print("Cmd:", cmd_pack)
        cmd_pack = self._pack_command(cmd, args)
        
        # Prepare buffers
        resp = bytearray()
        data = bytearray()
        cmd_state = STATE_CMD_OUTPUT
        resp_state = STATE_RESP_WAIT_FOR_SIZE
        size_1 = size_2 = size = 0
        index = 0
        
        if expected_resp_size == None:
            read_first = prepare_buf(SPI_READ_BLOCK_SIZE_INITIAL)
        else:
            if expected_resp_size <= SPI_SMALL_PACKET_SIZE:
                read_first = prepare_buf(6 + expected_resp_size)
            else:
                read_first = prepare_buf(7 + expected_resp_size)
        
        self.start_timeout()
        
        while True:
            if cmd_state == STATE_CMD_OUTPUT:
                #print("SendCmd %r" % cmd_pack)
                resp = self.spi.xfer2(cmd_pack, self.spi.max_speed_hz, 0, 8)
                cmd_state = STATE_CMD_READ_FIRST
                if SPI_RESP_DELAY is not None:
                    time.sleep(SPI_RESP_DELAY)
            elif cmd_state == STATE_CMD_READ_FIRST:
                #print("ReadFirst %r" % read_first)
                resp = self.spi.xfer2(read_first, self.spi.max_speed_hz, 0, 8)
                cmd_state = STATE_CMD_READ
            elif cmd_state == STATE_CMD_READ:
                empty = prepare_buf(SPI_READ_BLOCK_SIZE_INITIAL)
                #print("ReadNext %r" % empty)
                resp = self.spi.xfer2(empty, self.spi.max_speed_hz, 0, 8)
            
            # Scan the response for tag bytes and unpack size and read data
            if resp_state in [STATE_RESP_WAIT_FOR_SIZE, STATE_RESP_READ_SIZE_1, STATE_RESP_READ_SIZE_2]:
                for byt_ in resp:
                    if resp_state == STATE_RESP_WAIT_FOR_SIZE:
                        if byt_ == 0xff:
                            resp_state = STATE_RESP_READ_SIZE_1
                    elif resp_state == STATE_RESP_READ_SIZE_1:
                        # 0xff indicates that we still need to wait, so continue reading until 
                        # we see a size (0xfeff is the maximum size we support)
                        if byt_ != 0xff:
                            size_1 = byt_
                            if size_1 >= 0x80:
                                size = (size_1 - 0x80) << 8
                                resp_state = STATE_RESP_READ_SIZE_2
                            else:
                                size = size_1
                                data = bytearray(size + 1)
                                resp_state = STATE_RESP_READ_DATA
                    elif resp_state == STATE_RESP_READ_SIZE_2:
                        size += byt_
                        data = bytearray(size + 1)
                        #if (size > 300):
                        #    print("Size 0x%02x%02x = %d" % (size_1, byt_, size))
                        #    raise RuntimeError
                        resp_state = STATE_RESP_READ_DATA
                    elif resp_state == STATE_RESP_READ_DATA:
                        #print(index)
                        data[index] = byt_ #bytearray([byt_])
                        #print(index)
                        index = index + 1
                        #if byt_ == 0x00:
                        #    data += '*'
                        #else:
                        #data += bytearray([byt_])
                        #print("READ_DATA1", byt_, size, len(data), data)
                        if index > size:
                            resp_state = STATE_RESP_DONE
                            cmd_state = STATE_CMD_IDLE
            elif resp_state == STATE_RESP_READ_DATA:
                #data += "".join(map(chr, map(lambda x: 35 if (x == 0) else x, resp)))
                #data += b"".join(map(chr, resp))
                print("ZynqSPI Append debug:", resp, len(resp), data)
                data += bytearray(resp)
                #print("READ_DATA2", byt_, size, len(data), data)
                #return None
                if len(data) >= size:
                    resp_state = STATE_RESP_DONE
                #raise Exception
            elif resp_state == STATE_RESP_DONE:
                data = data[:size] # Crop any extra bytes
                break
            
            #print("%r" % data)
            self.exceed_timeout_exception(self.spi_timeout)
        
        #print("Response %r" % (data))
        return data

