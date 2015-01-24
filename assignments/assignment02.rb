# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  if ary.length == 0
  	return ""
  elsif ary.length == 1
  	return "#{ary[0]}"
  elsif ary.length == 2
  	return "#{ary[0]} and #{ary[1]}"
  else
  	result_string = ""
  	chars_added = 0
  	ary.each do |i|
  	  if chars_added == 0
  	  	result_string << "#{i}"
  	  elsif chars_added >= ary.length-1
  	  	result_string << " and #{i}"
  	  else
  	  	result_string << ", #{i}"
  	  end
  	  chars_added += 1
  	end
  	return result_string
  end
end

# Test cases:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary)
  ary_sum = 0.0    #ensure decimal is not concatenated upon division in return statement
  ary.each do |i|
  	ary_sum += i
  end
  return ary_sum/ary.count
end

def median(ary)
  ary_sorted = ary.sort
  if ary_sorted.length.odd?
  	median = ary_sorted[ary_sorted.length/2]  #decimal (.5) in the quotient is truncated
  else
  	median = ary_sorted[ary_sorted.length/2 -1]
  end
  return median
end

# Test cases:
mean [1, 2, 3]    #=> 2.0
mean [1, 1, 4]    #=> 2.0

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
def pluck(ary, key)
	ary.map { |hash| hash[key] }
end

# Test cases:
records = [
  {name: "John",   instrument: "guitar"},
  {name: "Paul",   instrument: "bass"  },
  {name: "George", instrument: "guitar"},
  {name: "Ringo",  instrument: "drums" }
]
pluck records, :name        #=> ["John", "Paul", "George", "Ringo"]
pluck records, :instrument  #=> ["guitar", "bass", "guitar", "drums"]


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

def create_transaction(date, payee, amount, type)
  {date: date, payee: payee, amount: amount, type: type}
end


transaction_records = {}
file_path = "/Users/tim/Developer/UW\ Ruby\ Certificate\ Program/Ruby\ 110/assignment02-input.csv"
File.open(file_path) do |input|
  records = input.readlines.map do |line|
    fields = line.split ","
    transaction = create_transaction fields[0], fields[1], fields[2], fields[3]
  end
 transaction_records = records
 input.close
end



def render_html(title, records)
<<HTML
  <!doctype html>
  	<html>
      #{render_head title}
      #{render_body title, records[1..-1]}  #omit first line of transaction_records, which is {date: 'date', payee: 'payee'..etc.}
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
    <th>Date</th>
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
