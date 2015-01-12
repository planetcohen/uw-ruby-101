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
  # your implementation here
  string_words = s.split " "

  result = ""
  string_words.each do |word|
    result << word.downcase.capitalize << " "
  end
  
  result.chop
end

# Your method should generate the following results:
titleize "hEllo WORLD"          #=> "Hello World"

titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
  # your implementation here
  result = ""
  (1..s.length).each do |i|
    result[i-1] = s[s.length-i]
  end

  result
end

# Your method should generate the following results:
my_reverse "Hello World"          #=> "dlroW olleH"

my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"


# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)
  characters_input = s.downcase.split ""

  # remove non-letters
  string_cleaned_input = ""
  characters_input.each do |some_symbol|
    if some_symbol.match(/^[[:alpha:]]$/)
      string_cleaned_input << some_symbol
    end
  end

  string_reversed = ""
  (1..string_cleaned_input.length).each do |i|
    string_reversed[i-1] = string_cleaned_input[string_cleaned_input.length-i]
  end

  string_cleaned_input == string_reversed
end

# Your method should generate the following results:
palindrome? "abba"                             #=> true
palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> false

palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true
