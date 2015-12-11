module Roman
  refine Fixnum do
    def to_roman
      RomanNumerals.new(self).to_s
    end
  end
end

class RomanNumerals
  ROMAN_NUMERALS = {
    1000 => 'M',
     500 => 'D',
     100 => 'C',
      50 => 'L',
      10 => 'X',
       5 => 'V',
       1 => 'I'  }

  attr_reader :number, :additive, :subtractive

  def initialize(number)
    @number       = number
    @additive     = to_additive
    @subtractive  = SubtractiveRomanNumerals.new(additive).to_s
  end

  def to_s
    subtractive
  end

  def to_additive
    result = ''
    ROMAN_NUMERALS.keys.reduce(number) {|to_be_converted, base_10_value|
      num_chars_needed, remainder = to_be_converted.divmod(base_10_value)
      result << ROMAN_NUMERALS[base_10_value] * num_chars_needed
      remainder
    }
    result
  end
end

class SubtractiveRomanNumerals
  SUBTRACTIVE_ROMAN = {
    'DCCCC' => 'CM',  # 900
    'CCCC'  => 'CD',  # 400
    'LXXXX' => 'XC',  # 90
    'XXXX'  => 'XL',  # 40
    'VIIII' => 'IX',  # 9
    'IIII'  => 'IV' } # 4

  attr_reader :roman

  def initialize(roman)
    @roman = roman
  end

  def to_s
    SUBTRACTIVE_ROMAN.keys.reduce(roman) {|converted_roman, long_form|
      converted_roman.gsub(/#{long_form}/, SUBTRACTIVE_ROMAN[long_form])
    }
  end
end
