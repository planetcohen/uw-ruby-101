# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral

    GLYPHS = {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }

    def initialize(i)
      @integer = i.to_i
    end

    def to_s
      result = ""
      num = @integer
      GLYPHS.keys.each do |div|
        quo, mod = num.divmod(div)
        result << GLYPHS[div] * quo
        num = mod
      end
      result
    end

    def to_i
      @integer
    end

  end
end

require 'minitest/autorun'

class TestPropReader < Minitest::Test

  include Assignment08

  def test_numerals
    assert_equal 'I', RomanNumeral.new(1).to_s
    assert_equal 'II', RomanNumeral.new(2).to_s
    assert_equal 'III', RomanNumeral.new(3).to_s
    assert_equal 'IV', RomanNumeral.new(4).to_s
    assert_equal 'V', RomanNumeral.new(5).to_s
    assert_equal 'VI', RomanNumeral.new(6).to_s
    assert_equal 'IX', RomanNumeral.new(9).to_s
    assert_equal 'X', RomanNumeral.new(10).to_s
    assert_equal 'XIX', RomanNumeral.new(19).to_s
    assert_equal 'XXXII', RomanNumeral.new(32).to_s
    assert_equal 'LI', RomanNumeral.new(51).to_s
  end

end


# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

module Assignment08

  def golden_ratio(precision)
    ratio = fib(21).to_f / fib(20).to_f
    ratio.round(precision)
  end

  def fib(n)
    if (0..1).include? n
      1
    elsif n > 1
      fib(n-1) + fib(n-2)
    end
  end

end

require 'minitest/autorun'

class TestPropReader < Minitest::Test

  include Assignment08

  def test_golden_ratio
    assert_equal 1.62, golden_ratio(2)
    assert_equal 1.61803, golden_ratio(5)
    assert_equal 1.61803399, golden_ratio(8)
  end

end
