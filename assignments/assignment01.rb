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
  result = ""
  first_letter = "true"

  s.each_char do |i|
    if first_letter == "true" && ('abcdefghijklmnopqrstuvwxyz'.include? i.downcase)     # Capitalize if i is first letter overall or of word/group of letters.
      result << i.upcase
      first_letter = "false"
    elsif i == " "               # If i is a space, add it to result string and take note that you reached a space.
      result << i
      first_letter = "true"
    elsif 'abcdefghijklmnopqrstuvwxyz'.include? i.downcase    #If i is a letter but does not follow a space/non-letter character, it should not be capitalized.
      result << i.downcase
      first_letter = "false"
    else                     # If i is neither a space nor a letter, it should be added to the result string and the next letter should be capitalized.
      result << i
      first_letter = "true"
    end
  end
  return result
  # your implementation here
end

# Your method should generate the following results:
puts titleize "hEllo WORLD"          #=> "Hello World"

puts titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"






# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
  result = ""
  puts "before iterator"
  s.length.times do
    #puts "inside iterator"
    #puts "last letter = #{s[-1]}"
    result << s[-1]
    s = s[0...-1]
    #puts "s is now #{s}"
    #puts "length of s is now #{s.length}"
  end
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
  # your implementation here
  def toChars(s)
    #puts "toChars called"
    s = s.downcase
    ans = ''
    s.each_char do |c|
      #puts "c = #{c}"
      #puts ".include = #{'abcdefghijklmnopqrstuvwxyz'.include? c}"

      if 'abcdefghijklmnopqrstuvwxyz'.include? c     #ignore non-letter characters
        #puts "c found to be a letter"
        ans = ans + c
      end
    end
    #puts "ans = #{ans}"
    return ans
  end

=begin
    pal_recur method uses recursion to compare first character and last character.
    If they are a match, do the same check for all the characters in the middle.
=end

  def pal_recur(s)
    #puts "pal_recur called"
    #puts "string s = #{s}"
    if s.length <= 1           
      return true
    else
      return (s[0] == s[-1] && pal_recur(s[1...-1]))     #non-inclusive range
    end
  end

  ### Puts statements for debugging... ###
  #puts "About to call functions"
  #puts "pal_recur(toChars(s)) = #{pal_recur(toChars(s))}"
  #

  return pal_recur(toChars(s))
  
end

# Your method should generate the following results:
palindrome? "abba"                             #=> true

palindrome? "aBbA"                             #=> true
palindrome? "abb"                              #=> false

palindrome? "Able was I ere I saw elba"        #=> true
palindrome? "A man, a plan, a canal, Panama"   #=> true
