# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral
    attr  :value, :arabic_digits
    def initialize(i)
      @value = i
      @arabic_digits = []
      [0,1,2].each {|n| @arabic_digits[n] = @value.to_s[(n+1) *-1].to_i}
    end

    def to_s
      roman_chars = []
      roman_chars << %w{I IV V IX}
      roman_chars << %w{X XL L XC}
      roman_chars << %w{C CD D CM}
      r_numeral = ""
      r_digit = ""
      @arabic_digits.each_with_index do |arabic_digit, i|
        if arabic_digit <= 3 then
          r_digit = roman_chars[i][0] * arabic_digit
        elsif arabic_digit == 4 then
          r_digit = roman_chars[i][1]
        elsif arabic_digit <= 8 then
          r_digit = roman_chars[i][2] + roman_chars[i][0] * (arabic_digit - 5)
        else r_digit = roman_chars[i][3]
        end
        r_numeral.insert(0, r_digit)
      end
      r_numeral
    end

    def to_i
    end
    
    # bonus: create from Roman Numeral
    def self.from_string
      # your implementation here
      # returns a new instance
    end
  end
end

require Assignment08

require 'minitest/autorun'

class RomanNumeralTest < MiniTest::Test
  def test_one
    assert_equal 'I', RomanNumeral.new(1).to_s
    assert_equal 'II', RomanNumeral.new(2).to_s
    assert_equal 'III', RomanNumeral.new(3).to_s
    assert_equal 'IV', RomanNumeral.new(4).to_s
    assert_equal 'V', RomanNumeral.new(5).to_s
    assert_equal 'VI', RomanNumeral.new(6).to_s
    assert_equal 'VII', RomanNumeral.new(7).to_s
    assert_equal 'IV', RomanNumeral.new(9).to_s
    assert_equal 'X', RomanNumeral.new(10).to_s
    assert_equal 'XIX', RomanNumeral.new(19).to_s
    assert_equal 'XXXII', RomanNumeral.new(32).to_s
    assert_equal 'LI', RomanNumeral.new(51).to_s
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



# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

module Assignment08
  def golden_ratio(precision)
    # your implementation here
  end
end

# expected results:
golden_ratio(2)  # => 1.62
golden_ratio(5)  # => 1.61803
golden_ratio(8)  # => 1.61803399
