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
  # split s into an array of strings called 'words'
  words = s.split
  # capitalize each string as you read it out of the array 'words'
  # into an array called 'title'
  title = []
  words.each do |words|
    title << words.capitalize
  end
  # rejoin words in 'title' into a string
  title.join " "
end

# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
  backwards = ""
  length = s.length
  while length > 0
    length = length - 1
    backwards << s[length]
  end
  backwards
end

# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)
  # first remove punctuation and spaces
  inputstring = s.delete(" ").delete(",").downcase
  # compare modified string to reversed string
  inputstring == inputstring.reverse
end