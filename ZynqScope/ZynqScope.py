"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

import sys 
sys.path.append('..')
import Utils # from parent directory

# For now, we import the standard 4ch AFE as the only supported AFE
import Standard4chAFE as AFE

# Supported timebases
timebase_options = [1e-9, 2e-9, 5e-9, 10e-9, 20e-9, 50e-9, 100e-9, 200e-9, 500e-9, 
                    1e-6, 2e-6, 5e-6, 10e-6, 20e-6, 50e-6, 100e-6, 200e-6, 500e-6, 
                    1e-3, 2e-3, 5e-3, 10e-3, 20e-3, 50e-3, 100e-3, 200e-3, 500e-3, 
                    1,    2,    5,    10,    20,    50,    100]

class ZynqScopeTimebaseOption(object):
    timebase_div = 0
    timebase_span = 0
    timebase_span_actual = 0
    memory_auto = 0
    memory_max = 0
    sample_rate_auto = None
    sample_rate_max = None
    interp = 0
    
    def __init__(self):
        pass
    
    def __repr__(self):
        return "<ZynqScopeTimebaseOption div=%s span=%s actual_span=%s memory_auto=%s memory_max=%s " \
               "sample_rate_auto=%s interp=%d>" % \
            (Utils.unit_format_suffix(self.timebase_div, 's'), Utils.unit_format_suffix(self.timebase_span, 's'), \
             Utils.unit_format_suffix(self.timebase_span_actual, 's'), \
             Utils.unit_format_suffix(self.memory_auto, 's'), Utils.unit_format_suffix(self.memory_max, 's'), \
             Utils.unit_format_suffix(self.sample_rate_auto, 's'), Utils.unit_format_suffix(self.sample_rate_max, 's'), 
             self.interp)
        
class ZynqScopeSampleRateBehaviourModel(object): 
    """Encapsulating class for divider/PLL behaviour model.  The rates,
    dividers and frequency lists must be in descending order of resulting
    output frequency."""
    rates = []  
    adc_divider = []
    pll_frequency = []
    
    def update(self):
        self.rates = []
        length = len(self.adc_divider)
        for idx in range(length):
            self.rates.append(self.calculate_clock_for_index(idx))
    
    def calculate_clock_for_index(self, index):
        """Returns clock in MHz"""
        divider = self.adc_divider[index]
        freq = self.pll_frequency[index] * 1e6
        return freq / divider

class ZynqScopeSampleRateBehaviourModel_8Bit(ZynqScopeSampleRateBehaviourModel): 
    adc_divider   = [1,    1,   1,   2,   4,   8,   8,   8]
    pll_frequency = [1000, 500, 250, 250, 250, 250, 125, 62.5] # in MHz
                    
class ZynqScope(object):
    """
    The base ZynqScope object which handles the command and control interface
    with the Zynq SoC on the Scopy board.  This class also stores limits and 
    acquisition parameters, such as timebase settings.
    """
    # A list of ZynqTimebaseOption entries filled from timebase_options
    timebase_settings = []
                    
    # Memory depth range.  In future, we would retrieve the amount of DDR3 connected to the Zynq
    # to automatically infer these parameters.  In addition precision mode must also be considered,
    # when it is implemented.
    mem_depth_minimum = 128                 # 128 samples
    mem_depth_maximum = 209715200           # 200MB
    mem_depth_maximum_split = 100663296     # 96MB in split mode
    
    # Target display samples.  This is filled from the GL frontend.
    # Our acquisition must always target this in the fastest mode to get the best performance.
    display_samples_target = 2048
    
    # Number of horizontal divisions.  Affects the length of any given acquisition at a timebase.
    default_hdiv_span = 12
    
    # Sample rate model.  Defines the dividers and clock rates available to the ADC and PLL.
    samprate_mdl = None
    
    def __init__(self, display_samples_target, default_hdiv_span):
        self.display_samples_target = display_samples_target
        self.default_hdiv_span = default_hdiv_span
        self.samprate_mdl = ZynqScopeSampleRateBehaviourModel_8Bit()
        self.samprate_mdl.update()
        self.init_timebases()
    
    def calc_real_sample_rate_for_index(self, index):
        """Only supports 8-bit mode for now"""
        return (1e6 * self.sample_rates_8b_pll_freq[index]) / self.sample_rates_8b_adc_div[index]
    
    def init_timebases(self):
        self.timebase_settings = []
        
        for tb in timebase_options:
            new_tb = ZynqScopeTimebaseOption()
            new_tb.timebase_div = tb
            new_tb.timebase_span = self.default_hdiv_span * tb
            new_tb.timebase_span_actual = new_tb.timebase_span
            new_tb.interp = 1
            
            # Assume medium acquistion: sample at the fastest possible rate, memory depth equals 
            # acquisition length in this mode
            new_tb.memory_auto = self.samprate_mdl.rates[0] * new_tb.timebase_span
            
            # Short acquisition: we capture a larger span and display only a reduced portion of it
            if new_tb.memory_auto < self.mem_depth_minimum:
                new_tb.memory_auto = self.mem_depth_minimum
                new_tb.timebase_span_actual = new_tb.memory_auto * (1.0 / self.samprate_mdl.rates[0])
                new_tb.interp = self.display_samples_target / (new_tb.timebase_span_actual * self.samprate_mdl.rates[0])
            else:
                # Long acquisition: if the number of acquired samples would exceed the maximum memory length
                # in non-split mode, we must reduce the actual sample rate to fit this in DDR3!
                if new_tb.memory_auto >= self.mem_depth_maximum:
                    # Find the best sample rate that does not exceed the maximum memory depth (start 
                    # from the highest sample rate and work down)
                    for rate in self.samprate_mdl.rates:
                        mem_depth = new_tb.memory_auto * (1.0 / rate)
                        if mem_depth < self.mem_depth_maximum:
                            new_tb.memory_auto = mem_depth
                            break
                    
                    new_tb.memory_max = new_tb.memory_auto
            
            print(tb)
            print(new_tb)
            self.timebase_settings.append(new_tb)
