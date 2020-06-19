"""
This file is part of YAOS and is licenced under the MIT Licence.
"""

sys.path.append('..')
import Utils # from parent directory

class ZynqScopeADCMapping(object):
    def __init__(self): 
        pass

    def set_mapping(self, zero_adc, full_adc, adc_range):
        """Tells the controller the details of the ADC gain: the lower and upper ADC 
        thresholds represented in the ADC outputs.

        zero_adc should be the voltage at an ADC code of 0x00;
        full_adc should be the voltage at an ADC full code;
        adc_range is the range of the ADC codes (typically 255)."""
        assert (full_adc < zero_adc)

        self.zero_adc = zero_adc
        self.full_adc = full_adc
        self.adc_range = adc_range

    def apply_map_adc(self, code):
        """Compute voltage from an ADC code 0x00 ~ adc_range.  Codes out of range 
        raise a ValueError."""
        if code > self.adc_range:
            raise ValueError("ADC code 0x%02x out of range [0x00 ~ 0x%02x]" % (code, self.adc_range)) 

        return self.zero_adc + ((code / self.adc_range) * self.full_adc)

    def apply_map_volt(self, volt):
        """Compute ADC code from a voltage zero_adc ~ full_adc.  Voltages out of 
        range are clipped."""
        volt = Utils.clamp(volt, self.zero_adc, self.full_adc)
        return int(((volt - self.zero_adc) / (self.full_adc - self.zero_adc)) * self.adc_range)

    def apply_map_volt_rel(self, volt):
        """Compute ADC code from a relative voltage 0 ~ (full_adc - zero_adc).  
        Voltages out of range are clipped."""
        volt = Utils.clamp(volt, 0, self.full_adc - self.zero_adc)
        return int((volt / (self.full_adc - self.zero_adc)) * self.adc_range)

    def __repr__(self):
        return "<ADCMapping Z=%.2f F=%.2f R=%d>" % (self.zero_adc, self.full_adc, self.adc_range)