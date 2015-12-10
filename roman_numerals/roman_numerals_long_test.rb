#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'roman_numerals_long'
using Roman

class RomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', 1.to_roman
  end

  def test_2
    assert_equal 'II', 2.to_roman
  end

  def test_3
    assert_equal 'III', 3.to_roman
  end

  def test_4
    assert_equal 'IV', 4.to_roman
  end

  def test_5
    assert_equal 'V', 5.to_roman
  end

  def test_6
    assert_equal 'VI', 6.to_roman
  end

  def test_9
    assert_equal 'IX', 9.to_roman
  end

  def test_27
    assert_equal 'XXVII', 27.to_roman
  end

  def test_48
    assert_equal 'XLVIII', 48.to_roman
  end

  def test_59
    assert_equal 'LIX', 59.to_roman
  end

  def test_93
    assert_equal 'XCIII', 93.to_roman
  end

  def test_141
    assert_equal 'CXLI', 141.to_roman
  end

  def test_163
    assert_equal 'CLXIII', 163.to_roman
  end

  def test_402
    assert_equal 'CDII', 402.to_roman
  end

  def test_575
    assert_equal 'DLXXV', 575.to_roman
  end

  def test_911
    assert_equal 'CMXI', 911.to_roman
  end

  def test_1024
    assert_equal 'MXXIV', 1024.to_roman
  end

  def test_3000
    assert_equal 'MMM', 3000.to_roman
  end
end

class AdditiveRomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', RomanNumerals.instance.to_additive_roman(1)
  end

  def test_2
    assert_equal 'II', RomanNumerals.instance.to_additive_roman(2)
  end

  def test_3
    assert_equal 'III', RomanNumerals.instance.to_additive_roman(3)
  end

  def test_4
    assert_equal 'IIII', RomanNumerals.instance.to_additive_roman(4)
  end

  def test_5
    assert_equal 'V', RomanNumerals.instance.to_additive_roman(5)
  end

  def test_6
    assert_equal 'VI', RomanNumerals.instance.to_additive_roman(6)
  end

  def test_9
    assert_equal 'VIIII', RomanNumerals.instance.to_additive_roman(9)
  end

  def test_48
    assert_equal 'XXXXVIII', RomanNumerals.instance.to_additive_roman(48)
  end

  def test_99
    assert_equal 'LXXXXVIIII', RomanNumerals.instance.to_additive_roman(99)
  end

  def test_299
    assert_equal 'CCLXXXXVIIII', RomanNumerals.instance.to_additive_roman(299)
  end

  def test_300
    assert_equal 'CCC', RomanNumerals.instance.to_additive_roman(300)
  end

  def test_3000
    assert_equal 'MMM', RomanNumerals.instance.to_additive_roman(3000)
  end

end


class SubtractiveRomanNumeralsTest < Minitest::Test
  def test_4
    assert_equal 'IV', RomanNumerals.instance.to_subtractive_roman('IIII')
  end

  def test_9
    assert_equal 'IX', RomanNumerals.instance.to_subtractive_roman('VIIII')
  end

  def test_49
    assert_equal 'XLIX', RomanNumerals.instance.to_subtractive_roman('XXXXVIIII')
  end

  def test_99
    assert_equal 'XCIX', RomanNumerals.instance.to_subtractive_roman('LXXXXVIIII')
  end

  def test_449
    assert_equal 'CDXLIX', RomanNumerals.instance.to_subtractive_roman('CCCCXXXXVIIII')
  end

  def test_999
    assert_equal 'XCIX', RomanNumerals.instance.to_subtractive_roman('LXXXXVIIII')
  end
end
