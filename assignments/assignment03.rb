# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    downcase.split.map { |w| w.capitalize }.join " "
  end
  def palindrome?
    downcase.gsub(/\s+/m, '').gsub(/,/, '') == downcase.gsub(/\s+/m, '').gsub(/,/, '').reverse
  end
end


"hEllo WORLD".titleize                         #=> "Hello World"
"gooDbye CRUel wORLD".titleize                 #=> "Goodbye Cruel World"

"abba".palindrome?                             #=> true
"aBbA".palindrome?                             #=> true
"abb".palindrome?                              #=> false

"Able was I ere I saw elba".palindrome?        #=> true
"A man, a plan, a canal, Panama".palindrome?   #=> true


# ========================================================================================
#  Problem 2 - re-implement mean, median, to_sentence

# re-implement mean, median, to_sentence as methods on Array

class Array
  def mean
    inject(:+) / length.to_f
  end
  def median
    if (length % 2) == 1
      sort[length/2]
    else
      [ sort[length/2], sort[(length/2) - 1] ].mean
    end
  end
  def to_sentence
    each_with_index.map do |w, index|
      case index
      when (length - 1) then w.to_s
      when (length - 2) then w.to_s << " and"
      else w.to_s << ","
      end
    end.join " "
  end
end


# Your method should generate the following results:
[1, 2, 3].mean     #=> 2
[1, 1, 4].mean     #=> 2

[1, 2, 3].median   #=> 2
[1, 1, 4].median   #=> 1

[].to_sentence                       #=> ""
["john"].to_sentence                 #=> "john"
["john", "paul"].to_sentence         #=> "john and paul"
[1, "paul", 3, "ringo"].to_sentence  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 3 - re-implement bank statement

# re-implement bank statement from Assignment 2

# instead of using hashes, create classes to represent:
# - BankAccount
# - Transaction
# - DepositTransaction
# - WithdrawalTransaction

# use blocks for your HTML rendering code
