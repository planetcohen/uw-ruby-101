#Douglas McGowan, Winter 2015

# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    words = self.split
    caps = []
    words.each do |word|
      caps << word.capitalize
    end
    caps.join " "
  end
end

class String
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
  def mean
    sum=0.0
    self.each {|item| sum+=item}
    sum/self.count
  end
end

class Array
  def median
    sorted_ary = self.sort
    len = sorted_ary.length
    mid_index = len/2
    if len.odd?
      sorted_ary[mid_index]
    else
      mid_lo = sorted_ary[mid_index]
      mid_hi = sorted_ary[mid_index+1]
      (mid_lo + mid_hi)/2.0
    end
  end
end

class Array
  def to_sentence
    if self.length == 0
      []
    elsif self.length == 1
      self[0]
    else
      last = self.pop
      "#{self.join(", ")} and #{last}"
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

def monthlystatement

require 'date'


  $file = File.open("monthlystatement.html", "w")

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


$file.print "<table>"

records.map {|r| $file.print render_record r}

$file.print "</table>"

end

def render_body(title, records)

total_withdrawals = 0
  withdrawals = records.select do |t|
    t[:type][0].chr == "w"
  end
  total_withdrawals = withdrawals.map {|withdrawal| withdrawal[:amount]}.reduce{|amount, acc| amount + acc}


total_deposits = 0
  deposits = records.select do |t|
    t[:type][0].chr == "d"
  end
total_deposits = deposits.map {|deposit| deposit[:amount]}.reduce{|amount, acc| amount + acc}


$file.print <<BODY
  <body>
    <h1>#{title}</h1>
    <h2>Withdrawals</h2>
BODY


render_records withdrawals


$file.print "<h2>Deposits</h2>"


render_records deposits

$file.print "<h2>Daily Balance</h2>"
$file.print "<table>"

daily_balance = 0
trans_dates = records.map {|trans_date| trans_date[:date]}.uniq.sort
#puts trans_dates

trans_dates.reduce(0) do |daily_bal, acc_date|
  daily_deposits = records.select do |t|
    t[:date]==acc_date and t[:type][0].chr == "d"
  end
  daily_deposits_amt = daily_deposits.map {|deposit| deposit[:amount]}.reduce{|amount, acc| amount + acc}
      if daily_deposits_amt == nil
        daily_deposits_amt = 0
      end
  daily_withdrawals = records.select do |t|
    t[:date]==acc_date and t[:type][0].chr == "w"
  end
  daily_withdrawals_amt = daily_withdrawals.map {|withdrawal| withdrawal[:amount]}.reduce{|amount, acc| amount + acc}
      if daily_withdrawals_amt == nil
        daily_withdrawals_amt = 0
      end
daily_balance = daily_balance + daily_deposits_amt - daily_withdrawals_amt
$file.print <<ROW
<tr>
<td>#{acc_date}</td><td>#{daily_balance}</td>
</tr>
ROW
end


$file.print "</table>"

ending_balance = total_deposits - total_withdrawals

$file.print "<h2>Summary</h2>"
$file.print <<SUMMARY
<table>
<tr><td>Starting Balance:</td><td>0</td></tr>
<tr><td>Total Deposits:</td><td>#{total_deposits}</td></tr>
<tr><td>Total Withdrawals:</td><td>#{total_withdrawals}</td></tr>
<tr><td>Ending Balance:</td><td>#{ending_balance}</td></tr>
</table>
SUMMARY


$file.print "</body>"


end

def render_head(title)
<<HEAD
  <head>
    <title>#{title}</title>
  </head>
HEAD
end


def render_html(title, records)


html = <<HTML
    <!doctype html>
    <html>
      #{render_head title}
HTML

$file.print html


render_body title, records


$file.print "</html>"

$file.close

end

#transation_record = {:date => date, :payee => payee, :amount => amount, :type => type}
transaction_record = Array.new
x=0

File.open("assignment02-input.csv") do |input|
  records = input.readlines.map do |line|
  fields = line.split ","
    if x >=1
    transaction_record << {:date => Date.strptime(fields[0], "%m/%d/%Y"), :payee => fields[1], :amount => fields[2].to_f, :type => fields[3]}
    end

  #puts line
  #puts "newline"
  #puts fields
  x+=1
  end
 end

#puts transaction_record

render_html "Monthly Statement", transaction_record

end
