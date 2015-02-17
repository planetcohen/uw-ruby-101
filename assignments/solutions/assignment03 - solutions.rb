# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String
class String
	def titleize
		string = split.map { |w| w.downcase.capitalize }.join " "
		string
	end
	def palindrome?
		string1 = downcase.delete(", ")
		string2 = string1.reverse
		string1 == string2
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
		sum = 0.0
		mean = 0.0
		ary = self.each do |num|
			sum += num
		end
		mean = sum/ary.length
		mean.round(1)
	end

	def median
		length = self.length
		median = 0.0
		if length % 2 > 0
			median = self[length / 2.0]
		else
			div = (length + 1) / 2
			median = (self[div - 1] + self[div] )/ 2.0
		end
		median
	end

	def to_sentence
		first_sentence, second_sentence, sentence = "", "", ""
		"\"\"" if self.empty?
		self.each do |word|
			if self.index(word) < self.length-1
				first_sentence << word.to_s + ", "
			elsif self.length >= 2
				second_sentence << " and " + word.to_s
			else
				second_sentence << word.to_s
			end
		end
		sentence = first_sentence.chop.chop + second_sentence
		sentence
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
