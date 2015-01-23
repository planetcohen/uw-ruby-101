# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)

  new_string = ""
  input = ary.insert(-2, "and")
  string = input.join(" ")
  new_string << string


  puts new_string
  
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
  
  mean = ary.inject(:+).to_f / ary.size

  puts mean

end

def median(ary)
  input = ary.sort
  half = (input.length - 1) / 2
  med = (input[half] + input[half.ceil]) / 2

  puts med
end

# Your method should generate the following results:
mean [1, 2, 3]    #=> 2.0
mean [1, 1, 4]    #=> 2.0

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
def pluck(ary, key)
  array = []

  ary.each { |h| array << h[key] }

  puts array

end

# Your method should generate the following results:
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


def transaction(date, payee, amount, type)
  {date: date, 
  payee: payee, 
  amount: amount, 
  type: type}
end

File.open("dataUW.csv") do |input|
  records = input.readlines.map do |line|
    fields = line.split ","
    transaction fields[0], fields[1], fields[2], fields[3]
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
    <td>#{r[:type]}</td>
  </tr>
RECORD
end