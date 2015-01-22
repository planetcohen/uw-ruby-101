# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  sentence = ""
  if ary.length <= 1
    sentence = ary.join
  else
    ary.insert(ary.length-1, 'and')
    c = 0
    while c <= ary.length-1
      if c <= ary.length - 4
        sentence << ary[c].to_s + ', '
      elsif c <= ary.length - 2
        sentence << ary[c].to_s + ' '
      else
        sentence << ary[c].to_s
      end
      c += 1
    end
  end
  sentence
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
  return "You'll need a value in that array" if ary==[]

  sum = ary.reduce(0) {|num, acc| acc + num}
  mean = sum.to_f / ary.length
  mean.round(1)
end

def median(ary)
  return "You'll need a value in that array" if ary==[]
  arysort = ary.sort
  if arysort.length == 1
    median = arysort[0]
  elsif arysort.length % 2 == 0
    median = (arysort[arysort.length/2] + arysort[arysort.length/2 - 1]) / 2.0
    median = median.round(1)
  else
    median = arysort[arysort.length/2]
  end
  median
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
  plucked = []
  ary.each {|h| plucked << h[key]}
  plucked
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

File.open("bankdata.csv") do |input|
  ary = input.readlines
  header = ary.shift

  records = ary.map do |line|
    fields = line.split ','
    create_transaction fields[0], fields[1], fields[2], fields[3].chop
  end

  def extract_withdrawal(records)
    withdrawals = []
    records.each do |line|
      if line[:type] == 'withdrawal'
        withdrawals << line
      end
    end
    withdrawals
  end

  def extract_deposit(records)
    deposits = []
    records.each do |line|
      if line[:type] == 'deposit'
        deposits << line
      end
    end
    deposits
  end

  #Make a method to go through each line of the input file.
  #For each day, sum the transactions to get a daily delta
  #add to the running balance.
  #day_balance = [{:date, :balance}]
  def daily_balance(records)
    day = 1
    daily_bal = 0
    day_balance = []
    while day <= 31
      daily_date = "12/" + day.to_s + "/2014"
      records.each do |line|
        if line[:date] == daily_date
          if line[:type] == "withdrawal"
            daily_bal -= line[:amount].to_f
          elsif line[:type] == "deposit"
            daily_bal += line[:amount].to_f
          end
        end
      end

      day_balance << {date: daily_date, balance: daily_bal.round(2)}
      day += 1

    end
    day_balance

  end


  # - summary:
  #   - starting balance, total deposits, total withdrawals, ending balance
  # summary = [{start_bal, end_bal, total_d, total_w}]
  def summary(records)
    withdrawals = extract_withdrawal records
    total_w = 0
    withdrawals.each do |line|
      total_w += line[:amount].to_f
    end

    total_d = 0
    deposits = extract_deposit records
    deposits.each do |line|
      total_d += line[:amount].to_f
    end

    end_bal = total_d - total_w

    summary = {start_bal: 0, end_bal: end_bal.round(2), total_d: total_d.round(2), total_w: total_w.round(2) }
    summary
  end

#A quick test to write to a file.  Nothing pretty here, but it works.
  File.open("output.txt", "w+") do |output|
    output.print "Hi there!!"
    summary = summary(records)
    daily_balance = daily_balance(records)
    output.print summary
    output.print daily_balance
  end


end


# I'm not really sure what to do with the html.  I'll have to come back to this
# after getting another example or comparing against other pull requests



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
  <td>#{r[:fname]}</td>
  <td>#{r[:lname]}</td>
  <td>#{r[:age]}</td>
  <td>#{r[:addr][:street]}</td>
  <td>#{r[:addr][:city]}</td>
  <td>#{r[:addr][:state]}</td>
  <td>#{r[:addr][:zip]}</td>
  </tr>
RECORD
end
