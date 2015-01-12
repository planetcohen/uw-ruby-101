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
puts my_reverse "Hello World"          #=> "dlroW olleH"

puts my_reverse "Goodbye Cruel World"  #=> "dlroW leurC eybdooG"
