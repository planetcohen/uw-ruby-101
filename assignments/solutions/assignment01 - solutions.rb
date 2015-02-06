# ========================================================================================
#  Assignment solutions submitted by Gordon Turibamwe
#
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
  print result
end


# ========================================================================================
#  Problem 1 - `titleize`

# implement a method `titleize`

# it accepts a string
# and returns the same string with each word capitalized.
def titleize(s)
  s = s.downcase.capitalize
  count = 0
  while count < s.length
    if s[count] == " "
      s[count + 1] = s[count + 1].capitalize
    end
    count += 1
  end
  return s
end

# Your method should generate the following results:
titleize "hEllo WORLD"          #=> "Hello World"
titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
  newString = ""  # => initialize new string
  count = s.length - 1 # => counting down
  while count >= 0
    newString += s[count]
    count -= 1
  end
  return newString
end

# Your method should generate the following results:
my_reverse "Hello World"          #=> "dlroW olleH"
my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"


# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome

def palindrome?(s)  
    string1 = s.downcase.delete(", ")
    string2 = string1.reverse
    string1 == string2
end

# Your method should generate the following results:
palindrome? "abba"                             #=> true
palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> fputs ""
palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true


