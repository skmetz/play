#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'roman_numerals_medium'
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
    assert_equal 'I', RomanNumerals.new(1).to_additive
  end

  def test_2
    assert_equal 'II', RomanNumerals.new(2).to_additive
  end

  def test_3
    assert_equal 'III', RomanNumerals.new(3).to_additive
  end

  def test_4
    assert_equal 'IIII', RomanNumerals.new(4).to_additive
  end

  def test_5
    assert_equal 'V', RomanNumerals.new(5).to_additive
  end

  def test_6
    assert_equal 'VI', RomanNumerals.new(6).to_additive
  end

  def test_9
    assert_equal 'VIIII', RomanNumerals.new(9).to_additive
  end

  def test_48
    assert_equal 'XXXXVIII', RomanNumerals.new(48).to_additive
  end

  def test_99
    assert_equal 'LXXXXVIIII', RomanNumerals.new(99).to_additive
  end

  def test_299
    assert_equal 'CCLXXXXVIIII', RomanNumerals.new(299).to_additive
  end

  def test_300
    assert_equal 'CCC', RomanNumerals.new(300).to_additive
  end

  def test_3000
    assert_equal 'MMM', RomanNumerals.new(3000).to_additive
  end

end


class SubtractiveRomanNumeralsTest < Minitest::Test
  def test_4
    assert_equal 'IV', SubtractiveRomanNumerals.new('IIII').to_s
  end

  def test_9
    assert_equal 'IX', SubtractiveRomanNumerals.new('VIIII').to_s
  end

  def test_49
    assert_equal 'XLIX', SubtractiveRomanNumerals.new('XXXXVIIII').to_s
  end

  def test_99
    assert_equal 'XCIX', SubtractiveRomanNumerals.new('LXXXXVIIII').to_s
  end

  def test_449
    assert_equal 'CDXLIX', SubtractiveRomanNumerals.new('CCCCXXXXVIIII').to_s
  end

  def test_999
    assert_equal 'XCIX', SubtractiveRomanNumerals.new('LXXXXVIIII').to_s
  end
end
