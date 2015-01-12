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
end


# ========================================================================================
#  Problem 1 - `titleize`

# implement a method `titleize`

# it accepts a string
# and returns the same string with each word capitalized.
def titleize(s)

  # => PSEUDO CODE
  # => -----------------------------------------------------------------
  # => downcase all characters, then capitalize first character
  # => iterate the string, capitalize each first letter every after space
  # => save each change to new string
  # => return the string
  # => ------------------------------------------------------------------

  s = s.downcase.capitalize
  count = 0
  while count < s.length
    if s[count] == " "
      s[count + 1] = s[count + 1].capitalize
    end
    count += 1
  end
  print s
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

  # => PSEUDO CODE
  # => -----------------------------------------------------------------
  # => count the length of the string use it as the countdown
  # => iterate string to the last character - zero index
  # => save each letter to a newString
  # => return the new string
  # => ------------------------------------------------------------------

  newString = ""  # => initialize new string
  count = s.length - 1 # => counting down
  while count >= 0
    newString += s[count]
    count -= 1
  end
  print newString
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
  
  # => PSEUDO CODE
  # => -----------------------------------------------------------------
  # => count the length of the string use it as the countdown
  # => iterate string to the last character - zero index
  # => compare last char and first char if the same then go to the nex if not the exit
  # => return true of false
  # => ------------------------------------------------------------------
  
  firstChar = 0
  lastChar = s.length - 1
  while firstChar < s.length
    s = s.downcase
    if s[firstChar].eql?(s[lastChar])
      print true
      return true
    else
      print false
      return false
    end

    firstChar += 1
    lastChar -= 1
  end
  
end

# Your method should generate the following results:
palindrome? "abba"                             #=> true
palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> false

palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true



