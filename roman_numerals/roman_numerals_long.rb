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
    base_10_candidates.reduce(number) {|to_be_converted, base_10_value|
      result << roman_chars(
                  roman_char(base_10_value),
                  number_of_roman_chars_needed(to_be_converted, base_10_value))

      still_to_be_converted(to_be_converted, base_10_value)
    }
    result
  end

  def to_subtractive_roman(full_roman)
    subtractive_roman_candidates.reduce(full_roman) {|roman, long_form|
      replace_additive_with_subtractive(roman, long_form)
    }
  end

  private

  def roman_chars(roman_char, number_needed)
    roman_char * number_needed
  end

  def number_of_roman_chars_needed(number, base_10_value_of_char)
    number / base_10_value_of_char
  end

  def still_to_be_converted(number, base_10_value_just_processed)
    number % base_10_value_just_processed
  end

  def replace_additive_with_subtractive(target, long_form)
    target.gsub(/#{long_form}/, short_form(long_form))
  end

  def base_10_candidates
    ROMAN_NUMERALS.keys
  end

  def roman_char(number)
    ROMAN_NUMERALS[number]
  end

  def subtractive_roman_candidates
    SUBTRACTIVE_ROMAN.keys
  end

  def short_form(long_form)
    SUBTRACTIVE_ROMAN[long_form]
  end

end
