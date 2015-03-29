# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?
# re-implement titleize and palindrome? as methods on String

class String
	def titleize
		word = self.split
		title=[]
		word.each do |words|
			title << words.capitalize
		end
		title.join " "
	end

	def palindrome?
  	inputstring = self.delete(" ").delete(",").downcase
  	inputstring == inputstring.reverse
	end
end

# ========================================================================================
#  Problem 2 - re-implement mean, median, to_sentence
# re-implement mean, median, to_sentence as methods on Array
class Array
	def mean
  	self.reduce {|item, acc| acc + item} / self.length.to_f
	end

	def median
  	middle = self.length / 2
  	sorted = self.sort
  	self.length.odd? ? sorted[middle] : 0.5 * (sorted[middle] + sorted[middle - 1])
	end

	def to_sentence  
  	unless (self.length < 2)
    	last_word = self.pop.to_s
    	sentence = (self.join ", ") << " and " << last_word
  	else
    	self.pop.to_s
  	end
	end
end

# ========================================================================================
#  Problem 3 - re-implement bank statement

# re-implement bank statement from Assignment 2

# instead of using hashes, create classes to represent:
# - BankAccount
# - Transaction
# - DepositTransaction
# - WithdrawalTransaction

# use blocks for your HTML rendering code
