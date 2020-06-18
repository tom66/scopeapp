"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

class ZynqScopeADCMapping(object):
    def __init__(self): 
        pass

    def set_mapping(self, zero_adc, full_adc, adc_range):
        """Tells the controller the details of the ADC gain: the lower and upper ADC thresholds represented
        in the ADC outputs.

        zero_adc should be the voltage at an ADC code of 0x00;
        full_adc should be the voltage at an ADC full code;
        adc_range is the range of the ADC codes (typically 255)."""
        assert (full_adc < zero_adc)

        self.zero_adc = zero_adc
        self.full_adc = full_adc
        self.adc_range = adc_range

    def apply_map(self, code):
        return self.zero_adc + ((code / self.adc_range) * self.full_adc)

    def __repr__(self):
        return "<ADCMapping Z=%.2f F=%.2f R=%d>" % (self.zero_adc, self.full_adc, self.adc_range)