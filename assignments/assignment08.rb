# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests


require 'minitest/autorun'
require 'active_support/all'


module Assignment08
  class RomanNumeral
    def i_to_r
      {
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
    end
    
    def initialize(i)
      # your implementation here
      @number = i
    end

    def to_s
      # your implementation here
      s = ""
      i_to_r.keys.each do |r|
        times = @number / r
        remainder = @number % r
        s << i_to_r[r] * times
        @number = remainder
      end 
      s
    end
  end
end

# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

module Assignment08

  def golden_ratio(precision)
    # your implementation here
    gr = 12586269025.0/7778742049.0
    gr.round(precision)
  end
end



class TestMyClass < Minitest::Test
  include Assignment08

  def test_roman_numeral

   assert_equal 'I', RomanNumeral.new(1).to_s   # => 'I'
   assert_equal 'II', RomanNumeral.new(2).to_s   # => 'II'
   assert_equal 'III', RomanNumeral.new(3).to_s   # => 'III'
   assert_equal 'IV', RomanNumeral.new(4).to_s   # => 'IV'
   assert_equal 'V', RomanNumeral.new(5).to_s   # => 'V'
   assert_equal 'VI', RomanNumeral.new(6).to_s   # => 'VI'
   assert_equal 'IX', RomanNumeral.new(9).to_s   # => 'IX'
   assert_equal 'X', RomanNumeral.new(10).to_s  # => 'X'
   assert_equal 'XIX', RomanNumeral.new(19).to_s  # => 'XIX'
   assert_equal 'XXXII', RomanNumeral.new(32).to_s  # => 'XXXII'
   assert_equal 'LI', RomanNumeral.new(51).to_s  # => 'LI'

  end

  def test_golden_ratio
    
    assert_equal 1.62, golden_ratio(2)  # => 1.62
    assert_equal 1.61803, golden_ratio(5)  # => 1.61803
    assert_equal 1.61803399, golden_ratio(8)  # => 1.61803399

  end

end

