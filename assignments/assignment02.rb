# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
<<<<<<< HEAD
  # pull all but the last element from the input array, join them with commas
  my_sentence = ary[0...-1].reduce {|word, acc| word.to_s + ", #{acc}"}
  
  # make a new array that is the sentence string and the last element in the input array
  and_last = [my_sentence, ary[-1]]
  
  # compact to handle NA values for 1 or 0 word inputs
  and_last.compact!
  
  # adding 'and' to the last element in the sentence but with a bonus oxford comma
  and_last.join ", and "
||||||| merged common ancestors
  # your implementation here
=======
  if ary.length == 0
    []
  elsif ary.length == 1
    ary[0]
  else
    last = ary.pop
    "#{ary.join(", ")} and #{last}"
  end
>>>>>>> upstream/master
end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary)
<<<<<<< HEAD
  # add all the numbers together
  sum = ary.reduce {|i, acc| i + acc }

  # divide by the length, convert to floating point
  mean = sum/ary.length.to_f
  return mean
||||||| merged common ancestors
  # your implementation here
=======
  sum = ary.reduce(0) {|x, acc| acc + x}
  sum.to_f / ary.length
>>>>>>> upstream/master
end

def median(ary)
<<<<<<< HEAD
  # find the length of the array 
  len = ary.length
  
  # sort the array
  ary.sort!

  # if it's odd, return the middle number
  if len % 2 == 1
    median = ary[len/2]

  # if it's even, average the two in the middle
  else
    median = (ary[len/2].to_f + ary[-1 + len/2].to_f) / 2 
  end
  return median
||||||| merged common ancestors
  # your implementation here
=======
  sorted_ary = ary.sort
  len = sorted_ary.length
  mid_index = len/2
  if len.odd?
    sorted_ary[mid_index]
  else
    mid_lo = sorted_ary[mid_index]
    mid_hi = sorted_ary[mid_index+1]
    (mid_lo + mid_hi)/2.0
  end
>>>>>>> upstream/master
end

# Your method should generate the following results:
mean [1, 2, 3]    #=> 2.0
mean [1, 1, 4]    #=> 2.0

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
<<<<<<< HEAD
def pluck(ary)
  # initialize an empty array
  result = []

  # iterate over each hash in the input array
  ary.each do |hash|
  	result << hash[key]
  end
  return result
||||||| merged common ancestors
def pluck(ary)
  # your implementation here
=======
def pluck(ary, key)
  ary.map {|item| item[key]}
>>>>>>> upstream/master
end

# Your method should generate the following results:
records = [
  {:name => "John",   :instrument => "guitar"},
  {:name => "Paul",   :instrument => "bass"  },
  {:name => "George", :instrument => "guitar"},
  {:name => "Ringo",  :instrument => "drums" }
]
pluck records, :name        #=> ["John", "Paul", "George", "Ringo"]
pluck records, :instrument  #=> ["guitar", "bass", "guitar", "drums"]

# ========================================================================================
# ========================================================================================
#  Problem 4 - monthly bank statement

# given a CSV file with bank transactions for a single account (see assignment02-input.csv)
# generate an HTML file with a monthly statement

# assume starting balance is $0.00

# the monthly statement should include the following sections:
# - withdrawals
# - deposits
# - daily balance
# - summary:
#   - starting balance, total deposits, total withdrawals, ending balance

### Making incremental progress here, will continue to iterate.  Would very much like to 
### review the recording of lecture #2!

def transaction_hash (date, payee, amount, type)
  {date: date, payee: payee, amount: amount, type: type}
end

raw_statement = File.open("assignment02-input.csv", "r") do |input|
  transactions = input.readlines.map do |line|
    fields = line.split(",")
    transaction_hash fields[0], fields[1], fields[2], fields[3], fields[4]
  end
end

withdrawals = raw_statement.select {|h| h[:type] == "withdrawal"}
withdrawals.sort_by! {|x| x[:date]}

deposits = raw_statement.select {|h| h[:type] == "deposit"}
deposits.sort_by! {|x| x[:date]}

def daily_balance(raw_statement)
  days = raw_statement.map {|d| d[:date]}.uniq
  daily_transactions = days.reduce({}) do |day, acc|
  	acc[day] = raw_statement.select {|d| d[:date] == day}
  end

  
end

def render_html(title, records)
<<HTML
 <!doctype html>
 <html>
 #{render_head title}
 #{render_body title, records}
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

def render_record(r)
<<RECORD
 <tr>
 <td>#{r[:date]}</td>
 <td>#{r[:payee]}</td>
 <td>#{r[:amount]}</td>
 <td>#{r[:type]
 </tr>
RECORD
end


















