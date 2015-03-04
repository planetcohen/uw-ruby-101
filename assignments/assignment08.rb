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
          if @roman =~ /#{@roman1[i]}/
            5 + @roman[/#{@roman1[i]}+/].length
          else
            5
          end
        elsif @roman =~ /#{@roman1[i]}/
            @roman[/#{@roman1[i]}+/].length
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

  def write_to_file(title, &block)
    File.open(title, "w+") do |output|
      output.write block.call
    end
  end

  def calc_test_sequence(test_greek)
    write_to_file "calc_test_sequence.txt" do
      test_out = test_greek.map do |g|
        <<-NUM
        #{(RomanNumeral.new g).to_s}
        NUM
      end
      test_out.join
    end
  end


  require 'minitest/autorun'

  class TestRoman < Minitest::Test
    def write_to_file(title, &block)
      File.open(title, "w+") do |output|
        output.write block.call
      end
    end

    def calc_test_sequence(title, test_greek)
      write_to_file title do
        test_out = test_greek.map do |g|
          <<-NUM
#{(RomanNumeral.new g).to_s}
          NUM
        end
        test_out.join
      end
    end

    def test_greek_to_roman
      #Makes a text file with roman numerals.
      test_greek = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,30,40,50,60,100,499,500,999,1000,1500,3299]
      out_title = "calc_test_sequence.txt"
      calc_test_sequence out_title, test_greek

      File.open(out_title) do |input|
        test_roman = input.readlines

        test_greek.map.with_index do |g, i|
          assert_equal (RomanNumeral.new g).to_s, test_roman[i].chomp
          #temp = RomanNumeral.new g
          #temp.to_s
          #assert_equal g, temp.to_i
        end
      end
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
  def golden_ratio(precision, n=3, cache=[1.0,1.0,2.0])
    def fib(n, cache)
      if cache.length >= n
        cache[n-1]
      else
        fib(n-2, cache) + fib(n-1, cache)
      end
    end

    if cache.length < n
      cache[n-1] = fib(n, cache)
    end

    ratio_last = cache[cache.length-1] / cache[cache.length - 2]
    ratio_pen = cache[cache.length - 2] / cache[cache.length - 3]

    if ratio_last.round(precision) == ratio_pen.round(precision)
      ratio_last.round(precision)
    else
      golden_ratio(precision, n+1, cache)
    end
  end

  # puts golden_ratio(15)

  require 'minitest/autorun'

  class TestRatio < Minitest::Test
    def test_cases
      gr = (1.0 + 5.0**0.5)/2.0

      test_cases = []
      val = 1
      until val > 15
        test_cases << val
        val += 1
      end
      test_cases.each { |tc| assert_equal gr.round(tc), golden_ratio(tc)}
    end
  end
end

# # expected results:
# golden_ratio(2)  # => 1.62
# golden_ratio(5)  # => 1.61803
# golden_ratio(8)  # => 1.61803399
