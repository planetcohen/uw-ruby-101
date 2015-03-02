

class RomanNumeral
  attr :roman_ones, :value, :arabic_digits, :arabic_ones_digit, :arabic_tens_digit, :arabic_100s_digit
  def initialize(i)
    @value = i
    @arabic_ones_digit = @value.to_s[-1].to_i
    @arabic_tens_digit = @value.to_s[-2].to_i
    @arabic_100s_digit = @value.to_s[-3].to_i
    @arabic_digits = {}
    [1,2,3].each {|n| @arabic_digits[n] = @value.to_s[n *-1].to_i}
  end

  def to_s
    roman_chars = []
    roman_chars << %w{I IV V IX}
    roman_chars << %w{X XL L XC}
    roman_chars << %w{C CD D CM}
    r_numeral = ""
    r_dig = ""
    @arabic_digits.keys.each do |k|
      if @arabic_digits[k] <= 3 then
        r_dig = roman_chars[k-1][0] * @arabic_digits[k]
      elsif @arabic_digits[k] == 4 then
        r_dig = roman_chars[k-1][1]
      elsif @arabic_digits[k] <= 8 then
        r_dig = roman_chars[k-1][2] + roman_chars[k-1][0] * (@arabic_digits[k] - 5)
      else r_dig = roman_chars[k-1][3]
      end
      r_numeral.insert(0, r_dig)
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


#require 'Assignment08'

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
    assert_equal 'IX', RomanNumeral.new(9).to_s
    assert_equal 'X', RomanNumeral.new(10).to_s
    assert_equal 'XIX', RomanNumeral.new(19).to_s
    assert_equal 'XXXII', RomanNumeral.new(32).to_s
    assert_equal 'LI', RomanNumeral.new(51).to_s
  end
end
