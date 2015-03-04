# ========================================================================================
# Assignment 8
# ========================================================================================

require 'minitest/autorun'
require 'bigdecimal'

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral
    LETTER_VALUES = {
      I: 1,
      V: 5,
      X: 10,
      L: 50,
      C: 100,
      D: 500,
      M: 1000
    }

    def initialize(i)
      raise ArgumentError, 'Number must be positive and less than 4000.' unless i > 0 and i < 4000
      @value = i
    end

    def to_s
      letters = []

      i = @value
      while i >= 1000
        letters << 'M'
        i -= 1000
      end
      if i >= 900
        letters << 'C'
        letters << 'M'
        i -= 900
      end
      if i >= 500
        letters << 'D'
        i -= 500
      end
      if i >= 400
        letters << 'C'
        letters << 'D'
        i -= 400
      end
      while i >= 100
        letters << 'C'
        i -= 100
      end
      if i >= 90
        letters << 'X'
        letters << 'C'
        i -= 90
      end
      if i >= 50
        letters << 'L'
        i -= 50
      end
      if i >= 40
        letters << 'X'
        letters << 'L'
        i -= 40
      end
      while i >= 10
        letters << 'X'
        i -= 10
      end
      if i >= 9
        letters << 'I'
        letters << 'X'
        i -= 9
      end
      if i >= 5
        letters << 'V'
        i -= 5
      end
      if i >= 4
        letters << 'I'
        letters << 'V'
        i -= 4
      end
      while i >= 1
        letters << 'I'
        i -= 1
      end

      letters.join
    end

    def to_i
      @value
    end
    
    # bonus: create from Roman Numeral
    def self.from_string(s)
      values = s.chars.map {|letter| LETTER_VALUES[letter.to_sym]}
      values.each_with_index do |value, i|
        next if i == 0
        if value > values[i - 1]
          values[i - 1] = -values[i - 1]
        end
      end

      RomanNumeral.new(values.reduce(:+))
    end
  end

  class RomanNumeralTest < Minitest::Test
    def test_to_s
      assert_equal('I', RomanNumeral.new(1).to_s)
      assert_equal('II', RomanNumeral.new(2).to_s)
      assert_equal('III', RomanNumeral.new(3).to_s)
      assert_equal('IV', RomanNumeral.new(4).to_s)
      assert_equal('V', RomanNumeral.new(5).to_s)
      assert_equal('VI', RomanNumeral.new(6).to_s)
      assert_equal('IX', RomanNumeral.new(9).to_s)
      assert_equal('X', RomanNumeral.new(10).to_s)
      assert_equal('XIX', RomanNumeral.new(19).to_s)
      assert_equal('XXXII', RomanNumeral.new(32).to_s)
      assert_equal('LI', RomanNumeral.new(51).to_s)
    end

    def test_to_i
      assert_equal(3, RomanNumeral.from_string('III').to_i)
      assert_equal(9, RomanNumeral.from_string('IX').to_i)
    end

    def test_identity
      (1..3999).each {|n| assert_equal(n, RomanNumeral.from_string(RomanNumeral.new(n).to_s).to_i)}
    end
  end
end

# expected results:
# RomanNumeral.new(1).to_s   # => 'I'
# RomanNumeral.new(2).to_s   # => 'II'
# RomanNumeral.new(3).to_s   # => 'III'
# RomanNumeral.new(4).to_s   # => 'IV'
# RomanNumeral.new(5).to_s   # => 'V'
# RomanNumeral.new(6).to_s   # => 'VI'
# RomanNumeral.new(9).to_s   # => 'IX'
# RomanNumeral.new(10).to_s  # => 'X'
# RomanNumeral.new(19).to_s  # => 'XIX'
# RomanNumeral.new(32).to_s  # => 'XXXII'
# RomanNumeral.new(51).to_s  # => 'LI'

# bonus:
# RomanNumeral.from_string('III').to_i  # => 3
# RomanNumeral.from_string('IX').to_i   # => 9
# RomanNumeral.from_string('IX').to_i   # => 9

# given any arbitrary integer n:
# n == RomanNumeral.from_string(RomanNumeral.new(n).to_s).to_i

# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

module Assignment08
  def golden_ratio(precision)
    precision_threshold = BigDecimal.new("0.1") ** precision

    fib_prev = 0
    fib = 1
    fib_next = 1

    begin
      new_fib_next = fib + fib_next
      fib_prev = fib
      fib = fib_next
      fib_next = new_fib_next

      ratio_prev = BigDecimal.new(fib.to_s)/BigDecimal.new(fib_prev.to_s)
      ratio = BigDecimal.new(fib_next.to_s)/BigDecimal.new(fib.to_s)
    end until (ratio - ratio_prev).abs < precision_threshold

    ratio.round(precision).to_s('F')
  end

  class GoldenRatioTest < Minitest::Test
    include Assignment08

    def test_golden_ratio
      assert_equal("1.62", golden_ratio(2))
      assert_equal("1.61803", golden_ratio(5))
      assert_equal("1.61803399", golden_ratio(8))
      assert_equal("1.6180339887499", golden_ratio(13))
    end
  end
end

# expected results:
# golden_ratio(2)  # => "1.62"
# golden_ratio(5)  # => "1.61803"
# golden_ratio(8)  # => "1.61803399"
