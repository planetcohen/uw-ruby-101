# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  # your implementation here
  ary_len = ary.length
  result_ary = []
  i = 1;

  #push first word from array to result string
  result_ary << ary[0]

  #if array is has more than one word 
  if ary_len > 1
    #iterate through ary except for the last one 
    while i < ary_len-1
      #push a comma and a space to result
      result_ary << ", "
      #push a word from array to result
      result_ary << ary[i]
      i += 1
    end

    #push and before last word
    result_ary << " and "
    #push last word to result
    result_ary << ary[i]
  end
   
  return result_ary.join
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
  # get sum
  sum = ary.reduce(0.0) {|item, acc| acc + item}
  
  # divide by the numbers of element
  return sum/ary.count
end

def median(ary)
  n = ary.count
  m = nil

  #sort
  sorted_ary = ary.sort

  #if ary has even number of element return average of element count/2 and count/2 
  if(n % 2 == 0)
    sum = sorted_ary.at(n/2-1) + sorted_ary.at(n/2)
    m = sum/2
  else
    #else return value of element count/2
    m = sorted_ary.at(n/2)  
  end

  return m
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
  ary.map {|item| key_ary << item[key]}
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
def create_transaction(date, payee, amount, type)
  {date: date, payee: payee, amount: amount, type: type}
end

#get records based on type
def get_records(records, type)
  r = records.select{ |r| r[:type] == type}
  r.sort_by!{|r| r[:date].split('/').map{|d| d.to_i} }
  return r
end

#get sum of all records
def records_sum(records)
  sum = 0.0;
  records.each{|r| sum+= r[:amount].to_f}
  return sum
end

def get_daily_balances(records)
  daily_balance = []
  balance = 0.0
  #get unique date array
  dates = records.map{|r| r[:date]}.uniq
  #sort date 
  dates.sort_by!{|d| d.split('/').map{|d| d.to_i} }

  dates.each do |d|
    #get daily records
    daily_records = records.select {|r| r[:date] == d}
    render_records daily_records

    #get deposit
    deposits = get_records daily_records, "deposit"
    total_deposit = records_sum deposits
  
    #get withdrawls
    withdrawals = get_records daily_records, "withdrawal"
    total_withdrawal = records_sum withdrawals

    #calculate running balance
    balance = balance + total_deposit - total_withdrawal

    #get daily balance
    daily_balance << {:date => d, :records => daily_records, :balance => balance}
  end

  return daily_balance
end


def render_head(title)
<<HEAD
  <head>
    <title>#{title}</title>
  </head>
HEAD
end

def render_record_title(r)
<<RECORD
  <tr>
    <td><b>#{r[:date].capitalize}</b></td>
    <td><b>#{r[:payee].capitalize}</b></td>
    <td><b>#{r[:amount].capitalize}</b></td>
    <td><b>#{r[:type].capitalize}</b></td>
  </tr>
RECORD
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

def render_records(records)
<<RECORDS
    #{records.map {|r| render_record r}.join "\n"}
RECORDS
end

def render_daily_balance(r)
<<RECORD
  <tr><td><b>#{r[:date]}</b></td></tr>
  #{render_records r[:records]}
  <tr><td></td></tr>
  <tr>
    <td></td>
    <td><b>Balance: </b></td>
    <td></td>
    <td> $ #{'%.02f' % r[:balance]}</td>
  </tr>
  <tr><td></td></tr>
RECORD
end

def render_daily_balances(records)
  daily_records = get_daily_balances records
<<RECORDS
    #{daily_records.map {|r| render_daily_balance r}.join "\n"}
RECORDS
end


def render_summary(deposits, withdrawals)
  ending_balance = deposits - withdrawals
<<RECORDS
  <table>
    <tr>
      <td> <b>Starting Balance: </b></td>
      <td> $ 0.00 </td>
    </tr>
    <tr>
      <td><b> Total Deposits:</b> </td>
      <td> $ #{'%.02f' % deposits} </td>
    </tr>
    <tr>
      <td><b> Total Withdrawals: </b></td>
      <td> $ #{'%.02f' % withdrawals} </td>
    </tr>
    <tr>
      <td><b> Ending Balance:</b> </td>
      <td> $ #{'%.02f' % ending_balance} </td>
    </tr>
  </table>
RECORDS
end

def render_body(title, records)
  # get record column title
  record_title = records.shift

  #get deposit
  deposits = get_records records, "deposit"
  total_deposit = records_sum deposits
  
  #get withdrawls
  withdrawals = get_records records, "withdrawal"
  total_withdrawal = records_sum withdrawals

<<BODY
  <body>
    <h1>#{title}</h1>
    <h2> Deposits </h2>
    <hr>
    <table>
      #{render_record_title record_title}
      #{render_records deposits}
    </table>
    <br><br>
    <h2> Withdrawals </h2>
    <hr>
    <table>
      #{render_record_title record_title}
      #{render_records withdrawals}
    </table>
    <br><br>
    <h2> Daily Balance </h2>
    <hr>
    <table>
      #{render_record_title record_title}
      #{render_daily_balances records}
    </table>
    <br><br>
    <h2> Summary </h2>
    <hr>
    #{render_summary total_deposit, total_withdrawal}

  </body>
BODY
end

def render_html(title, records, credit, debit)
<<HTML
  <!doctype html>
  <html>
    #{render_head title}
    #{render_body title, records}
  </html>
HTML
end

def make_statement(filename)
  records = []
  deposit = 0;
  withdrawal = 0;
 
  #read input from file
  File.open(filename) do |input|
    records = input.readlines.map do |line|
      line.chop!
      fields = line.split ","
      #create record
      transaction = create_transaction fields[0], fields[1], fields[2], fields[3]
    end 
  end
 
  #render_html "Monthly Statment" records
  render_html("Monthly Statement", records, deposit, withdrawal)
  
end

make_statement "assignment02-input.csv"
     
