# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

require 'minitest/autorun'

module Assignment08
  class RomanNumeral
    @@numerals = {
      "I" => 1,
      "V" => 5,
      "X" => 10,
      "L" => 50,
      "C" => 100,
      "D" => 500,
      "M" => 1000
    }

    def initialize(i)
      @i = i
    end

    # to_s takes an integer and converts it to the Roman Numeral representation
    def to_s
      i = @i
      numerals = @@numerals
      str = ""


      if i == 0
        return "nulla"
      elsif i.nil?
        return nil
      elsif i < 0
        return "You cannot write negative numbers as Roman Numerals."
      elsif i.is_a? Integer

        until i <= 0 do
          ending = str.reverse[0..2]
          #puts "ending = #{ending}"
          if i - numerals["M"] >= 0
            i -= numerals["M"]
            str << "M"
            next
          elsif i.between?((numerals["C"]*9), numerals["M"])
            i -= (numerals["M"] - numerals["C"])
            str << "CM"
            next
          end

          if i - numerals["D"] >= 0
            i -= numerals["D"]
            str << "D"
            next
          elsif i.between?((numerals["C"]*4), numerals["D"])
            i -= (numerals["D"] - numerals["C"])
            str << "CD"
            next
          end

          if i - numerals["C"] >= 0
            i -= numerals["C"]
            str << "C"
            next
          elsif i.between?((numerals["X"]*9), numerals["C"])
            i -= (numerals["C"] - numerals["X"])
            str << "XC"
            next
          end

          if i - numerals["L"] >= 0
            i -= numerals["L"]
            str << "L"
            next
          elsif i.between?((numerals["X"]*4), numerals["L"])
            i -= (numerals["L"] - numerals["X"])
            str << "XL"
            next
          end

          if i - numerals["X"] >= 0
            i -= numerals["X"]
            str << "X"
            next
          elsif i - numerals["X"] == -1
            i -= (numerals["X"] - numerals["I"])
            str << "IX"
            next
          end

          if i - numerals["V"] >= 0
            i -= numerals["V"]
            str << "V"
            next
          elsif i - numerals["V"] == -1
            i -= (numerals["V"] - numerals["I"])
            str << "IV"
            next
          end

          if i - numerals["I"] >= 0
            i -= numerals["I"]
            str << "I"
            next
          elsif i - numerals["I"] < 0
            puts "ERROR - GOT BELOW ZERO"
            next
          end
        end

        str
      else
        return nil
      end
      # puts "Int = #{@i} | RN = #{str}"
      str
    end

    # to_i takes a roman numeral string and converts it to an integer
    def to_i
      i = @i
      if i == 'nulla'
        return 0
      elsif i.nil?
        return nil
      elsif i.is_a? String
        total = 0
        previous = 0

        i = i.split("")

        i = i.map do |letter|
          @@numerals[letter]
        end

        i.each do |value|
          if value <= previous
            #puts "value < previous"
            total += previous
          else
            total -= previous
          end
          previous = value
        end
        total += previous
        # puts i
        # puts "total = #{total}"


        #@i = i
      else
        return nil
      end
    end
    
    # bonus: create from Roman Numeral
    def self.from_string(text)
      # returns a new instance
      RomanNumeral.new(text)
    end
  end


  def golden_ratio(n)
    i = 1.0
    high_num = 1000
    high_num.times { i = (1 + 1/i)}
    return i.round(n)
  end



  require 'minitest/autorun'

  class TestAssignment08 < Minitest::Unit::TestCase

    def test_to_s
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
      assert_equal 'CDXLIX', RomanNumeral.new(449).to_s  # => 'CDXLIX'
      assert_equal 'CMXCIX', RomanNumeral.new(999).to_s  # => 'CMXCIX'
      assert_equal 'MMMMCMXCIX', RomanNumeral.new(4999).to_s  # => 'MMMMCMXCIX'
      assert_equal 'nulla', RomanNumeral.new(0).to_s  # => 'nulla'
      assert_equal nil, RomanNumeral.new(nil).to_s  # => nil
      assert_equal 'You cannot write negative numbers as Roman Numerals.', RomanNumeral.new(-1000).to_s  # => 'You cannot write negative numbers as Roman Numerals.'
    end

    def test_to_i
      assert_equal 1, RomanNumeral.new('I').to_i   # =>  1
      assert_equal 2, RomanNumeral.new('II').to_i   # =>  2
      assert_equal 3, RomanNumeral.new('III').to_i   # =>  3
      assert_equal 4, RomanNumeral.new('IV').to_i   # =>  4
      assert_equal 5, RomanNumeral.new('V').to_i   # =>  5
      assert_equal 6, RomanNumeral.new('VI').to_i   # =>  6
      assert_equal 9, RomanNumeral.new('IX').to_i   # =>  9
      assert_equal 10, RomanNumeral.new('X').to_i   # => 10
      assert_equal 19, RomanNumeral.new('XIX').to_i   # =>  19
      assert_equal 32, RomanNumeral.new('XXXII').to_i   # =>  32
      assert_equal 51, RomanNumeral.new('LI').to_i   # =>  51
      assert_equal 449, RomanNumeral.new('CDXLIX').to_i   # =>  449
      assert_equal 999, RomanNumeral.new('CMXCIX').to_i   # =>  999
      assert_equal 4999, RomanNumeral.new('MMMMCMXCIX').to_i   # =>  4999
      assert_equal 0, RomanNumeral.new('nulla').to_i   # =>  0
      assert_equal nil, RomanNumeral.new(nil).to_i   # =>  nil

    end

    def test_golden_ratio
      assert_equal 1.62, golden_ratio(1)
      assert_equal 1.61803, golden_ratio(5)
      assert_equal 1.61803399, golden_ratio(8)
    end
    
  end

  
end
