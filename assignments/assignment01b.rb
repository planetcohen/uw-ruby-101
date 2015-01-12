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
puts titleize "hEllo WORLD"          #=> "Hello World"

puts titleize "gooDbye CRUel wORLD"  #=> "Goodbye Cruel World"