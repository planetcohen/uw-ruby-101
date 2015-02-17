# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    self.split.each {|w| w.capitalize!}.join " "
  end

  def palindrome?
    word = self.gsub(/\W/, "").downcase
    word == word.reverse
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
    if self.length <= 1
      sentence = self.join
    else
      lastword = self.pop.to_s
      sentence = self.join ", "
      sentence << " and " << lastword
    end
    sentence
  end

  def mean
    return "You'll need a value in that array" if self==[]
    sum = self.reduce(0) {|num, acc| acc + num}
    mean = sum.to_f / self.length
    mean.round(1)
  end

  def median
    return "You'll need a value in that array" if self==[]
    arysort = self.sort
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




#The output isn't working properly.  I was happy to get it this close though.
#It was difficult to work through the homework without having the lecture
#recordings to reference.


class BankAccount
  attr :records
  def initialize csvFileData
    @records = csvFileData.map do |line|
      fields = line.split ','
      create_transaction fields[0], fields[1], fields[2], fields[3].chop
    end

    @records = records.sort_by { |line| (line[:date].split"/")[1].to_i}
  end

  def create_transaction(date, payee, amount, type)
    {date: date, payee: payee, amount: amount, type: type}
  end


  # - summary:
  #   - starting balance, total deposits, total withdrawals, ending balance
  # summary = [{start_bal, end_bal, total_d, total_w}]
  # access by typing december.records.summary
  def summary
    total_w = 0
    total_d = 0
    self.records.each do |line|
      if line[:type].downcase == "withdrawal"
        total_w += line[:amount].to_f.round(2)
      elsif line[:type].downcase == "deposit"
        total_d += line[:amount].to_f.round(2)
      end
    end

    end_bal = total_d - total_w
    {start_bal: 0.00, end_bal: end_bal, total_d: total_d, total_w: total_w }

  end

  def extract_withdrawal
    withdrawals = []
    self.records.each do |line|
      if line[:type] == 'withdrawal'
        withdrawals << line
      end
    end
    withdrawals
  end

  def extract_deposit
    deposits = []
    self.records.each do |line|
      if line[:type] == 'deposit'
        deposits << line
      end
    end
    deposits
  end
end


#------------------------------------
#------------------------------------
#------------------------------------
#------------------------------------






def render_html title, &block
<<HTML
  <!doctype html>
  <html>
  #{block.call}
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

def render_body(title, &block)
<<BODY
  <body>
  <h1>#{title}</h1>
  #{block.call}
  </body>
BODY
end


def render_summary(summary)
<<SUMMARY
  <h2>Summary</h2>
  <table>
  <tr><th>Starting Balance</th?  <td>$ #{summary[:start_bal]}<td></tr>
  <tr><th>Total Deposits</th?    <td>$ #{summary[:total_d]}<td></tr>
  <tr><th>Total Withdrawals</th? <td>$ #{summary[:total_w]}<td></tr>
  <tr><th>Ending Balance</th?    <td>$ #{summary[:end_bal]}<td></tr>
  </table>
SUMMARY
end

def render_withdrawals(title, records)
<<RECORDS

    <h2>#{title}</h2>
  <table>
  #{records.map {|r| render_record r}.join "\n"}
  </table>
RECORDS
end

def render_deposits(title, records)
<<RECORDS

    <h2>#{title}</h2>
  <table>
  #{records.map {|r| render_record r}.join "\n"}
  </table>
RECORDS
end

def render_record(r)
<<RECORD
  <tr>
  <td>#{r[:date]}</td>
  <td>#{r[:payee]}</td>
  <td>$ #{r[:amount]}</td>
  </tr>

RECORD
end


def CreateStatement (csvFilename)
  File.open(csvFilename) do |input|
    ary = input.readlines
    header = ary.shift
    december = BankAccount.new ary

    File.open("output.txt", "w+") do |output|
      html_block = render_html "Custom Bank Statement" do
        render_head "Custom Bank Statement"
        render_body "Bank Info Below:" do
          render_summary december.summary
          render_withdrawals "Withdrawals", december.extract_withdrawal
          render_deposits "Deposits", december.extract_deposit
        end
      end
      output.write html_block
    end
  end
end

CreateStatement("bankdata.csv")
