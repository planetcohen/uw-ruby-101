# Homework #1
# Douglas McGowan
# RUBY DL110

# ========================================================================================
#  Problem 1 - `titleize`

# implement a method `titleize`

# it accepts a string
# and returns the same string with each word capitalized.
def titleize(s)
    num_letters = s.length	#Get number of characters in string
	s.downcase!		#Turn all letters to lowercase
	s.capitalize!		#Capitalize the first word in the string
	(1...num_letters).each do |n|		#Loop to capitalize any letter after a space
		if s[n-1].chr==" "
			s[n]=s[n].chr.upcase
		end	
	end
 return s			#Return result
end

# Your method should generate the following results:
#titleize "hEllo WORLD"          #=> "Hello World"

#titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
	reverse_string  = s.downcase		
		#Purpose is to get a new string with same legth as 's'. 
		#Using downcase avoids error (maybe a relational error that causes program to run incorrectly) 
	num_letters = s.length
	(0...num_letters).each do |n|		#Loop to reverse sequence of characters
		reverse_string[n]=s[num_letters-1-n]
	end
  return reverse_string 	#Return result
end

# Your method should generate the following results:
#my_reverse "Hello World"          #=> "dlroW olleH"

#my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"


# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)

   result = false

	s.delete! " "	#remove punctuation
	s.delete! ","
	s.delete! "."
	s.delete! "!"  		
	
	if s.length%2 == 0
		midpoint1 = s.length/2-1
		midpoint2 = s.length/2
	else
		midpoint1 = (s.length-1)/2-1
		midpoint2 = (s.length-1)/2+1
	end
	
	puts word1 = s[0..midpoint1].downcase
	puts word2 = s[midpoint2..s.length].downcase.reverse
		
	if word1 == word2
	result = true
	end
		
	
   return result

end

# Your method should generate the following results:
#palindrome? "abba"                             #=> true
#palindrome? "aBbA"                             #=> true
#palindrome? "abb"                              #=> false

#palindrome? "Able was I ere I saw elba"        #=> true
#palindrome? "A man, a plan, a canal, Panama"   #=> true
