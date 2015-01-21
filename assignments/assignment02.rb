# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary, punctuate=false) # Optionally capitalizes the 1st word & appends a period (just for fun...)
  new_string = ""
  last_index = ary.length - 1
  ary.each_with_index do |word, index|
    if index == last_index
      new_string << word.to_s
    elsif index == ( last_index - 1 )
      new_string << word.to_s << " and "
    else
      new_string << word.to_s << ", "
    end
  end
  if punctuate
    return new_string.capitalize << "."
  else
    return new_string
  end
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
  ary.inject(:+) / ary.length.to_f
end

def median(ary)
  # If there are two middle numbers, they must be averaged
  if ary.length % 2 == 0
    sorted_array = ary.sort
    last_index = sorted_array.length - 1
    middle_index_1 = sorted_array.length / 2
    middle_index_2 = ( last_index / 2 ).floor
    average_of_middles = ( sorted_array[middle_index_1].to_f + sorted_array[middle_index_2].to_f ) / 2
    # No need to return a float if it's really just an integer...
    if ( average_of_middles % 1 ) == 0
      return average_of_middles.to_i
    else
      return average_of_middles
    end
  else # If there is one middle number, just do the simplest thing
    return ary.sort[ary.length / 2]
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

  new_array = Array.new

  ary.each do |hash|
    new_array << hash[key]
  end

  return new_array

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

def html_header(title="Your Bank Statement as of #{Time.now}")
  <<-EOM
<!DOCTYPE HTML>
<html>
<head>
<title>#{title}</title>
</head>
<body>
<h1>#{title}</h1>
  EOM
end

def html_footer
  <<-EOM
</body>
</html>
  EOM
end

def html_summary(starting_balance, total_deposits, total_withdrawals, end_balance)
  <<-EOM
<h2>Account Summary:</h2>
<hr>
<table>
<tr><td>Starting Balance:</td><td align=right>$#{starting_balance}</td></tr>
<tr><td>Total Deposits:</td><td align=right>#{total_deposits}</td></tr>
<tr><td>Total Withdrawals:</td><td align=right>#{total_withdrawals}</td></tr>
<tr><td>Ending Balance:</td><td align=right>$#{end_balance}</td></tr>
</table>
  EOM
end

def html_transaction(date, source, amount)
  amount < 0 ? color = "red" : color = "black"
  <<-EOM
<tr><td>#{date}</td><td><i>#{source}</i></td><td align=right><font color=#{color}>$#{amount}</font></td><td></td></tr>
  EOM
end

def html_table_header(title)
  <<-EOM
<h2>#{title}</h2>
<hr>
<table>
<tr>
<td align=left valign=bottom><b>Date</b></td>
<td align=left valign=bottom><b>Source</b></td>
<td align=right valign=bottom><b>Amount</b>
</tr>
  EOM
end

def html_daily_header
  <<-EOM
<h2>Daily Transactions with Balances:</h2>
<hr>
<table>
<tr>
<td align=left valign=bottom><b>Date</b></td>
<td align=left valign=bottom><b>Source</b></td>
<td align=right valign=bottom><b>Amount</b>
</td><td align=right valign=bottom><b>Daily<br>Balance</b></td>
</tr>
  EOM
end

def html_table_footer
  <<-EOM
</table>
  EOM
end

def html_daily_total(amount)
  amount < 0 ? color = "red" : color = "black"
  <<-EOM
<tr><td colspan=3></td><td align=right><b><font color=#{color}>$#{amount}</font></b></td></tr>
  EOM
end


starting_balance = 0

fh = File.open("assignment02-input.csv")
csv_data = fh.read()
fh.close

column_headers = Array.new
transactions = Hash.new

csv_data.each_line.map do |line|
    entry = line.split(",")
    if entry[0].include?("date")
      # These are headers
      column_headers = entry
    else
      # This is data
      month, day, year = entry[0].split("/")
      month = month.to_s.rjust(2, "0")
      day = day.to_s.rjust(2, "0")
      key = "#{year}-#{month}-#{day}"
      source = entry[1]
      entry[3].include?("withdrawal") ? amount = entry[2].to_f * -1 : amount = entry[2].to_f
      transactions[key] = [] if transactions[key].nil?
      transactions[key] << [ source, amount ]
    end
end

transactions = transactions.sort

puts html_header

running_balance = starting_balance

total_deposits = 0
total_withdrawals = 0

# - withdrawals
puts html_table_header("List of Withdrawals:")
transactions.each do |key, value|
  year, month, day = key.split("-")
  value.each do |transaction|
    source = transaction[0]
    amount = transaction[1]
    puts html_transaction("#{month}/#{day}/#{year}", source, amount) if  amount < 0
  end
end
puts html_table_footer

# - deposits
puts html_table_header("List of Deposits:")
transactions.each do |key, value|
  year, month, day = key.split("-")
  value.each do |transaction|
    source = transaction[0]
    amount = transaction[1]
    puts html_transaction("#{month}/#{day}/#{year}", source, amount) if amount >= 0
  end
end
puts html_table_footer

# - daily balance
puts html_daily_header
transactions.each do |key, value|
  year, month, day = key.split("-")
  value.each do |transaction|
    source = transaction[0]
    amount = transaction[1]
    if amount < 0
      total_withdrawals += 1
    else
      total_deposits += 1
    end
    running_balance += amount
    puts html_transaction("#{month}/#{day}/#{year}", source, amount)
  end
  puts html_daily_total(running_balance)
end
puts html_table_footer

# - summary
puts html_summary(starting_balance, total_deposits, total_withdrawals, running_balance)
puts html_footer

