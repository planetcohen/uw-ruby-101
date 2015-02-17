# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    words = self.split(" ")
    words.map { |w| w.capitalize }.join(" ")
  end

  def palindrome?
  	pal_string = self.downcase.gsub(/[^a-z]/, '')
  	pal_string == pal_string.reverse
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
  	sum = self.reduce {|i, acc| i + acc}
  	mean = sum/self.length.to_f
  end

  def median
	len = self.length
	sorted = self.sort

  	if len % 2 == 1
    median = sorted[len/2]
  	else
    median = (sorted[len/2].to_f + sorted[-1 + len/2].to_f) / 2 
  end

  def to_sentence
  	words = self[0...-1].reduce {|word, acc| word.to_s + ", #{acc}"}
  	and_last = [words, self[-1]]
  	my_sentence = and_last.compact.join " and "
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

### Getting lost in blocks - would appreciate either recordings of the last two lectures or 
### additional resources for review.  Trying to google for help is leading me down too many
### rabbit holes!
