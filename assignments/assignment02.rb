# ========================================================================================
# Assignment 2
# ========================================================================================

require 'bigdecimal'
require 'date'

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  # your implementation here
  return ary.join("") if ary.length < 2
  last_element = ary.pop
  "#{ary.join(", ")} and #{last_element}"
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
  ary.reduce(:+) / ary.length
end

def median(ary)
  # your implementation here
  # the array has to be sorted for the algorithm to work
  sorted_ary = ary.sort()
  mid_index = sorted_ary.length/2
  if sorted_ary.length.odd?
    # if the number of elements is odd, the median is just the number in the middle
    sorted_ary[mid_index]
  else
    # if the number of elements is even, the median is the average of the two numbers in the middle
    (sorted_ary[mid_index] + sorted_ary[mid_index + 1])/2.0
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
  ary.map {|m| m[key]}
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
STARTING_BALANCE = BigDecimal.new("0")

def generate_html_statement(csv_filename)
  transactions = read_transactions(csv_filename)
  withdrawals = transactions.select { |t| t[:type] == :withdrawal }
  deposits = transactions.select { |t| t[:type] == :deposit }
  daily_balances = compute_daily_balances(STARTING_BALANCE, transactions)
  deposits_total = deposits.reduce(0) { |sum, t| sum += t[:amount] }
  withdrawals_total = withdrawals.reduce(0) { |sum, t| sum += t[:amount] }
  summary = []
  summary << {label: "Starting balance", amount: STARTING_BALANCE}
  summary << {label: "Total deposits", amount: deposits_total}
  summary << {label: "Total withdrawals", amount: withdrawals_total}
  summary << {label: "Ending balance", amount: STARTING_BALANCE + deposits_total - withdrawals_total}

  html = render_html("Monthly Bank Statement", withdrawals, deposits, daily_balances, summary)

  File.open("assignment02-statement.html", "w") do |output|
    output.print html
  end
end

# return an array of daily balance records, each record has two keys: :date and :amount.
def compute_daily_balances(starting_balance, transactions)
  # create a hash of date => transaction array
  transactions_by_date = transactions.group_by { |t| t[:date] }
  # create a hash of date => total amount of transactions for a given day
  daily_changes = transactions_by_date.reduce(Hash.new(BigDecimal.new("0"))) do |h, (k, v)|
    h[k] = v.reduce(0) do |total, t|
      type = t[:type]
      amount = t[:amount]
      if type == :deposit
        total += amount
      elsif type == :withdrawal
        total -= amount
      end
    end
    h
  end

  daily_balances = {}
  current_balance = starting_balance
  (transactions_by_date.keys.min..transactions_by_date.keys.max).each do |d|
    current_balance += daily_changes[d]
    daily_balances[d] = current_balance
  end

  daily_balances.reduce([]) do |ary, (k, v)|
    ary << {date: k, amount: v}
  end
end

# returns an array of transactions, each represented as a map in Ruby
# the transactions are sorted by date
def read_transactions(csv_filename)
  transactions = []

  File.open(csv_filename, "r") do |f|
    keys_array = nil

    f.each_with_index(sep="\r") do |line, line_num|
      values = line.chomp().split(",")

      if line_num == 0
        keys_array = values.map { |value| value.to_sym }
      else
        # create a map as a record for each transaction
        transaction = {}

        # convert string values to Ruby types as appropriate
        values.each_with_index do |value, i|
          key = keys_array[i]
          case key
            when :date
              value = Date.strptime(value, "%m/%d/%Y")
            when :amount
              # use BigDecimal to represent currency values
              value = BigDecimal.new(value)
            when :type
              value = value.to_sym
          end
          transaction[key] = value
        end

        transactions << transaction
      end
    end
  end

  # return a sorted list of transactions by date
  transactions.sort { |t1, t2| t1[:date] <=> t2[:date] }
end

def render_html(title, withdrawals, deposits, daily_balances, summary)
<<HTML
  <!DOCTYPE html>
  <html>
  #{render_head title}
  #{render_body withdrawals, deposits, daily_balances, summary}
  </html>
HTML
end

def render_head(title)
<<HEAD
  <head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>#{title}</title>
  </head>
HEAD
end

def render_body(withdrawals, deposits, daily_balances, summary)
<<BODY
  <body>
    #{render_section "Withdrawals", [:date, :payee, :amount], withdrawals, true}
    #{render_section "Deposits", [:date, :payee, :amount], deposits, true}
    #{render_section "Daily Balance", [:date, :amount], daily_balances, true}
    #{render_section "Summary", [:label, :amount], summary, false}
  </body>
BODY
end

def render_section(title, headers, rows, render_header)
<<SECTION
  <h1>#{title}</h1>
  #{render_table headers, rows, render_header}
SECTION
end

def render_table(headers, rows, render_header)
<<TABLE
  <table>
    #{render_header ? render_table_header(headers) : ""}
    #{rows.map {|r| render_row r, headers}.join "\n"}
  </table>
TABLE
end

def render_table_header(headers)
<<HEADER
  <tr>
    #{headers.map {|h| "<th class='#{h.to_s}'>#{h.to_s.capitalize}</th>"}.join "\n"}
  </tr>
HEADER
end

def render_row(row, headers)
<<ROW
  <tr>
    #{headers.map {|h| "<td class='#{h.to_s}'>#{format_value(row[h], h)}</td>"}.join "\n"}
  </tr>
ROW
end

def format_value(value, header)
  case header
    when :date
      value.strftime("%m/%d/%Y")
    when :amount
      '$%.2f' % value
    else
      value
  end
end
