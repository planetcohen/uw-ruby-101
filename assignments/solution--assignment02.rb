# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  if ary.length == 0
    "" if ary.empty?
  elsif ary.length == 1
    ary[0]
  else
    a = ary.pop
    str = ary.join(", ") + " and #{a}"
  end
end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"
to_sentence [1, "paul", 3, "ringo", "gordon"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary)
  sum = ary.inject {|sum, num| sum += num}
  sum / ary.length.to_f
end

def median(ary)
  if ary.length % 2 != 0
    ary[ary.length/2]
  else
    p = ary.length/2
    ((ary[p-1] + ary[p]) / 2.0)
  end
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
  ary.each {|item| array << item[key]}
  array
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

file = File.open("assignment02-input.csv", "r")

def sorting(file)
  arr = [], arr2 = []
  file.each do |item|
    arr << item.split(",")
  end
  arr.each {|i| i.insert(0, i[0].to_s.split("/")[1]); i[0] = i[0].to_i}
  3.times {arr.shift}; arr = arr.sort; get_file(arr)
end

def get_file(file)
  output = File.open("monthly_statement.html", "w")
  total_withdrawals = 0; file.each {|item| total_withdrawals += item[3].to_f if item[4].include?("withdrawal")}
  total_deposits = 0; file.each {|item| total_deposits += item[3].to_f if item[4].include?("deposit")}
  balance = 0

  ###### WRITING TO HTML ############################
  ###################################################
  output.puts <<-RECORDS
  <html>
    <head>
      <title>Bank Statement</title>
      <style>
        h1,h2,h3,th,td, p {font-family: arial}
        h3 {font-size: 16px}
        body {font-size:12px}
        td {padding:6px 16px}
        th {text-align:rignt; padding: 8px 16px}
        td {text-align:right}
        table, th, td {
          border: 1px solid #ccc;
          border-collapse: collapse;
        }
      </style>
    </head>
    <body>
      <h1> BANK STATEMENT </h1>
      <table>
  RECORDS
  output.puts "<tr><th>Date</th><th>Deposits</th><th>Withdrawals</th><th>Balance</th></tr>"
  file.each do |item|
    if item[4].include?("withdrawal")
      balance -= item[3].to_f
      output.puts "<tr><td>#{item[1]}</td> <td> _ </td><td>$#{item[3]}</td><td>$#{(balance * 100).round/100.0}</td></tr>"
    else
      balance += item[3].to_f
      output.puts "<tr><td>#{item[1]}</td> <td>$#{item[3]}</td><td> _ </td><td>$#{(balance * 100).round/100.0}</td></tr>"
    end
  end
  output.puts "<tr><td><strong>Total</strong></td> <td><strong>$#{(total_deposits * 100).round/100.0}</strong></strong></td><td><strong>$#{(total_withdrawals * 100).round/100.0}</strong></td><td><strong>$#{(balance * 100).round/100.0}</strong></td></tr>"
  output.puts <<-ENDHTML
  </table>
  </body>
  </html>
  ENDHTML
  ###################################################
end
sorting(file)


