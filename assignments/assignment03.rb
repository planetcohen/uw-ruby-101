# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

 class String
  def titleize
    my_words = self.split(" ")
    cap_sentence = ""
    my_words.each {|w| cap_sentence << w.capitalize << " "} 
    cap_sentence.chop
  end
  
  def palindrome?
    s1 = self.gsub(' ', '').downcase
    s1 = s1.gsub(',', '').downcase
    s2 = s1.reverse
    if s2 == s1 
      true
    else
      false
    end
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
    tot = self.reduce {|i, acc| i + acc }
    tot.to_f/self.length
  end
  
  def median
    alen = self.length
    if alen % 2 == 1 then
      med = self[alen/2]
    else
      mean([self[alen/2],self[(alen/2)+1]])
    end
  end
  
  def to_sentence
    str1 = self[0...-1].reduce {|item, acc| item.to_s + ", #{acc}"}
    a2 = [str1, self[-1]]
    a2.compact!
    a2.join " and "
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

class Transaction
  def initialize(date, payee, amount, type)
    @date = date
    @payee = payee
    @amount = amount.to_f
    @type = type  
  end
  def date; @date; end
  def payee; @payee; end
  def amount; @amount; end
  def type; @type; end
  def puts
    if @type == "Deposit"
      print "date: #{date}, payee: #{payee}, amount: #{amount} \n" 
    elsif @type == "Withdrawal"
      print "date: #{date}, payee: #{payee}, amount: #{amount} \n"
    else print "\n"
    end 
  end
end

class DepositTransaction < Transaction
 def initialize(date, payee, amount)
  super date, payee, amount.to_f, "Deposit"
 end
end

class WithdrawalTransaction < Transaction
 def initialize(date, payee, amount)
  super date, payee, amount.to_f * -1.0, "Withdrawal"
 end
end

class BankAccount < Array
  def initialize()
  end
  def add_transaction(transaction)
    self.push transaction
  end
  def import_transactions(filename)
    transactions = File.open(filename, "r") do |infile|
      records = infile.readlines.map do |inline|
        f = inline.chomp.split(",")
        if  f[3] == "deposit" then
          t = DepositTransaction.new(f[0], f[1], f[2])
          self.add_transaction t
        elsif f[3] == "withdrawal" then
          t = WithdrawalTransaction.new(f[0], f[1], f[2])
          self.add_transaction t
        end
      end
    end
  end
end

ba = BankAccount.new()
ba.import_transactions('assignment02-input.csv')
ba.each {|t| t.puts}
puts ba.each {|t| puts t.amountval}

a = []
a[0]= WithdrawalTransaction.new('15/1/2008', 'me', 100)
a[1] = DepositTransaction.new('15/1/2008', 'me', 100)
puts a


withdrawals = transactions.select {|h| h[:type] == 'withdrawal' }
withdrawals.sort_by! {|x| x[:date]}
deposits = transactions.select {|h| h[:type] == 'deposit' }
deposits.sort_by! {|x| x[:date]}

def get_totals(records)
  amounts = records.map {|r| r[:amount].to_f }
  amounts.reduce(0) { |val, acc| val + acc }.round(2)
end

def mean(ary)
  tot = ary.reduce {|i, acc| i + acc }
  avg = tot.to_f/ary.length
end

def get_daily_balance(transactions) 
  days = transactions.map {|t| t[:date]}.uniq
  days.sort_by! {|i| i.split("/")[1].to_i}
  transactions_by_day = days.reduce({}) do |acc, day|
    acc[day] = transactions.select { |t| t[:date] == day }
    acc
  end
  sum_transactions_by_day = days.reduce({}) do |acc, day|
    amounts = transactions_by_day[day].map {|record| record[:amount]}
    sum = amounts.reduce {|acc, amount| acc.to_f + amount.to_f }
    acc[day] = sum.to_f 
    acc
  end
  bal = 0
  balances_by_day = days.reduce([]) do |acc, day|
    h = {}
    h[:date] = day
    h[:balance] = bal + sum_transactions_by_day[day]
    acc << h
    acc
  end
  balances_by_day
end

#balances = get_daily_balance(nt)

def get_summable_transactions(transactions)
  trans_vals = transactions.reject {|t| t[:date] == "date"}
  out_trans = []
  out_trans = trans_vals.map do |t|
    if t[:type] == "withdrawal" then
      t[:amount] = t[:amount].to_f * -1.0
    else
      t[:amount] = t[:amount].to_f 
    end
    t
  end
  # puts out_trans
end

#nt = get_summable_transactions(transactions)
puts nt
get_daily_balance(nt)


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

def render_balance_record(record)
<<RECORD
<tr>
  <td>#{record[:date]}</td>
  <td>#{record[:balance]}</td>
</tr>
RECORD
end


def render_daily_balances(transactions)
nt = get_summable_transactions(transactions)
db = get_daily_balance(nt)
puts db.class
<<BALANCES
  <table><tr><th>Date</th><th>Ending Balance</th></tr>
  #{db.map {|rec| render_balance_record(rec)}.join "\n"}
  </table>
BALANCES
end


def get_ending_balance(beginning_balance, tot_withdrawals, tot_deposits)
  beginning_balance.to_f - tot_withdrawals.to_f + tot_deposits.to_f
end

total_deposits = get_totals(deposits)
total_withdrawals = get_totals(withdrawals)

File.open('assignment02-out.htm', "w") do |outfile|
  outfile.puts "<HTML><BODY>"
  outfile.puts "<h1>Summary</h1>"
  outfile.puts "<p>Total withdrawals: $#{total_withdrawals}</p>"
  outfile.puts "<p>Total deposits: $#{total_deposits}</p>"
  outfile.puts "<p>Final Balance: $#{get_ending_balance(0, total_withdrawals, total_deposits)}</p>"
  outfile.puts render_daily_balances(transactions)
  outfile.puts render_body("Withdrawals", withdrawals)
  outfile.puts render_body("Deposits", deposits)
  outfile.puts "</BODY></HTML>"
end
