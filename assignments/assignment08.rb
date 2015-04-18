# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests
require 'minitest/autorun'

module Assignment08
  @@arabic_to_roman = {
      1 => "I",
	  4 => "IV",
	  5 => "V",
	  9 => "IX",
	  10 => "X",
	  40 => "XL",
	  50 => "L",
	  90 => "XC",
	  100 => "C",
	  400 => "CD",
	  500 => "D",
	  900 => "CM",
	  1000 => "M" 
    }
  class RomanNumeral
    def initialize(i)
      # your implementation here
      @i = i
    end

    def to_s
      # your implementation here
      roman = ""
      @i = self
      @@arabic_to_roman.keys.each do |integer, letter|
        roman << letter*(@i/integer)
        @i = @i%integer
      end
      roman
    end

    def to_i
      # your implementation here
      @i
    end
    
    # bonus: create from Roman Numeral
    def self.from_string
      # your implementation here
      # returns a new instance
    end
  end
end

# expected results:
RomanNumeral.new(1).to_s   # => 'I'
RomanNumeral.new(2).to_s   # => 'II'
RomanNumeral.new(3).to_s   # => 'III'
RomanNumeral.new(4).to_s   # => 'IV'
RomanNumeral.new(5).to_s   # => 'V'
RomanNumeral.new(6).to_s   # => 'VI'
RomanNumeral.new(9).to_s   # => 'IX'
RomanNumeral.new(10).to_s  # => 'X'
RomanNumeral.new(19).to_s  # => 'XIX'
RomanNumeral.new(32).to_s  # => 'XXXII'
RomanNumeral.new(51).to_s  # => 'LI'

# bonus:
RomanNumeral.from_string('III').to_i  # => 3
RomanNumeral.from_string('IX').to_i   # => 9
RomanNumeral.from_string('IX').to_i   # => 9

# given any arbitrary integer n:
n == RomanNumeral.from_string(RomanNumeral.new(n).to_s).to_i


class TestRomanNumeral < Minitest::Test
	include Assignment08
	def test_roman_numerals
	  assert_equal RomanNumeral.new(1).to_s, 'I'
	  assert_equal RomanNumeral.new(2).to_s, 'II'
	  assert_equal RomanNumeral.new(3).to_s, 'III'
	  assert_equal RomanNumeral.new(4).to_s, 'IV'
	  assert_equal RomanNumeral.new(5).to_s, 'V'
	  assert_equal RomanNumeral.new(6).to_s, 'VI'
	  assert_equal RomanNumeral.new(9).to_s, 'IX'
	  assert_equal RomanNumeral.new(10).to_s, 'X'
	  assert_equal RomanNumeral.new(19).to_s, 'XIX'
	  assert_equal RomanNumeral.new(32).to_s, 'XXXII'
	  assert_equal RomanNumeral.new(51).to_s, 'LI'
	end
end



# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests
require 'minitest/autorun'


module Assignment08
  def golden_ratio(precision)
    # your implementation here
    i = 1.0
    precision.times {i = 1+1/i}
    return i
  end
end

# expected results:
golden_ratio(2)  # => 1.62
golden_ratio(5)  # => 1.61803
golden_ratio(8)  # => 1.61803399


class TestGoldenRatio < Minitest::Test
  include Assignment08
  def test_golden_ratio
# expected results:
     assert_equal golden_ratio(2), 1.62
     assert_equal golden_ratio(5), 1.61803
     assert_equal golden_ratio(8), 1.61803399
  end
end
