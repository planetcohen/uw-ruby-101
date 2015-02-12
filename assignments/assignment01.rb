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

def starting_balance_method
  starting_balance = 0.00
end

def withdrawal_transactions
  File.open("csv.csv") do |file|
    lines = file.readlines
    separation_processes = lines.shift.chomp.split(",")
    withdrawals = []
    lines.each do |i|
      if i.include?("withdrawal")
        withdrawals << i
      end
    end
    return withdrawals
  end
end

def deposit_transactions
  File.open("csv.csv") do |file|
    lines = file.readlines
    separation_processes = lines.shift.chomp.split(",")
    deposits = []
    lines.each do |i|
      if i.include?("deposit")
        deposits << i
      end
    end
    return deposits
  end
end

def calculate_final_balance_after_all_transactions
  File.open("csv.csv") do |file|
    lines = file.readlines
    separation_processes = lines.shift.chomp.split(",")
    withdrawals = []
    deposits = []
    lines.each do |i|
      if i.include?("withdrawal")
	withdrawals << i
      else
	deposits << i
      end
    end
    deposit_manip = deposits.map {|i| i.split(",")}.flatten!
    deposit_txs =  deposit_manip.reject {|i| deposit_manip.index(i).odd?}
    deposit_sum = deposit_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}

    withdrawal_manip = withdrawals.map {|i| i.split(",")}.flatten!
    withdrawal_txs = withdrawal_manip.reject {|i| withdrawal_manip.index(i).odd?}
    withdrawal_sum = withdrawal_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}

    final_balance = deposit_sum - withdrawal_sum
    return "Your balance after all transactions is $#{final_balance.round(2)}"
  end
end

def date_to_julian(some_date)
#method that converts the date in the format (mm/dd/yyyy) into a julian date
#*DID NOT ACCOUNT FOR LEAP YEAR, SINCE 2014 IS NOT A LEAP YEAR*
  date_array = some_date.split("/")
  month = date_array[0].to_i
  day = date_array[1].to_i
  if month == 1
    julian_date = day
  elsif month == 2
    julian_date = 31 + day
  elsif month == 3
    julian_date = 59 + day
  elsif month == 4
    julian_date = 90 + day
  elsif month == 5
    julian_date = 120 + day
  elsif month == 6
    julian_date = 151 + day
  elsif month == 7
    julian_date = 181 + day
  elsif month == 8
    julian_date = 212 + day
  elsif month == 9
    julian_date = 243 + day
  elsif month == 10
    julian_date = 273 + day
  elsif month == 11
    julian_date = 304 + day
  elsif month == 12
    julian_date = 334 + day
  else
    puts "You did not enter a valid date"
    daily_balance_up_until_some_date
  end
  return julian_date	
end

def daily_balance_up_until_some_date
  puts "Please enter a date for which you would like to calculate your balance
  up until the end of that date, in the following format mm/dd/yyyy, or if the
  month or date is in the single digit, enter it in the following format
  m/d/yyyy and then hit ENTER:  " 
  end_date = gets.chomp
  date_to_julian(end_date)
  File.open("csv.csv") do |file|
    lines = file.readlines
    separation_processes = lines.shift.chomp.split(",")
    new_lines = lines.reject {|i| date_to_julian(i[0..9]) > date_to_julian(end_date)}
    withdrawals = []
    deposits = []
    new_lines.each do |i|
      if i.include?("withdrawal")
	withdrawals << i
      else
	deposits << i
      end
    end
    deposit_manip = deposits.map {|i| i.split(",")}.flatten!
    deposit_txs =  deposit_manip.reject {|i| deposit_manip.index(i).odd?}
    deposit_sum = deposit_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}

    withdrawal_manip = withdrawals.map {|i| i.split(",")}.flatten!
    withdrawal_txs = withdrawal_manip.reject {|i| withdrawal_manip.index(i).odd?}
    withdrawal_sum = withdrawal_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}

    final_balance_after_some_date = deposit_sum - withdrawal_sum
    return "Your balance after all transactions up to the end of the day on #{end_date} is $#{final_balance_after_some_date.round(2)}"
  end
end

def deposit_total_amount(some_deposits)
  deposit_manip = some_deposits.map {|i| i.split(",")}.flatten!
  deposit_txs =  deposit_manip.reject {|i| deposit_manip.index(i).odd?}
  deposit_sum = deposit_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}
  return deposit_sum.round(2)
end

def withdrawals_total_amount(some_withdrawals)
  withdrawal_manip = some_withdrawals.map {|i| i.split(",")}.flatten!
  withdrawal_txs = withdrawal_manip.reject {|i| withdrawal_manip.index(i).odd?}
  withdrawal_sum = withdrawal_txs.each_slice(2).inject(0) {|i, (j,k)| i += k.to_f}
  return withdrawal_sum.round(2)
end

def render_html
  <<-HTML
    <html>
      <head>
	<title>Bank Account Statement</title>
      </head>

    <body>
			
	<h5>List of Withdrawals</h5>
	#{withdrawal_transactions}

	<h5>List of Deposits</h5>
	#{deposit_transactions}

	<h5>Daily Balance</h5>
	#{daily_balance_up_until_some_date}

	<h3>Summary</h3>

	<h5>Starting Balance</h5>
	#{starting_balance_method}

	<h5>Sum of Deposits</h5>
	#{deposit_total_amount(deposit_transactions)}

	<h5>Sum of Withdrawals</h5>
	#{withdrawals_total_amount(withdrawal_transactions)}

	<h5>Ending Balance</h5>
	#{calculate_final_balance_after_all_transactions}

    </body>
  </html>
  HTML
end

def create_html_file(some_file)
  File.open("csv.csv", "w") do |file|
  file.write some_file
  end
end

create_html_file(render_html)

#----------------- END OF PROBLEM 4 & ASSINGMENT 2
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


#----------------------------------------------------- START OF ASSIGNMENT #4

#UW Ruby Assignment #4


#-------------------------------------------------------- Problem 1

def fibonacci(n)
  if n < 0
  	return "Can not calculate the Fibonacci sequence of a negative number."
  elsif n == 0 || n == 1
  	return 1
  else
  	fibonacci(n-1) + fibonacci(n-2)
  end
end

fibonacci(-2)
fibonacci(0)
fibonacci(1)
fibonacci(5)
fibonacci(4)
fibonacci(12)

#-------------------------------------------------------- Problem 2

class Queue
	class Node
		attr_accessor :item, :link
		def initialize(item, link)
			@item = item
			@link = link
		end
	end

	def initialize
		@nodes = nil
	end

	def enqueue(item)
		node = @nodes
		if node
			while node.link
				node = node.link
			end

			node.link = Node.new(item, nil)
		else
			@nodes = Node.new(item, nil)
		end
	end

	def dequeue
		node = @nodes
		if node.nil?
			@nodes = nil
		else
			@nodes = node.link
			node.item
		end
	end

	def empty?
		@nodes.nil?
	end

	def peek
		if @nodes.nil?
			nil
		else
			@nodes.item
		end
	end

	def length
		node = @nodes
		i = 0
		while node
			node = node.link
			i += 1
		end
	end
end

q = Queue.new
q.empty?
q.enqueue "first"
q.empty?
q.enqueue "second"
q.dequeue
q.dequeue
q.dequeue


#------------------------------------------------------- Problem 3

class LinkedList

	class Node
		attr_accessor :item, :link
		def initialize(item, link)
			@item = item
			@link = link
		end
	end

	def initialize
		@initialize = nil
		@end = @initialize
	end

	def empty?
		@initialize.nil?
	end

	def length
		new_length = 0
		node = @initialize
		while node
			new_length += 1
			node = node.link
		end
		new_length
	end

	def <<(item)
		if @initialize.nil?
			@initialize = Node.new(item, nil)
			@end = @initialize
		else
			node_finish = @end
			node_finish.link = Node.new(item, nil)
			@end = node_finish.link
		end
	end

	def delete(item)
		initial = nil
		node = @initialize

		if @initialize.item == item
			@initialize = @initialize.link
		else
			while node != item and node.item != item
				initial = node
				node = node.link
			end

			if node == item and @end.item == item
				@end = initial
				@end.link = nil
			elsif node
				initial.link = node.link
			else
				nil
			end
		end
	end

	def first
		@initialize.item
	end

	def last
		@end.item
	end

	def each(&block)
		node = @initialize
		while node do
			block.call node.item
			node = node.link
		end
	end
end

ll = LinkedList.new
ll.empty?
ll << "first"
ll.empty?
ll.length
ll.first
ll.last

ll << "second"
ll.length
ll.first
ll.last

ll << "third"
ll.each {|x| puts x}

ll.delete "second"
ll.length
ll.each {|x| puts x}


