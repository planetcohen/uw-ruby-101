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
puts palindrome? "abba"                             #=> true
puts palindrome? "aBbA"                             #=> true
puts palindrome? "abb"                              #=> false

puts palindrome? "Able was I ere I saw elba"        #=> true
puts palindrome? "A man, a plan, a canal, Panama"   #=> true
