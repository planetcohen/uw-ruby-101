# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  # your implementation here
	str1 = ary[0...-1].reduce {|item, acc| item.to_s + ", #{acc}"}
	a2 = [str1, ary[-1]]
	a2.compact!
	a2.join " and "
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
  tot = ary.reduce {|i, acc| i + acc }
  avg = tot.to_f/ary.length
end

def median(ary)
  alen = ary.length
  if alen % 2 == 1 then
  	med = ary[alen/2]
  else
  	mean([ary[alen/2],ary[(alen/2)+1]])
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
  # your implementation here
  out_array = []
  ary.each do |h|
    out_array << h[key]
  end
  out_array
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
def create_transaction_hash( date, payee, amount, type )
  { date: date, payee: payee, amount: amount, type: type }
end

records = []
transactions = File.open('assignment02-input.csv', "r") do |infile|
  records = infile.readlines.map do |inline|
    f = inline.chomp.split(",")
    create_transaction_hash(f[0], f[1], f[2], f[3])
  end
end

withdrawals = transactions.select {|h| h[:type] == 'withdrawal' }
withdrawals.sort_by! {|x| x[:date]}
deposits = transactions.select {|h| h[:type] == 'deposit' }
deposits.sort_by! {|x| x[:date]}

def get_totals(records)
  amounts = records.map {|r| r[:amount].to_f }
  amounts.reduce(0) { |val, acc| val + acc }.to_f
end

def mean(ary)
  tot = ary.reduce {|i, acc| i + acc }
  avg = tot.to_f/ary.length
end

def get_daily_balance(transactions)
  days = transactions.map {|t| t[:date]}.uniq
  days.sort_by! {|d| d.split('/')[1].to_i}
  puts days.inspect
  transactions_by_day = days.reduce({}) do |day, acc|
    acc[day] = transactions.select {|t| t[:date] == day}
  end
  puts transactions_by_day
end
get_daily_balance(deposits)

def render_record(rec)
<<RECORD
<tr>
  <td>#{rec[:date]}</td>
  <td>#{rec[:payee]}</td>
  <td>$#{rec[:amount]}</td>
<tr>
RECORD
end

def render_table_header()
<<HEADER
<tr>
  <th>Date</th>
  <th>Payee</th>
  <th>Amount</th>
<tr>
HEADER
end

def render_header(record) 
end

def render_records(records)
<<RECORDS
<table style="width:30%">
  #{render_table_header}
  #{records.map {|r| render_record(r)}.join "\n"}
</table>
RECORDS
end

def render_body(title, records)
<<BODY
    <h1>#{title}</h1>
    #{render_records(records)}
BODY
end

def render_totals(transactions)
  
end

def get_ending_balance(beginning_balance, tot_withdrawals, tot_deposits)
  beginning_balance.to_f - tot_withdrawals.to_f + tot_deposits.to_f
end

total_deposits = get_totals(deposits)
total_withdrawals = get_totals(withdrawals)

File.open('assignment02-out.htm', "w") do |outfile|
  outfile.puts "<HTML><BODY>"
  outfile.puts render_body("Withdrawals", withdrawals)
  outfile.puts render_body("Deposits", deposits)
  outfile.puts "<p>Total withdrawals: $#{total_withdrawals}</p>"
  outfile.puts "<p>Total deposits: $#{total_deposits}</p>"
  outfile.puts "<p>Final Balance: $#{get_ending_balance(0, total_withdrawals, total_deposits)}</p>"
  outfile.puts "</BODY></HTML>"
end





