# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
  	words = self.split
  	caps=[]
  	words.each do |word|
  		caps << word.capitalize
  	end
  	caps.join" "
  end

  def palindrome?
  	stripped = self.delete(" ").delete(",").downcase
  	stripped == stripped.reverse
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
	def to_sentence
		if self.length == 0
			""
		elsif self.length == 1
			self[0]
		else
			last = self.pop
			"#{self.join(", ")} and #{last}"
		end
	end

	def mean
		sum = self.reduce(0) {|x, ac| acc + x}
		sum.to_f / self.length
	end

	def median
		sorted_ary = self.sort
		len = sorted_ary.length
		mid_index = len/2
		if len.odd?
			sorted_ary[mid_index]
		else
			mid_lo = sorted_ary[mid_index-1]
			mid_hi = sorted_ary[mid_index]
			(mid_lo + mid_hi)/2.0
		end
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

# use blocks for your HTML rendering code

class BankAccount
	attr_reader :balance, :transactions, :withdrawals, :deposits
	attr_writer :transactions	#all other instance variables are determined by transactions

	def initialize(transactions)
		@transactions = transactions
		@balance = 10
		@withdrawals = 10
		@deposits = 10
	end

	def to_s
		puts "balance = #{@balance}, transactions = #{@transactions}, withdrawals = #{@withdrawals}, deposits = #{@deposits}"
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

end


class Transaction
	attr :date, :vendor, :amount, :type

	def initialize (date, vendor, amount, type)
		@date, @vendor, @amount, @type = date, vendor, amount, type
	end
end

class WithdrawalTransaction < Transaction
	def initialize(date, vendor, amount)
		super date, vendor, amount, "withdrawal"
	end
end


class DepositTransaction < Transaction
	def initialize(date, vendor, amount)
		super date, vendor, amount, "deposit"
	end

	def to_s
		"#{@date, @vendor, @amount, @type}"
	end

end







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

      keys = lines.shift.chomp.split(",").map {|key| key.to_sym}    # takes first string out of array of strings, creates array based on where commas are. convert each to a symbol. This is the header row from teh csv and will now be used as keys in hashes.

      lines.map do |line| #go through each row from csv (except first one)
        tx = {}
        line.chomp.split(",").each_with_index do |field, index|   #for each of the lines, remove the newline, convert to array delimited by commas, call block below with field value and the index.
          key = keys[index] #key is set to heading for that column

          tx[key] = field   #tx[column heading] = value in that cell
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
  end
  
  def write_html(html)
    File.open("assignment02-output.html", "w") do |file|
      file.write html
    end
  end
  
  txs = read_txs
  statement = calc_statement txs
  html = render_html ("") do |title| render_body(statement) do 

  write_html html
  nil
end



