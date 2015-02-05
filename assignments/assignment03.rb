# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize(s)
    words = s.split
    caps = []
    words.each do |word|
      caps << word.capitalize
      end
    caps.join " "
  end

  def palindrome?(s)
  stripped = s.delete(" ").delete(",").downcase
  stripped == stripped.reverse
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
  def to_sentence(ary)
    if ary.length == 0
      []
    elsif ary.length == 1
      ary[0]
    else
      last = ary.pop
      "#{ary.join(", ")} and #{last}"
    end
  end
  
  def mean(ary)
    sum = ary.reduce(0) {|x, acc| acc + x}
    sum.to_f / ary.length
  end

  def median(ary)
    sorted_ary = ary.sort
    len = sorted_ary.length
    mid_index = len/2
    if len.odd?
      sorted_ary[mid_index]
    else
      mid_lo = sorted_ary[mid_index]
      mid_hi = sorted_ary[mid_index+1]
      (mid_lo + mid_hi)/2.0
    end
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
class BankAccount
end

class Transaction
end

class DepositTransaction < Transaction
end

class WithdrawalTransaction < Transaction
end

