# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    downcase.split.map { |w| w.capitalize }.join " "
  end
  def palindrome?
    downcase.gsub(/\s+/m, '').gsub(/,/, '') == downcase.gsub(/\s+/m, '').gsub(/,/, '').reverse
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
    inject(:+) / length.to_f
  end
  def median
    if (length % 2) == 1
      sort[length/2]
    else
      [ sort[length/2], sort[(length/2) - 1] ].mean
    end
  end
  def to_sentence
    each_with_index.map do |w, index|
      case index
      when (length - 1) then w.to_s
      when (length - 2) then w.to_s << " and"
      else w.to_s << ","
      end
    end.join " "
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

  @@starting_balance = 0.0
  @@deposit_total = 0.0
  @@deposit_count = 0
  @@withdrawal_total = 0.0
  @@withdrawal_count = 0

  public

  def initialize(file="assignment02-input.csv")
    @transactions = read_file(file).each
  end

  def read_file(file)
    transactions = []
    fh = File.open(file)
    csv_data = fh.read
    fh.close
    csv_data.each_line.map do |line|
      entry = line.split(",")
      unless entry[0].include?("date")
        dat = entry[0]
        src = entry[1]
        amt = entry[2]
        if entry[3].include?("withdrawal")
          transaction = WithdrawalTransaction.new(dat, src, amt)
          @@withdrawal_total = transaction.total
          @@withdrawal_count = transaction.count
        else
          transaction = DepositTransaction.new(dat, src, amt)
          @@deposit_total = transaction.total
          @@deposit_count = transaction.count
        end
        transactions << transaction
      end
    end
    transactions
  end


  def summary
    html_h2 { puts "Summary:" }
    html_table {
      html_trow {
        html_tcell { puts "Starting Balance" }
        html_tcell { puts "$#{@@starting_balance.to_f.round(2)}" }
      }
      html_trow {
        html_tcell { puts "Total Deposits" }
        html_tcell { puts "$#{@@deposit_total.to_f.round(2)}" }
      }
      html_trow {
        html_tcell { puts "Total Withdrawals" }
        html_tcell { puts "$#{@@withdrawal_total.to_f.round(2)}" }
      }
      html_trow {
        html_tcell { puts "Ending Balance" }
        html_tcell { puts "$#{(@@deposit_total - @@withdrawal_total).to_f.round(2)}" }
      }
    }
  end

  def withdrawals
    html_h2 { puts "Withdrawals:" }
    dates = sort_dates(@transactions).uniq
    html_table {
      dates.each do |day|
        @transactions.each do |transaction|
          if transaction.amount.to_i < 0 && day == transaction.date
            html_trow {
              html_tcell { puts "#{anglify_date(transaction.date)}" }
              html_tcell { puts "#{transaction.source}" }
              html_tcell { puts "$#{transaction.amount.to_f.round(2)}" }
            }
          end
        end
      end
    }
  end

  def deposits
    html_h2 { puts "Deposits:" }
    dates = sort_dates(@transactions).uniq
    html_table {
      dates.each do |day|
        @transactions.each do |transaction|
          if transaction.amount.to_i > 0 && day == transaction.date
            html_trow {
              html_tcell { puts "#{anglify_date(transaction.date)}" }
              html_tcell { puts "#{transaction.source}" }
              html_tcell { puts "$#{transaction.amount.to_f.round(2)}" }
            }
          end
        end
      end
    }
  end

  def daily_balance
    html_h2 { puts "Daily Balances:" }
    running_total = 0.0
    dates = sort_dates(@transactions).uniq
    html_table {
      dates.each do |day|
        @transactions.each do |transaction|
          if day == transaction.date
            running_total += transaction.amount.to_f 
          end
        end
        html_trow {
          html_tcell { puts "#{anglify_date(day)}" }
          html_tcell { puts "$#{running_total.to_f.round(2)}" }
        }
      end
    }
  end


  private

  def html_h1
    puts "<h1>"
    yield
    puts "</h1>"
  end

  def html_h2
    puts "<h2>"
    yield
    puts "</h2>"
  end

  def html_table
    puts "<table width=300>"
    yield
    puts "</table>"
  end

  def html_trow
    puts "<tr>"
    yield
    puts "</tr>"
  end

  def html_tcell
    puts "<td cellpadding=4 align=left>"
    yield
    puts "</td>"
  end

  def anglify_date(d)
    year, month, day = d.split("-")
    "#{month}/#{day}/#{year}"
  end

  def sort_dates(t)
    array = []
    dates = t.each do |transaction|
      array << transaction.date
    end
    array.sort { |a, b| a <=> b }
  end

end


class Transaction
  attr :date, :source, :amount
  public
  def initialize(date, source, amount)
    @date = t_date(date)
    @source = source
    @amount = amount.to_f.round(2)
  end

  private
  def t_date(date)
    month, day, year = date.split("/")
    month = month.to_s.rjust(2, "0")
    day = day.to_s.rjust(2, "0")
    "#{year}-#{month}-#{day}"
  end
end

class DepositTransaction < Transaction
  @@deposit_total = 0
  @@deposit_count = 0
  def initialize(date, source, amount)
    @@deposit_count += 1
    @@deposit_total += amount.to_f.round(2)
    super
  end
  def count
     @@deposit_count
  end
  def total
     @@deposit_total
  end
end

class WithdrawalTransaction < Transaction
  @@withdrawal_total = 0
  @@withdrawal_count = 0
  def initialize(date, source, amount)
    @@withdrawal_count +=1
    @@withdrawal_total += amount.to_f.round(2)
    amount = (amount.to_f * -1)
    super
  end
  def count
     @@withdrawal_count
  end
  def total
     @@withdrawal_total
  end
end

myacc = BankAccount.new

myacc.summary
myacc.withdrawals
myacc.deposits
myacc.daily_balance


