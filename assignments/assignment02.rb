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
<<<<<<< HEAD

### Making incremental progress here, will continue to iterate.  Would very much like to 
### review the recording of lecture #2!

def transaction_hash (date, payee, amount, type)
  {date: date, payee: payee, amount: amount, type: type}
end

raw_statement = File.open("assignment02-input.csv", "r") do |input|
  transactions = input.readlines.map do |line|
    fields = line.split(",")
    transaction_hash fields[0], fields[1], fields[2], fields[3], fields[4]
||||||| merged common ancestors
def bank_statement
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
  
  def txs_totals(txs, starting_balance)
    withdrawals = txs.select {|tx| tx[:type] == "withdrawal"}.sort {|a,b| a[:formatted_date] <=> b[:formatted_date]}
    sum_withdrawals = withdrawals.reduce(0) {|acc, tx| puts "tx => #{tx}, acc => #{acc}"; acc += tx[:amount]}

    deposits = txs.select {|tx| tx[:type] == "deposit"}.sort {|a,b| a[:formatted_date] <=> b[:formatted_date]}
    sum_deposits = deposits.reduce(0) {|acc, tx| puts "tx => #{tx}, acc => #{acc}"; acc += tx[:amount]}

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
=======
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
>>>>>>> upstream/master
  end
<<<<<<< HEAD
end

withdrawals = raw_statement.select {|h| h[:type] == "withdrawal"}
withdrawals.sort_by! {|x| x[:date]}

deposits = raw_statement.select {|h| h[:type] == "deposit"}
deposits.sort_by! {|x| x[:date]}

def daily_balance(raw_statement)
  days = raw_statement.map {|d| d[:date]}.uniq
  daily_transactions = days.reduce({}) do |day, acc|
  	acc[day] = raw_statement.select {|d| d[:date] == day}
||||||| merged common ancestors
  
  def write_html(html)
    File.open("assignment02-output.html", "w") do |file|
      file.write html
    end
=======
  
  # ------------------------------------------------------------------------
  # write html to file:
  def write_html(html)
    File.open("assignment02-output.html", "w") do |file|
      file.write html
    end
>>>>>>> upstream/master
  end

  
<<<<<<< HEAD
||||||| merged common ancestors
  txs = read_txs
  statement = calc_statement txs
  html = render_html statement
  write_html html
  nil
=======
  # ------------------------------------------------------------------------
  txs = read_txs
  statement = calc_statement txs
  html = render_html statement
  write_html html
  nil
>>>>>>> upstream/master
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


















