# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String
class String

  def titleize
    #get array of words in the s
    words_in_s = split " "

    #make a string with all the words capitalized
    titlized_s = ""
    words_in_s.each do |w|
      titlized_s << w.capitalize
      titlized_s << " "
    end 

    #remove the last space
    titlized_s.chop!
  end

  def palindrome?
    #make all the letters lower case
    original = downcase

    #remove all non alphanumeric characters
    original.gsub!(/[^\p{Alnum}-]/, '')

    #save a reverse copy
    reverse = original.reverse

    #compare and return results
    reverse == original 
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
#  Problem 2 - re-`:w
#  implement mean, median, to_sentence

# re-implement mean, median, to_sentence as methods on Array
class Array
  def mean
    # get sum
    sum = reduce(0.0) {|item, acc| acc + item}
    
    # divide by the numbers of element
    sum.to_f/count
  end

  def median
    n = count

    #sort
    sorted_ary = sort

    #if ary has even number of element return average of element count/2 and count/2 
    if n.odd?
      sorted_ary.at(n/2).to_f  
    else
      sum = sorted_ary.at(n/2-1) + sorted_ary.at(n/2)
      sum.to_f/2
    end
  end
  
  def to_sentence()
    # your implementation here
    ary_len = length

    #if array is has more than one word 
    if ary_len > 1
      last = pop
      "#{join(", ")} and #{last}"
    else
      join
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

  def initialize
    @txs = []
    @deposits = []
    @withdrawals = []
    File.open("assignment02-input.csv") do |file|
     lines = file.readlines

     keys = lines.shift.chomp.split(",").map {|key| key.to_sym}

     lines.map do |line|
       fields = line.chomp.split(",")
       @txs << Transaction.new(fields[0], fields[1], fields[2], fields[3])
       #divide transactions into deposit and withdrawals
       if (fields[3] == "deposit")
         @deposits << DepositTransaction.new(fields[0], fields[1], fields[2])
       else
         @withdrawals << WithdrawalsTransaction.new(fields[0], fields[1], fields[2])
       end
     end
    end

    @deposits = @deposits.sort_by{|d| d.comparable_date}
    @withdrawals = @withdrawals.sort_by{|d| d.comparable_date}

  end
 
  def txs_totals(wtx, dtx, starting_balance)
    sum_withdrawals = wtx.reduce(0) {|acc, tx| acc += tx.amount}

    sum_deposits = dtx.reduce(0) {|acc, tx| acc += tx.amount}

    ending_balance = starting_balance + sum_deposits - sum_withdrawals
    
    {
      summary: {
        starting_balance: starting_balance,
        sum_deposits: sum_deposits,
        sum_withdrawals: sum_withdrawals,
        ending_balance: ending_balance
      },
      withdrawals: wtx,
      deposits: dtx
    }
  end
 
  def calc_statement
    statement = txs_totals @withdrawals, @deposits, 0
    dates = @txs.sort_by{|tx|tx.comparable_date}.map{|tx| tx.date}.uniq
    daily_balances = []
    dates.each_with_index do |date, index|
      dtx_for_date = @deposits.select {|tx| tx.date == date}
      wtx_for_date = @withdrawals.select {|tx| tx.date == date}
      starting_balance = if index == 0
        # first day, so use starting balance:
        statement[:summary][:starting_balance]
      else
        # use ending balance of previous date:
        daily_balances[index-1][:balance]
      end
      daily_statement = txs_totals wtx_for_date, dtx_for_date, starting_balance
      daily_balances << {:date=> date, :balance => daily_statement[:summary][:ending_balance]}
    end
    statement[:daily_balances] = daily_balances
    statement
  end
  
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

  def render_html
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
        <body>
          <h1>Bank Statement</h1>
          #{yield}
        </body>
      </html>
    HTML
  end
  
  def render_body(statement)
    <<-BODY
      <h2>Summary</h2>
      <table>
        <tr><th>Starting Balance</th> <td>#{format_currency statement[:summary][:starting_balance]}</td></tr>
        <tr><th>Total Deposits</th>   <td>#{format_currency statement[:summary][:sum_deposits]}</td></tr>
        <tr><th>Total Withdrawals</th><td>#{format_currency statement[:summary][:sum_withdrawals]}</td></tr>
        <tr><th>Ending Balance</th>   <td>#{format_currency statement[:summary][:ending_balance]}</td></tr>
      </table>

       <h2>Deposits</h2>
        <table>
          #{statement[:deposits].map {|tx| render_tx tx}.join "\n"}
        </table>

        <h2>Withdrawals</h2>
        <table>
          #{statement[:withdrawals].map {|tx| render_tx tx}.join "\n"}
        </table>

        <h2>Daily Balances</h2>
        <table> 
          #{statement[:daily_balances].map{|d| render_daily_balance d[:date], d[:balance]}.join"\n"}
        </table>
    BODY
  end
  
  def render_tx(tx)
    <<-TX
      <tr>
        <th>#{tx.date}</th>
        <th>#{tx.payee}</th>
        <td>#{format_currency tx.amount}</td>
      </tr>
    TX
  end
  
  def render_daily_balance(date, balance)

    <<-TXS
      <tr>
        <th>#{date}</th>
        <td>#{format_currency balance}</td>
      </tr>
    TXS
  end
  
  def render_daily_balances(daily_balances)
    <<-BALANCES
          BALANCES
  end

  def write_html
    statement = calc_statement
    html = render_html {render_body statement}
              
    File.open("assignment3-output.html", "w") do |file|
      file.write html
    end
  end
end 

class Transaction
  attr :amount, :payee, :date, :type, :comparable_date
  def initialize(entry_date, entry_payee, entry_amount, entry_type)
    @date = entry_date
    @comparable_date = entry_date.split('/').map{|d| d.to_i}
    @payee = entry_payee
    @amount = (entry_amount.to_f * 100).to_i
    @type = entry_type
  end

  def to_s
    "#{date} #{payee} #{amount} #{type}"
  end
end

class DepositTransaction < Transaction
  def initialize(date, payee, amount)
    super(date, payee, amount, "Deposit"); 
  end
end

class WithdrawalsTransaction < Transaction
  def initialize(date, payee, amount)
    super(date, payee, amount, "Withdrawal"); 
  end

end

account = BankAccount.new
account.write_html
