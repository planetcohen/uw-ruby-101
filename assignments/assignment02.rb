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
def to_sentence(ary)
  if ary.length == 0
    []
  elsif ary.length == 1
    ary[0]
  else
    last = ary.pop
    "#{ary.join(", ")} and #{last}"
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
  sum = ary.reduce(0) {|x, acc| acc + x}
  sum.to_f / ary.length
end

def median(ary)
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
  ary.map {|item| item[key]}
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

def bank_statement
  
  # ------------------------------------------------------------------------
  # formatting helpers:
  def format_currency(amount)
    prefix = if amount < 0
      amount = -amount
      "-"
    end
    s = amount.to_s
    if amount < 10
      cents = "0#{s}"
      dollars = "0"
    elsif amount < 100
      cents = s
      dollars = "0"
    else
      cents = s[-2, 2]
      dollars = s[0, s.length-2]
      if dollars.length > 3
        lower = dollars[-3, 3]
        upper = dollars[0, dollars.length-3]
        dollars = "#{upper},#{lower}"
      end
    end
    "$ #{prefix}#{dollars}.#{cents}"
  end
  
  def format_date(date)
    month_string = date[:month] < 10 ? "0#{date[:month]}" : date[:month].to_s
    day_string   = date[:day] < 10 ? "0#{date[:day]}" : date[:day].to_s
    "#{month_string}/#{day_string}/#{date[:year]}"
  end
  
  # ------------------------------------------------------------------------
  # rendering:
  def render_html(statement)
    <<-HTML
      <html>
        <head>
          <title>Bank Statement</title>
          <style>
          h1,h2,th,td {font-family: Helvetica}
          th,td {padding:4px 16px}
          th {text-align:left}
          td {text-align:right}
          </style>
        </head>
        #{render_body statement}
      </html>
    HTML
  end
  
  def render_body(statement)
    <<-BODY
      <body>
        <h1>Bank Statement</h1>
        #{render_summary statement[:summary]}
        #{render_txs statement[:withdrawals], "Withdrawals"}
        #{render_txs statement[:deposits], "Deposits"}
        #{render_daily_balances statement[:dates], statement[:daily_balances]}
      </body>
    BODY
  end
  
  def render_summary(summary)
    <<-SUMMARY
      <h2>Summary</h2>
      <table>
        <tr><th>Starting Balance</th> <td>#{format_currency summary[:starting_balance]}</td></tr>
        <tr><th>Total Deposits</th>   <td>#{format_currency summary[:sum_deposits]}</td></tr>
        <tr><th>Total Withdrawals</th><td>#{format_currency summary[:sum_withdrawals]}</td></tr>
        <tr><th>Ending Balance</th>   <td>#{format_currency summary[:ending_balance]}</td></tr>
      </table>
    SUMMARY
  end
  
  def render_tx(tx)
    <<-TX
      <tr>
        <th>#{tx[:formatted_date]}</th>
        <th>#{tx[:payee]}</th>
        <td>#{format_currency tx[:amount]}</td>
      </tr>
    TX
  end
  
  def render_txs(txs, label)
    <<-TXS
      <h2>#{label}</h2>
      <table>
        #{txs.map {|tx| render_tx tx}.join "\n"}
      </table>
    TXS
  end
  
  def render_daily_balance(date, balance)
    <<-TXS
      <tr>
        <th>#{date}</th>
        <td>#{format_currency balance[:summary][:ending_balance]}</td>
      </tr>
    TXS
  end
  
  def render_daily_balances(dates, balances)
    <<-BALANCES
      <h2>Daily Balances</h2>
      <table>
        #{dates.map {|date| render_daily_balance date, balances[date]}.join "\n"}
      </table>
    BALANCES
  end
  
  # ------------------------------------------------------------------------
  # read csv file, generate txs:
  def read_txs
    File.open("assignment02-input.csv") do |file|
      lines = file.readlines

      keys = lines.shift.chomp.split(",").map {|key| key.to_sym}

      lines.map do |line|
        tx = {}
        line.chomp.split(",").each_with_index do |field, index|
          key = keys[index]
          tx[key] = field
        end
        tx
      end.map do |tx|
        tx[:amount] = (tx[:amount].to_f * 100).to_i
        month, day, year = tx[:date].split "/"
        date = {year: year.to_i, month: month.to_i, day: day.to_i}
        tx[:date] = date
        tx[:formatted_date] = format_date date
        tx
      end.sort {|a,b| a[:formatted_date] <=> b[:formatted_date]}
    end
  end
  
  # ------------------------------------------------------------------------
  # calc totals for collection of txs:
  def txs_totals(txs, starting_balance)
    withdrawals = txs.select {|tx| tx[:type] == "withdrawal"}.sort {|a,b| a[:formatted_date] <=> b[:formatted_date]}
    sum_withdrawals = withdrawals.reduce(0) {|acc, tx| acc += tx[:amount]}

    deposits = txs.select {|tx| tx[:type] == "deposit"}.sort {|a,b| a[:formatted_date] <=> b[:formatted_date]}
    sum_deposits = deposits.reduce(0) {|acc, tx| acc += tx[:amount]}

    ending_balance = starting_balance + sum_deposits - sum_withdrawals
    
    {
      summary: {
        starting_balance: starting_balance,
        sum_deposits: sum_deposits,
        sum_withdrawals: sum_withdrawals,
        ending_balance: ending_balance
      },
      withdrawals: withdrawals,
      deposits: deposits
    }
  end
  
  # ------------------------------------------------------------------------
  # calc statement from txs:
  def calc_statement(txs)
    statement = txs_totals txs, 0

    dates = txs.map {|tx| tx[:formatted_date]}.uniq.sort

    daily_balances = {}
    dates.each_with_index do |date, index|
      txs_for_date = txs.select {|tx| tx[:formatted_date] == date}
      starting_balance = if index == 0
        # first day, so use starting balance:
        statement[:summary][:starting_balance]
      else
        # use ending balance of previous date:
        prev_date = dates[index-1]
        daily_balances[prev_date][:summary][:ending_balance]
      end
      daily_balances[date] = txs_totals txs_for_date, starting_balance
    end
    statement[:dates] = dates
    statement[:daily_balances] = daily_balances
    statement
  end
  
  # ------------------------------------------------------------------------
  # write html to file:
  def write_html(html)
    File.open("assignment02-output.html", "w") do |file|
      file.write html
    end
  end
  
  # ------------------------------------------------------------------------
  txs = read_txs
  statement = calc_statement txs
  html = render_html statement
  write_html html
  nil
end
