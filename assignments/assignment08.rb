# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

require 'MiniTest/autorun'
module Assignment08

  class RomanNumeral 
    def initialize(i)
      @codex = {
                  1 => 'I',
                  4 => 'IV',
                  5 => 'V',
                  9 => 'IX',
                  10 => 'X',
                  20 => 'XX',
                  30 => 'XXX',
                  40 => 'XL',
                  50 => 'L',
                  }
      @digits = i
    end
    
    def to_s
      roman = ''
      @codex.keys.reverse.each do |logical_number|
        while @digits >= logical_number
          @digits -= logical_number
          roman += @codex[logical_number]
        end
      end
      roman
    end
    
    def to_i
    @digits
	  end
	
	  # bonus: create from Roman Numeral
	  def self.from_string
	  # your implementation here
	  # returns a new instance
	  end

  end
  
end

  class TestRomanNumeral < Minitest::Test

    # expected results:
    def initialize
     assert_equal "I", RomanNumeral.new(1).to_s # RomanNumeral.new(1).to_s # => 'I'
     assert_equal "II", RomanNumeral.new(2).to_s # RomanNumeral.new(2).to_s # => 'II'
     assert_equal "III", RomanNumeral.new(3).to_s # RomanNumeral.new(3).to_s # => 'III'
     assert_equal "IV", RomanNumeral.new(4).to_s # RomanNumeral.new(4).to_s # => 'IV'
     assert_equal "V", RomanNumeral.new(5).to_s # => RomanNumeral.new(5).to_s 
     assert_equal "VI", RomanNumeral.new(6).to_s # => RomanNumeral.new(6).to_s
     assert_equal "IX", RomanNumeral.new(9).to_s # => RomanNumeral.new(9).to_s
     assert_equal "X", RomanNumeral.new(10).to_s # => RomanNumeral.new(10).to_s
     assert_equal "XIX", RomanNumeral.new(19).to_s # => RomanNumeral.new(19).to_s
     assert_equal "XXXII", RomanNumeral.new(32).to_s # => RomanNumeral.new(32).to_s
     assert_equal "LI", RomanNumeral.new(51).to_s # => RomanNumeral.new(51).to_s
    end
  end
  
    def golden_ratio(precision)
    g = 1.61803399
    precision.times { g = 1 + 1/g }
    return g.round(precision)
  end

  end


  class TestGoldenRatio < Minitest::Test

    # expected results:
    def initialize
      assert_equal 1.62, golden_ratio(2) # golden_ratio(2) # => 1.62
      assert_equal 1.61803, golden_ratio(5) # golden_ratio(5) # => 1.61803
      assert_equal 1.61803399, golden_ratio(8) # golden_ratio(8) # => 1.61803399
    end

  end

end
