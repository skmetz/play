module Roman
  refine Fixnum do
    def to_roman
      RomanNumerals.instance.to_roman(self)
    end
  end
end

require 'singleton'
class RomanNumerals
  include Singleton

  ROMAN_NUMERALS = {
    1000 => 'M',
     500 => 'D',
     100 => 'C',
      50 => 'L',
      10 => 'X',
       5 => 'V',
       1 => 'I'  }

  SUBTRACTIVE_ROMAN = {
    'DCCCC' => 'CM',  # 900
    'CCCC'  => 'CD',  # 400
    'LXXXX' => 'XC',  # 90
    'XXXX'  => 'XL',  # 40
    'VIIII' => 'IX',  # 9
    'IIII'  => 'IV' } # 4

  def to_roman(number)
    to_subtractive_roman(to_additive_roman(number))
  end

  def to_additive_roman(number)
    result = ''
    ROMAN_NUMERALS.keys.reduce(number) {|to_be_converted, base_10_value|
      num_chars_needed, remainder = to_be_converted.divmod(base_10_value)
      result << ROMAN_NUMERALS[base_10_value] * num_chars_needed
      remainder
    }
    result
  end

  def to_subtractive_roman(full_roman)
    SUBTRACTIVE_ROMAN.keys.reduce(full_roman) {|roman, long_form|
      roman.gsub(/#{long_form}/, SUBTRACTIVE_ROMAN[long_form])
    }
  end
end

# My first stab at this.  roman_numerals_long is an attempt to give this code
# better names.
