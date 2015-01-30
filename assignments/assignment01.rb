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
  a = s.split(" ")
  b = a.map {|x| x.upcase[0]+x[1..-1].downcase}
  puts b.join(" ")
end

# Your method should generate the following results:
titleize("hEllo WORLD")          #=> "Hello World"

titleize("gooDbye CRUel wORLD")  #=> "Goodbye Cruel World"
puts "---END OF PROBLEM 1---"
puts ""


# ========================================================================================
#  Problem 2 - `my_reverse`

# Write your own implementation of `reverse` called `my_reverse`
# You may *not* use the built-in `reverse` method
def my_reverse(s)
  index = s.length 
  array = []
  s.length.times do index -= 1
    array << s[index]
    if array.length == s.length
      puts array.join
    end
  end
end

# Your method should generate the following results:
my_reverse("Hello World")          #=> "dlroW olleH"

my_reverse("Goodbye Cruel World")  #=> "dlroW leurC eybdooG"
puts "---END OF PROBLEM 2---"
puts ""

# ========================================================================================
#  Problem 3 - `palindrome?`

# Write a method `palindrome?`
# that determines whether a string is a palindrome
def palindrome?(s)
  g = s.gsub(/\W+/, "")
  f = g.downcase
  if f.reverse == f
    puts "true"
  else
    puts "false"
  end
end

# Your method should generate the following results:
palindrome?("abba")                             #=> true
palindrome?("aBbA")                             #=> true
palindrome?("abb")                             #=> false

palindrome?("Able was I ere I saw elba")       #=> true
palindrome?("A man, a plan, a canal, Panama")   #=> true
puts "---END OF PROBLEM 3---"

#----------------------------------------------------------------

puts "---START OF HOMEWORK 2---"
puts ""

def to_sentence(array)
  if array.length == 1
    puts array
  elsif array.length > 1
    last_element = []
    last_element << array.pop
    p = array.flatten.join(", ")
    puts p+" and "+last_element[0].to_s
  end
end

to_sentence([])
to_sentence(["john"])
to_sentence(["john", "paul"])
to_sentence([1, "paul", 3, "ringo"])
puts "---END OF PROBLEM 1---"

def mean(array)
  sum = 0
  array.each {|i| sum += i}
  the_mean = sum/array.length.to_i
  puts the_mean.to_f
end

def median(array)
  ordered_array = array.sort
  number_of_elements = array.length
  if array.length % 2 != 0
    median_pos = number_of_elements.to_i/2
    puts ordered_array[median_pos].to_f
  else array.length % 2 == 0
    median1 = ordered_array[array.length.to_i/2]
    median2 = ordered_array[array.length.to_i/2-1]
    puts (median1.to_f+median2.to_f)/2
  end
end

mean([1, 2, 3])
mean([1, 1, 4])
puts ""

median([1, 2, 3])
median([1, 1, 4])
puts "---END OF PROBLEM 2---"

def pluck(hash, target)
  number = 0
  if target == :name
    number = 0
  elsif target == :instrument
    number = 1
  end
  hash.each do |i|
    vals = i.values[number]
    output = []
    output<<vals
    puts output
  end
end

records = [{name: "John", instrument: "guitar"},
{name: "Paul", instrument: "bass"},
{name: "George", instrument: "guitar"},
{name: "Ringo", instrument: "drums"}]

pluck(records, :name)
puts ""
pluck(records, :instrument)
puts "---END OF PROBLEM 3---"

def create_transaction(date, payee, amount, type)
  {date: date, payee: payee, amount: amount, type: type}
end

transaction_records = {}
file_path = "/Users/hotero001/Documents/UW_ROR/assignment02-input.csv"
File.open(file_path) do |input|
  records = input.readlines.map do |line|
    fields = line.split(",")
    transaction = create_transaction(fields[0], fields[1], fields[2], fields[3])
  end
  transaction_records = records
  input.close
end

def render_html(title, records)
  <<HTML
    <!doctype html>
      <html>
      #{render_head title}
      #{render_body title, records[1..-1]} #omit first line of transaction_records, which is {date: 'date', payee: 'payee'..etc.}
      </html>
  HTML
end

def render_head(title)
  <<HEAD
    <head>
      <title>#{title}</title>
    </head>
  HEAD
end

def render_body(title, records)
  <<BODY
    <body>
      <h1>#{title}</h1>
      #{render_records records}
    </body>
  BODY
end

def render_records(records)
  <<RECORDS
    <table>
      #{render_table_header}
      #{records.map {|r| render_record r}.join "\n"}
    </table>
  RECORDS
end

def render_table_header
  <<TABLE_HEADER
    <thead>
      <th>DATE</th>
      <th>Payee</th>
      <th>Amount</th>
      <th>Type</th>
    </thead>
  TABLE_HEADER
end

def render_record(r)
  <<RECORD
    <tr>
      <td>#{r[:date]}</td>
      <td>#{r[:payee]}</td>
      <td>#{r[:amount]}</td>
      <td>#{r[:type]}</td>
    </tr>
  RECORD
end




#----------------- BEGINNING OF ASSIGNMENT 3

class String
  def titleize
    new_string = self.split(/\W+/)
    new_string.map {|i| i.capitalize}.join(" ")
  end
end

"hEllo WORld".titleize
"gooDbye CRuel wORLD".titleize

class String
  def palindrome?
    letters_only = self.gsub(/\W+/, "")
    letters_only_downcase = letters_only.downcase
    if letters_only_downcase == letters_only_downcase.reverse
      return "true"
    else
      return "false"
    end
  end
end

"abba".palindrome?
"aBbA".palindrome?
"A man, a plan, a canal, Panama".palindrome?
"abb".palindrome?
"Able was I ere I saw elba".palindrome?
"A man, a plan, a canal, Panama".palindrome?

class Array
  def mean 
    sum = 0
    self.each {|n| sum += n}
    the_mean = sum/self.length.to_f
    return the_mean.to_f
  end

  def median
    ordered_array = self.sort
    number_of_elements = self.length
    if number_of_elements % 2 != 0
      median_position = number_of_elements.to_i/2
      return ordered_array[median_position].to_f
    else number_of_elements % 2 == 0
      median1 = ordered_array[self.length.to_i/2]
      median2 = ordered_array[self.length.to_i/2-1]
      return (median1.to_f+median2.to_f)/2
    end
  end
end

[1,2,5,6].mean
[1,1,4].mean
[1,2,3].median
[1,1,4].median

class Array
  def to_sentence
    if self.length == 1
      return self
    elsif self.length > 1
      last_element = []
      last_element << self.pop
      join_elements = self.flatten.join(", ")
      return join_elements+" and "+last_element[0].to_s
    end
  end
end

[].to_sentence
["john"].to_sentence
["john", "paul"].to_sentence
[1, "paul", 3, "ringo"].to_sentence

#------START OF BANK ACCOUNT STATEMENT

class BankAccount
  attr_accessor :starting_balance
end

class Transaction
end

class DepositTransaction << Transaction
end

class WithdrawalTransaction << Transaction
end

