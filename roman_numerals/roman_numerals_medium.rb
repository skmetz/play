module Roman
  refine Fixnum do
    def to_roman
      RomanNumerals.new.to_s(self)
    end
  end

  refine String do
    def to_subtractive_roman
      RomanNumeralConversion.new(self).to_subtractive
    end

    def to_additive_roman
      RomanNumeralConversion.new(self).to_additive
    end

    alias_method :to_i_orig, :to_i
    def to_i(type=nil)
      type == :roman ? RomanNumerals.new.to_i(self) : self.to_i_orig
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

  def to_s(num)
    to_roman(num)
  end

  def to_i(str)
    to_number(str)
  end

  def to_roman(number)
    result = ''
    ROMAN_NUMERALS.keys.reduce(number) {|to_be_converted, base_10_value|
      num_chars_needed, remainder = to_be_converted.divmod(base_10_value)
      result << ROMAN_NUMERALS[base_10_value] * num_chars_needed
      remainder
    }
    result.to_subtractive_roman
  end

  def to_number(roman)
    roman.to_additive_roman.chars.reduce(0) {|total, roman_letter|
      total += ROMAN_NUMERALS.invert[roman_letter]
    }
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

# My third try.  This is internally consistent, and this form makes it
# easy to convert number-roman and roman-number. The class names still annoy
# me, but names are hard. :-)
#
# I wonder about the wisdom of aliasing to_i in the String refinement, but
# at least the way I don't break the regular string.to_i.  However, The
# whole to_i(:roman) thing might be a mistake.  I couldn't stand to name the
# string refinemnt to_i_from_roman, or roman_to_i. Names, yes, are hard.
#
# All in all, I like this implementation the best.  Its symmetry pleases me.
