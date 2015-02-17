# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize()
    words = self.split
    caps = []
    words.each do |word|
      caps << word.capitalize
    end
    caps.join " "
  end

  def palindrome?()
    stripped = self.delete(" ").delete(",").downcase
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
  def to_sentence()
    if self.length == 0
      []
    elsif self.length == 1
      self[0]
    else
      last = self.pop
      "#{self.join(", ")} and #{last}"
    end
  end

  def mean()
    self.length > 0 ? self.reduce(0) {|item, acc| acc + item + 0.0} / self.length : 0
  end

  def median()
    if self.length % 2 == 0
      (self.sort[(self.length)/2] + self.sort[(self.length)/2-1]) / 2.0
    else
      self.sort[(self.length - 1)/2]
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
