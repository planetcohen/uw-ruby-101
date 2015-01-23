# ========================================================================================
#  Sample Problem - `number_to_string`
def number_to_string(n, lang)
  lang_digit_strings = {
    en: %w(zero one two three four five six seven eight nine),
    de: %w(null eins zwei drei vier fünf sechs sieben acht neun),
    es: %w(cero uno dos tres cuatro cinco seis siete ocho nueve),
    fr: %w(zéro un deux trois quatre cinq six sept huit neuf)
  }
  
  digit_strings = lang_digit_strings[lang]
  return "no such language" if digit_strings.nil?

  s = n.to_s
  string_digits = s.split ""


  num_digits = []
  string_digits.each do |s|
    num_digits << s.to_i
  end
  
  result = ""
  num_digits.each do |digit|
    result << digit_strings[digit]
    result << " "
  end

  result.chop
end


# ========================================================================================
#  Problem 1 - `titleize`

# implement a method `titleize`

# it accepts a string
# and returns the same string with each word capitalized.
def titleize(s)

  # first downcase the entire string
  s.downcase!
 
  # then split the string into individual word elements
  word_elements = s.split
 
  # iterate over all elements in the array, capitalize each word
  word_elements.each do |word|
    word.capitalize!
  end
 
  # join the array back into a string and insert proper spaces
  word_elements.join " "

end

# Your method should generate the following results:
titleize "hEllo WORLD"          #=> "Hello World"

titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)

  # find the length of the string
  i = s.length
 
  # split the string into an array of characters
  chars = s.split ""
 
  # initialize the string where we'll put the result
  result = ''
 
  # index the characters, call the characters back starting with the last character 
  # as defined by the length of the original string
  while i > 0
    i -= 1
   result += chars[i]
  end
 
  # return the result string
  return result

end

# Your method should generate the following results:
my_reverse "Hello World"          #=> "dlroW olleH"

my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"


# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)

  # strip out non alpha characters, downcase, check to see if the reverse is equivalent to the original string
  # (must strip out non alpha characters to handle the last example case)
  s.downcase.gsub(/[^a-z]/, '') == s.downcase.reverse.gsub(/[^a-z]/, '')

end

# Your method should generate the following results:
palindrome? "abba"                             #=> true
palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> false

palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true
