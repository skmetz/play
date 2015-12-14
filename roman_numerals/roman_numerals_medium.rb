module Roman
  refine Fixnum do
    def to_roman
      RomanNumerals.new(self).to_s
    end
  end

  refine String do
    def to_subtractive_roman
      RomanNumeralConversion.new(self).to_subtractive
    end

    def to_additive_roman
      RomanNumeralConversion.new(self).to_additive
    end
  end
end

using Roman

class RomanNumerals
  ROMAN_NUMERALS = {
    1000 => 'M',
     500 => 'D',
     100 => 'C',
      50 => 'L',
      10 => 'X',
       5 => 'V',
       1 => 'I'  }

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    convert.to_subtractive_roman
  end

  def convert
    result = ''
    ROMAN_NUMERALS.keys.reduce(number) {|to_be_converted, base_10_value|
      num_chars_needed, remainder = to_be_converted.divmod(base_10_value)
      result << ROMAN_NUMERALS[base_10_value] * num_chars_needed
      remainder
    }
    result
  end
end

class RomanNumeralConversion

  LONG_TO_SHORT_MAP = {
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

  def to_additive
    convert(LONG_TO_SHORT_MAP.invert)
  end

  def to_subtractive
    convert(LONG_TO_SHORT_MAP)
  end

  def convert(map)
    map.keys.reduce(roman) {|converted_roman, alternate_form|
      converted_roman.gsub(/#{alternate_form}/, map[alternate_form])
    }
  end
end
