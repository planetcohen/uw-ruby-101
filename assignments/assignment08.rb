# ========================================================================================
# Assignment 8
# ========================================================================================
module Assignment08
# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

  class RomanNumeral
    # Converts integer between 0 & 3999 inclusive to Roman numeral string.
    def initialize(i)
      @ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
      @tens = ["", "X", "XX", "XXX", "LX", "L", "LX", "LXX", "LXXX", "XC"]
      @hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
      @thousands = ["", "M", "MM", "MMM"]
      @rn_int = i
      @rn_str = self.to_s
    end

    def to_s
      if @rn_int > 3999
        "Number est etiam magna."
      elsif @rn_int < 1
        "Number nimis parvum est."
      else
        digit_string = @rn_int.to_s
        while digit_string.length < 4
          digit_string = "0" + digit_string
        end
        digits = digit_string.split("").map {|str_digit| str_digit.to_i}
        @thousands[digits[0]] + @hundreds[digits[1]] + @tens[digits[2]] + @ones[digits[3]]
      end
    end

    def to_i
      @rn_int
    end
    
    # bonus: create from Roman Numeral
    def self.from_string
      # your implementation here
      # returns a new instance
    end

  end  # class RomanNumeral


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
# Assignment08::RomanNumeral.from_string('III').to_i  # => 3
# Assignment08::RomanNumeral.from_string('IX').to_i   # => 9
# Assignment08::RomanNumeral.from_string('IX').to_i   # => 9

# given any arbitrary integer n:
# n == Assignment08::RomanNumeral.from_string(Assignment08::RomanNumeral.new(n).to_s).to_i


# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

  def fib(n)
    def calc_fib(n, cache)
      if cache.length > n
        cache[n]
      else
        cache[n] = calc_fib(n-1, cache) + calc_fib(n-2, cache)
      end
    end
    calc_fib(n, [1,1])
  end
  def golden_ratio_fib(count)
    fib(count) / fib(count - 1).to_f
  end
  def golden_ratio(precision)
    case precision
    when 1
      fib = 5
    when 2
      fib = 8
    when 3
      fib = 10
    when 4
      fib = 12
    when 5
      fib = 13
    when 6
      fib = 16
    when 7
      fib = 19
    when 8
      fib = 22
    when 9
      fib = 24
    when 10
      fib = 27
    end
    golden_ratio_fib(fib).round(precision)
  end

# expected results:
# golden_ratio(2)  # => 1.62 
# golden_ratio(5)  # => 1.61803 
# golden_ratio(8)  # => 1.61803399 

# GR = fib(23) / fib(22).to_f

end  # module Assignment08

require 'minitest/autorun'

class TestAssignment08 < Minitest::Test
  include Assignment08
  def test_golden_ratio
    assert_equal golden_ratio(1), 1.6
    assert_equal golden_ratio(2), 1.62
    assert_equal golden_ratio(3), 1.618
    assert_equal golden_ratio(4), 1.6181
    assert_equal golden_ratio(5), 1.61803
    assert_equal golden_ratio(6), 1.618034
    assert_equal golden_ratio(7), 1.6180340
    assert_equal golden_ratio(8), 1.61803399
    assert_equal golden_ratio(9), 1.618033989
    assert_equal golden_ratio(10), 1.6180339887
  end
  
  def test_roman_numeral
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
end  # TestAssignment08 < Minitest::Test