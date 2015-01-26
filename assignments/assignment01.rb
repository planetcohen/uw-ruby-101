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
<<<<<<< HEAD
  words = s.split
  caps = []
  words.each do |word|
    caps << word.capitalize
  end
  caps.join " "
=======
  string = s.split(" ").map(&:capitalize).join(" ") 
  puts string
>>>>>>> 4d8c5e17aeeaa3f02b03d7ced1497e0eb3fe09fb
end

# Your method should generate the following results:
titleize "hEllo WORLD"          #=> "Hello World"

titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
<<<<<<< HEAD
  output = ""
  letters = s.split ""
  n = letters.length
  while n > 0
    n -= 1
    output << letters[n]
  end
  output
=======
  string = s.split("")
  loop = string.length
  output =""
  while loop > 0
    loop -= 1
    output +=string[loop]
  end
 return output
>>>>>>> 4d8c5e17aeeaa3f02b03d7ced1497e0eb3fe09fb
end

# Your method should generate the following results:
my_reverse "Hello World"          #=> "dlroW olleH"

my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"


# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)
<<<<<<< HEAD
  stripped = s.delete(" ").delete(",").downcase
  stripped == stripped.reverse
=======
  forward = s.downcase.delete(" ").delete(",")
  backward = s.downcase.reverse.delete(" ").delete(",")
    if forward == backward
        puts true
    elsif forward != backward
        puts false
    end
>>>>>>> 4d8c5e17aeeaa3f02b03d7ced1497e0eb3fe09fb
end

# Your method should generate the following results:
palindrome? "abba"                             #=> true
palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> false

palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true
