# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

 class String
  def titleize
    my_words = self.split(" ")
    cap_sentence = ""
    my_words.each {|w| cap_sentence << w.capitalize << " "} 
    cap_sentence.chop
  end
  
  def palindrome?
    s1 = self.gsub(' ', '').downcase
    s1 = s1.gsub(',', '').downcase
    s2 = s1.reverse
    if s2 == s1 
      true
    else
      false
    end
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
    tot = self.reduce {|i, acc| i + acc }
    tot.to_f/self.length
  end
  
  def median
    alen = self.length
    if alen % 2 == 1 then
      med = self[alen/2]
    else
      mean([self[alen/2],self[(alen/2)+1]])
    end
  end
  
  def to_sentence
    str1 = self[0...-1].reduce {|item, acc| item.to_s + ", #{acc}"}
    a2 = [str1, self[-1]]
    a2.compact!
    a2.join " and "
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
