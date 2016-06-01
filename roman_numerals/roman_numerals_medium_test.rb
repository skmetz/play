#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'roman_numerals_medium'

using Roman

class RomanNumeralsTest < Minitest::Test
  def test_1
    assert_equal 'I', 1.to_roman
    assert_equal 1, 'I'.to_i(type: :roman)
  end

  def test_2
    assert_equal 'II', 2.to_roman
    assert_equal  2, 'II'.to_i(type: :roman)
  end

  def test_3
    assert_equal 'III', 3.to_roman
    assert_equal 3, 'III'.to_i(type: :roman)
  end

  def test_4
    assert_equal 'IV', 4.to_roman
    assert_equal 4, 'IV'.to_i(type: :roman)
  end

  def test_5
    assert_equal 'V', 5.to_roman
    assert_equal 5, 'V'.to_i(type: :roman)
  end

  def test_6
    assert_equal 'VI', 6.to_roman
    assert_equal 6, 'VI'.to_i(type: :roman)
  end

  def test_9
    assert_equal 'IX', 9.to_roman
    assert_equal 9, 'IX'.to_i(type: :roman)
  end

  def test_27
    assert_equal 'XXVII', 27.to_roman
    assert_equal 27, 'XXVII'.to_i(type: :roman)
  end

  def test_48
    assert_equal 'XLVIII', 48.to_roman
    assert_equal 48, 'XLVIII'.to_i(type: :roman)
  end

  def test_59
    assert_equal 'LIX', 59.to_roman
    assert_equal 59, 'LIX'.to_i(type: :roman)
  end

  def test_93
    assert_equal 'XCIII', 93.to_roman
    assert_equal 93, 'XCIII'.to_i(type: :roman)
  end

  def test_141
    assert_equal 'CXLI', 141.to_roman
    assert_equal 141, 'CXLI'.to_i(type: :roman)
  end

  def test_163
    assert_equal 'CLXIII', 163.to_roman
    assert_equal 163, 'CLXIII'.to_i(type: :roman)
  end

  def test_402
    assert_equal 'CDII', 402.to_roman
    assert_equal 402, 'CDII'.to_i(type: :roman)
  end

  def test_575
    assert_equal 'DLXXV', 575.to_roman
    assert_equal 575, 'DLXXV'.to_i(type: :roman)
  end

  def test_911
    assert_equal 'CMXI', 911.to_roman
    assert_equal 911, 'CMXI'.to_i(type: :roman)
  end

  def test_1024
    assert_equal 'MXXIV', 1024.to_roman
    assert_equal 1024, 'MXXIV'.to_i(type: :roman)
  end

  def test_3000
    assert_equal 'MMM', 3000.to_roman
    assert_equal 3000, 'MMM'.to_i(type: :roman)
  end
end


class RomanNumeralConversionTest < Minitest::Test
    def test_2
      assert_equal 'II', RomanNumeralConversion.new('II').to_subtractive
      assert_equal 'II', RomanNumeralConversion.new('II').to_additive
    end

  def test_4
    assert_equal 'IV',   RomanNumeralConversion.new('IIII').to_subtractive
    assert_equal 'IIII', RomanNumeralConversion.new('IV').to_additive
  end

  def test_9
    assert_equal 'IX',    RomanNumeralConversion.new('VIIII').to_subtractive
    assert_equal 'VIIII', RomanNumeralConversion.new('IX').to_additive
  end

  def test_49
    assert_equal 'XLIX',      RomanNumeralConversion.new('XXXXVIIII').to_subtractive
    assert_equal 'XXXXVIIII', RomanNumeralConversion.new('XLIX').to_additive
  end

  def test_99
    assert_equal 'XCIX',        RomanNumeralConversion.new('LXXXXVIIII').to_subtractive
    assert_equal 'LXXXXVIIII',  RomanNumeralConversion.new('XCIX').to_additive
  end

  def test_449
    assert_equal 'CDXLIX',        RomanNumeralConversion.new('CCCCXXXXVIIII').to_subtractive
    assert_equal 'CCCCXXXXVIIII', RomanNumeralConversion.new('CDXLIX').to_additive
  end

  def test_999
    assert_equal 'XCIX',        RomanNumeralConversion.new('LXXXXVIIII').to_subtractive
    assert_equal 'LXXXXVIIII',  RomanNumeralConversion.new('XCIX').to_additive
  end
end
