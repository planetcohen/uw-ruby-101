# ========================================================================================
# Assignment 3
# ========================================================================================

require 'bigdecimal'
require 'date'

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    word_array = self.split(/\W+/)
    word_array.map { |w| w.capitalize }.join(" ")
  end

  def palindrome?
    canonical_string = self.gsub(/\W+/, '').downcase
    canonical_string == canonical_string.reverse
  end
end

"hEllo WORLD".titleize                         #=> "Hello World"
"gooDbye CRUel wORLD".titleize                 #=> "Goodbye Cruel World"

"abba".palindrome?                             #=> true
"aBbA".palindrome?                             #=> true
"abb".palindrome?                              #=> false

"Able was I ere I saw elba".palindrome?        #=> true
"A man, a plan, a canal, Panama".palindrome?   #=> true


# ========================================================================================
#  Problem 2 - re-implement mean, median, to_sentence

# re-implement mean, median, to_sentence as methods on Array

class Array
  def mean
    self.reduce(:+).to_f / self.length
  end

  def median
    # the array has to be sorted for the algorithm to work
    sorted_ary = self.sort
    mid_index = sorted_ary.length/2
    if sorted_ary.length.odd?
      # if the number of elements is odd, the median is just the number in the middle
      sorted_ary[mid_index]
    else
      # if the number of elements is even, the median is the average of the two numbers in the middle
      (sorted_ary[mid_index] + sorted_ary[mid_index + 1])/2.0
    end
  end

  def to_sentence
    return self.join("") if self.length < 2
    # make a copy of the array since pop is destructive
    array_copy = Array.new(self)
    last_element = array_copy.pop
    "#{array_copy.join(", ")} and #{last_element}"
  end
end

# Your method should generate the following results:
[1, 2, 3].mean     #=> 2
[1, 1, 4].mean     #=> 2

[1, 2, 3].median   #=> 2
[1, 1, 4].median   #=> 1

[].to_sentence                       #=> ""
["john"].to_sentence                 #=> "john"
["john", "paul"].to_sentence         #=> "john and paul"
[1, "paul", 3, "ringo"].to_sentence  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 3 - re-implement bank statement

# re-implement bank statement from Assignment 2

# instead of using hashes, create classes to represent:
# - BankAccount
# - Transaction
# - DepositTransaction
# - WithdrawalTransaction

class BankAccount
  attr_reader :transactions

  def initialize(csv_filename)
    @transactions = []

    File.open(csv_filename, "r") do |f|
      keys_array = nil

      f.each_with_index do |line, line_num|
        values = line.chomp().split(",")

        if line_num == 0
          keys_array = values.map { |value| value.to_sym }
        else
          # create a map as a record for each transaction
          fields = {}

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
            fields[key] = value
          end

          @transactions << Transaction.create(fields)
        end
      end
    end

    # return a sorted list of transactions by date
    @transactions.sort { |t1, t2| t1.date <=> t2.date }
  end

  def starting_balance
    BigDecimal("0")
  end

  def ending_balance
    starting_balance + total_deposits - total_withdrawals
  end

  def total_withdrawals
    withdrawals.reduce(BigDecimal("0")) { |sum, t| sum += t.amount }
  end

  def total_deposits
    deposits.reduce(BigDecimal("0")) { |sum, t| sum += t.amount }
  end

  def withdrawals
    @transactions.select { |t| t.class == WithdrawalTransaction }
  end

  def deposits
    @transactions.select { |t| t.class == DepositTransaction }
  end

  # return an array of daily balance records, each record has two keys: :date and :amount.
  def daily_balances
    # create a hash of date => transaction array
    transactions_by_date = @transactions.group_by { |t| t.date }
    # create a hash of date => total amount of transactions for a given day
    daily_changes = transactions_by_date.reduce(Hash.new(BigDecimal.new("0"))) do |h, (k, v)|
      h[k] = v.reduce(0) do |total, t|
        total += t.signed_amount
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
end

class Transaction
  attr_reader :date, :payee, :amount

  # factory method for creating a transaction from a hash
  def self.create(fields)
    date = fields[:date]
    payee = fields[:payee]
    amount = fields[:amount]
    type = fields[:type]
    if type == :deposit
      DepositTransaction.new(date, payee, amount)
    elsif type == :withdrawal
      WithdrawalTransaction.new(date, payee, amount)
    end
  end

  def initialize(date, payee, amount)
    @date = date
    @payee = payee
    @amount = amount.abs
  end

  def signed_amount
    @amount
  end
end

class DepositTransaction < Transaction
  def initialize(date, payee, amount)
    super(date, payee, amount)
  end
end

class WithdrawalTransaction < Transaction
  def initialize(date, payee, amount)
    super(date, payee, amount)
  end

  def signed_amount
    -@amount
  end
end

# use blocks for your HTML rendering code

def generate_html_statement(csv_filename)
  account = BankAccount.new(csv_filename)

  # invoke the render functions in a DSL-style-like structure

  html = render_html("Monthly Bank Statement", account) do |title, account|
    render_head(title) +
    render_body(account) do |account|
      render_section("Summary", account) do |account|
        render_summary_table(account)
      end +
      render_section("Withdrawals", account.withdrawals) do |transactions|
        render_transaction_table(transactions) do |transaction|
          render_transaction_row(transaction)
        end
      end +
      render_section("Deposits", account.deposits) do |transactions|
        render_transaction_table(transactions) do |transaction|
          render_transaction_row(transaction)
        end
      end +
      render_section("Daily Balance", account.daily_balances) do |daily_balances|
        render_daily_balance_table(daily_balances) do |balances|
          render_daily_balance_row(balances)
        end
      end
    end
  end

  # output the html

  File.open("assignment03-statement.html", "w") do |output|
    output.print html
  end
end

def render_html(title, account, &block)
<<HTML
<!DOCTYPE html>
<html>
#{block.call(title, account)}
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

def render_body(account, &block)
<<BODY
<body>
#{block.call(account)}
</body>
BODY
end

def render_section(title, section_params, &block)
<<SECTION
<h1>#{title}</h1>
#{block.call(section_params)}
SECTION
end

def render_transaction_table(transactions, &block)
<<TABLE
<table>
  <tr>
    <th class="date">Date</th>
    <th class="payee">Payee</th>
    <th class="amount">Amount</th>
  </tr>
  #{transactions.map { |r| block.call(r) }.join("\n")}
</table>
TABLE
end

def render_transaction_row(row)
<<ROW
<tr>
  <td class="date">#{format_date(row.date)}</td>
  <td class="payee">#{row.payee}</td>
  <td class="amount">#{format_amount(row.amount)}</td>
</tr>
ROW
end

def render_daily_balance_table(daily_balances, &block)
<<TABLE
<table>
  <tr>
    <th class="date">Date</th>
    <th class="amount">Amount</th>
  </tr>
  #{daily_balances.map { |r| block.call(r) }.join("\n")}
</table>
TABLE
end

def render_daily_balance_row(row)
<<ROW
<tr>
  <td class="date">#{format_date(row[:date])}</td>
  <td class="amount">#{format_amount(row[:amount])}</td>
</tr>
ROW
end

def render_summary_table(account)
<<TABLE
<table>
  <tr>
    <td class="label">Starting balance</td>
    <td class="amount">#{format_amount(account.starting_balance)}</td>
  </tr>
  <tr>
    <td class="label">Total deposits</td>
    <td class="amount">#{format_amount(account.total_deposits)}</td>
  </tr>
  <tr>
    <td class="label">Total withdrawals</td>
    <td class="amount">#{format_amount(account.total_withdrawals)}</td>
  </tr>
  <tr>
    <td class="label">Ending balance</td>
    <td class="amount">#{format_amount(account.ending_balance)}</td>
  </tr>
</table>
TABLE
end

def format_date(date)
  date.strftime("%m/%d/%Y")
end

def format_amount(amount)
  "$%.2f" % amount
end
