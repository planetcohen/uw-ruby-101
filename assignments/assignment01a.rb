#  Sample Problem - `number_to_string`
def number_to_string(n, lang)
  lang_digit_strings = {
    en: %w(zero one two three four five six seven eight nine),
    de: %w(null eins zwei drei vier feunf sechs sieben acht neun),
    es: %w(cero uno dos tres cuatro cinco seis siete ocho nueve),
    fr: %w(zero un deux trois quatre cinq six sept huit neuf)
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

# test
puts "test01"
puts "given: 123"
puts "desired result: 'one two three'"
puts "actual result:"
puts number_to_string(123, :en)

if (number_to_string(123, :en) == "one two three")
  puts "Test 01 pass"
else
  puts "Test 01 fail"
end

puts "test02"
puts "given: 246"
puts "desired result: 'two four six'"
puts "actual result:"
puts number_to_string(246, :en)

if (number_to_string(246, :en) == "two four six")
  puts "Test 02 pass"
else
  puts "Test 02 fail"
end

gets