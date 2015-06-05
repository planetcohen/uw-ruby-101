# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral
    attr_accessor :i, :arr, :to_int
    def initialize(i)
      @i = i
      @arr = [
            ["M" , 1000],
            ["CM" , 900],
            ["D" , 500],
            ["CD" , 400],
            ["C" , 100],
            ["XC" , 90],
            ["L" , 50],
            ["XL" , 40],
            ["X" , 10],
            ["IX" , 9],
            ["V" , 5],
            ["IV" , 4],
            ["I" , 1]
          ]
          @to_int = to_int
    end

    def to_s
      string = ""
      for key, value in @arr
        count, @i = @i.divmod(value)
        string << (key * count)
      end
      string
    end

    def to_i
      to_int = 0
      for key, value in @arr
        while @i.index(key) == 0
          to_int += value
          @i.slice!(key)
        end
      end
      @to_int = to_int
      to_int
    end
    
    # bonus: create from Roman Numeral
    def self.from_string
      # (@to_int).to_s
      # returns a new instance
    end
  end

  require 'minitest/autorun'
  class TestRomanNumeral < MiniTest::Test
    def test_one
      assert_equal 'I', RomanNumeral.new(1).to_s
      assert_equal 'II', RomanNumeral.new(2).to_s
      assert_equal 'III', RomanNumeral.new(3).to_s
      assert_equal 'IV', RomanNumeral.new(4).to_s
      assert_equal 'V', RomanNumeral.new(5).to_s   # => 'V'
      assert_equal 'VI', RomanNumeral.new(6).to_s   # => 'VI'
      assert_equal 'IX', RomanNumeral.new(9).to_s   # => 'IX'
      assert_equal 'X', RomanNumeral.new(10).to_s  # => 'X'
      assert_equal 'XIX', RomanNumeral.new(19).to_s  # => 'XIX'
      assert_equal 'XXXII', RomanNumeral.new(32).to_s  # => 'XXXII'
      assert_equal 'LI', RomanNumeral.new(51).to_s  # => 'LI'
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
  class GoldenRatioContainer
    def golden_ratio(precision)
      fib1= 61305790721611591 
      fib2=37889062373143906
      (fib1.to_f/fib2.to_f).round(precision)
    end
  end

  require 'minitest/autorun'
  class GoldenRatioTest < MiniTest::Test
    def test_one
      assert_equal 1.62, GoldenRatioContainer.new.golden_ratio(2)
      assert_equal 1.61803, GoldenRatioContainer.new.golden_ratio(5)
      assert_equal 1.61803399, GoldenRatioContainer.new.golden_ratio(8)
    end
  end
end
