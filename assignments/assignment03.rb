# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?
class String
	
	def titleize
		split(" ").map(&:capitalize).join(" ") 
	end

	def palindrome?
  	    forward = downcase.delete(" ").delete(",")
  	    backward = forward.reverse
        forward == backward
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

    def to_sentence
        count = self.count
        if count > 2
            last = self.pop
            sentence ="#{self.join(", ")}, and #{last}"
            return sentence
        elsif count == 2
            last = pop
            sentence ="#{self.join(", ")} and #{last}"
            return sentence
        else
            return "#{self}"
        end
    end

    def median
        count = self.count
        total = 0
        if !(count.even?)
            middle = (count - 1)/2
            return self[middle]
        else
            right = (count/2)
            left = (count/2)-1
            return (self[left] + self[right])/2.to_f
        end
    end

    def mean
        count = self.count.to_f
        total = 0
        self.each do |num|
            total = num + total
        end
        mean = (total / count).to_f
        puts count
        puts total
        return mean
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
