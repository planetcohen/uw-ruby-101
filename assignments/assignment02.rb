# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  # your implementation here
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
  # your implementation here
end

def median(ary)
  # your implementation here
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
  # your implementation here
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
require 'date'

STARTING_BALANCE = 0.0
INPUT_FILE_NAME = "assignment02-input-test.csv"
OUTPUT_FILE_NAME = "Monthly_Statement.html"

# create a hash for each transaction
def create_transaction(trans_date, payee, amount, trans_type)
  {trans_date: Date.strptime(trans_date, "%m/%d/%Y"), payee: payee, amount: amount.to_f, trans_type: trans_type.delete("\n")}
end

# read contents of file into array
def load_transaction_file(file_name)
  arr_transactions = []
  File.open(file_name, "r") do |input|
    input.readline
    records = input.readlines.map do |line|
      fields = line.split ","
      some_transaction = create_transaction fields[0], fields[1], fields[2].to_f, fields[3]
      arr_transactions << some_transaction
    end
    input.close
  end
  arr_transactions
end

# get all transactions of given type
def get_trans_of_type(arr_transactions, str_trans_type)
  arr_transactions.select {|transaction| transaction[:trans_type] == str_trans_type}
end

# get all transactions of given date
def get_trans_on_date(arr_transactions, date)
  arr_transactions.select {|transaction| transaction[:trans_date] == date}
end

# get all unique dates
def get_dates(arr_transactions)
  arr_dates = []
  arr_transactions.each do |transaction|
    arr_dates << transaction[:trans_date]
  end
  arr_dates.uniq
end

# get sum of amounts
def get_sum_amount(arr_transactions)
  arr_transactions.reduce(0) {|flt_sum, transaction| flt_sum + transaction[:amount]}
end

# get balance for a given date and starting balance
def get_balance_date(arr_transactions, date, balance)
  x = get_trans_on_date(arr_transactions, date)
  sum_deposits = get_sum_amount(get_trans_of_type(x, "deposit"))
  sum_withdrawals = get_sum_amount(get_trans_of_type(x, "withdrawal"))
  balance + sum_deposits - sum_withdrawals
end

# create a hash for date balance
def create_daily_balance(trans_date, amount)
  {trans_date: trans_date, amount: amount}
end

# calculation

flt_starting_balance = STARTING_BALANCE
x = load_transaction_file(INPUT_FILE_NAME)
arr_transactions = x.sort {|x,y| x[:trans_date] <=> y[:trans_date]}

arr_all_withdrawals = get_trans_of_type(arr_transactions, "withdrawal")
flt_total_withdrawals = get_sum_amount(arr_all_withdrawals)

arr_all_deposits = get_trans_of_type(arr_transactions, "deposit")
flt_total_deposits = get_sum_amount(arr_all_deposits)

arr_daily_balance = []
current_balance = flt_starting_balance
get_dates(arr_transactions).each do |date|
  current_balance = get_balance_date(arr_transactions, date, current_balance)
  arr_daily_balance << create_daily_balance(date, current_balance)
end

flt_ending_balance = flt_starting_balance + flt_total_deposits - flt_total_withdrawals

# presentation

def save_statement_output(str_output, output_file_name)
  File.open(output_file_name, "w+") do |output|
    output.print str_output
    output.close
  end
end

def render_transaction(t)
  <<RECORD
    <tr>
      <td>#{t[:trans_date]}</td>
      <td>#{t[:payee]}</td>
      <td>$#{(t[:amount] * 100).round/100.0}</td>
      <td>#{t[:trans_type]}</td>
    </tr>
RECORD
end

def render_transactions(arr_transactions)
  <<TRANSACTIONS
    <table>
      <tr><td>Date:</td><td>Payee:</td><td>Amount:</td><td>Type:</td></tr>
      #{arr_transactions.map {|r| render_transaction r}.join "\n"}
    </table>
TRANSACTIONS
end

def render_daily_balance(b)
  <<BALANCE
      <tr><td>#{b[:trans_date]}</td><td>$#{(b[:amount] * 100).round/100.0}</td></tr>
BALANCE
end

def render_daily_balances(arr_daily_balance)
  <<BALANCES
    <table>
      <tr><td>Date:</td><td>Amount:</td></tr>
      #{arr_daily_balance.map {|r| render_daily_balance r}.join "\n"}
    </table>
BALANCES
end

def render_summary_transaction(str_title, flt_amount)
  <<TRANSACTION
    <tr><td>#{str_title}</td><td>$#{flt_amount.to_s}</td></tr>\n
TRANSACTION
end

def render_summary(flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance)
  <<SUMMARY
    <table>
      #{render_summary_transaction "Starting Balance:", (flt_starting_balance * 100).round/100.0}
      #{render_summary_transaction "Total Deposits:", (flt_total_deposits * 100).round/100.0}
      #{render_summary_transaction "Total Withdrawals:", (flt_total_withdrawals * 100).round/100.0}
      #{render_summary_transaction "Ending Balance:", (flt_ending_balance * 100).round/100.0}
    </table>
SUMMARY
end

def render_statement_head(title)
  <<HEAD
  <head>
  <title>#{title}</title> 
  </head>
HEAD
end

def render_statement_body(title, arr_all_withdrawals, arr_all_deposits, arr_daily_balance, flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance)
  <<BODY
  <body>
  <h1>#{title}</h1>
  <h2>Withdrawals</h2>
  #{render_transactions arr_all_withdrawals}
  <h2>Deposits</h2>
  #{render_transactions arr_all_deposits}
  <h2>Daily Balance</h2>
  #{render_daily_balances arr_daily_balance}
  <h2>Summary</h2>
  #{render_summary flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance}
  </body>
BODY
end

def render_statement(arr_all_withdrawals, arr_all_deposits, arr_daily_balance, flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance)
  <<HTML
    <!doctype html>
    <html>
    #{render_statement_head "Monthly Statement"}
    #{render_statement_body "Monthly Statement", arr_all_withdrawals, arr_all_deposits, arr_daily_balance, flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance}
  </html>
HTML
end

statement_output = render_statement(arr_all_withdrawals, arr_all_deposits, arr_daily_balance, flt_starting_balance, flt_total_deposits, flt_total_withdrawals, flt_ending_balance)

save_statement_output(statement_output, OUTPUT_FILE_NAME)
