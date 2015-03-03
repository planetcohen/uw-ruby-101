# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral
    def initialize(i)
      @greek = i.to_i
      @roman = nil
      @roman1 = %w(I X C M)
      @roman5 = %w(V L D)
    end

    def digits n
      #Some code I found for converting to digits a little faster than
      #going through strings
      n= n.abs
      [].tap do |result|
        while n > 0
          n,digit = n.divmod 10
          result.unshift digit
        end
      end
    end

    def to_s
      result = digits(@greek).reverse.map.with_index do |g, i|
        if g == 0
          nil
        elsif g <= 3
          @roman1[i] * g
        elsif g == 4
          @roman1[i] + @roman5[i]
        elsif g <= 8
          @roman5[i] + @roman1[i]*(g-5)
        else
          @roman1[i] + @roman1[i+1]
        end
      end
      @roman = result.reverse.join
    end

    def to_i
      tens = @roman1
      last_ten = tens.pop
      #roman =~ /#{roman1[c]}/ || @roman =~ /#{@roman5[c]}/
      result = tens.map.with_index do |c, i|
        if @roman =~ /#{@roman1[i]}#{@roman1[i+1]}/
          9
        elsif @roman =~ /#{@roman1[i]}#{@roman5[i]}/
          4
        elsif @roman =~ /#{@roman5[i]}/
          5 + @roman[/#{@roman1[i]}*/].length
        elsif @roman =~ /#{@roman1[i]}/
          @roman[/#{@roman1[i]}*/].length
        else
          0
        end
      end
      if @roman =~ /#{last_ten}+/
        result << @roman[/#{last_ten}+/].length
      end
      result.reverse.join.to_i
    end

    # bonus: create from Roman Numeral
    def self.from_string
      # your implementation here
      # returns a new instance
    end
  end



  require 'minitest/autorun'

  class Test1 < Minitest::Test
    def setup
      r1 = RomanNumeral.new 1
      @tc = Thermometer_Control.new @t1
      @td = Thermometer_Display.new @t1
      @md = Mercury_Display.new @t1
    end

    def test_render_output
      # @tc.click_up
      assert_output (/26/) { @tc.click_up}
      assert_output (/[XXX       ]/) { @tc.click_up}
      assert_output (/26/) { @tc.click_down}
      assert_output (/[XX        ]/) { 2.times {@tc.click_down}}  #24

      assert_output (/124/) { 100.times {@tc.click_up}}
      assert_output (/[XXXXXXXXXX]/) { 1.times {@tc.click_down}} #123

      assert_output (/-1/) { 124.times {@tc.click_down}}
      assert_output (/[          ]/) { 1.times {@tc.click_down}} #-125
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
