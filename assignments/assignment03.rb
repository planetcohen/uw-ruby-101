# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

# re-implement titleize and palindrome? as methods on String

class String
  def titleize
    return self.split.map(&:capitalize).join(' ')
  end

  def palindrome?
    s = self.gsub(" ","").gsub(",","").downcase
    s == s.reverse
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
   return self.join("") if self.length < 2	
   return "#{self.join(", ")} and #{self.pop}"	# String interpolated join + pop last value
  end

  def mean
   self.inject(:+) / self.size.to_f # divide by the number of numbers by the size
  end

  def median
   s = self.sort! # Numbers list in numerical order	
   l = self.length # What are we working with?
   if l.odd? # Easy Middle?
  	 s[l/2] # Yay, Easy Middle!
   else
     return "#{ (s[l/2] + s[-1+l/2]) / 2}" #Middle Pair Calc halfway between
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

class BankAccount
 require 'csv'
 require 'date'

	def import
		@trans = CSV.read('C:\Users\01\Desktop\assignment02-input.csv', headers:true, header_converters: :symbol, converters: :all).collect { |row| Hash[row.collect {|col,row| [col,row] }] }

	end

	def starting_balance
		"0"
	end

	def ending_balance
		deposits_total - withdrawals_total
	end

	def withdrawals
      @trans.select {|t| t[:type] == "withdrawal" }.group_by {|t| t[:date]}
	end

	def withdrawals_total
	  withdrawals_total = trans.select {|t| t[:type] == "withdrawal" }.inject(0) {|sum, hash| sum + hash[:amount]}
	end
    
    def deposits
      @trans.select {|t| t[:type] == "deposit" }.group_by {|t| t[:date]}
    end

    def deposits_total
      @trans.select {|t| t[:type] == "deposit" }.inject(0) {|sum, hash| sum + hash[:amount]}
    end

    def daily_balance
      d = @trans.sort {|d1, d2| d1[:date] <=> d2[:date] }.uniq
    end

    def to_html
      # open for writing:
      html = render_html("Statement", withdrawals, deposits, summary)
      output = File.open('C:\Users\01\Desktop\Homework4.html', "w+") do |output|
      output.write html
        end
      output.close
    end

    def render_html(title, records)
    <<HTML
     <!doctype html>
     <html>
       #{render_head title}
       #{render_body withdrawals, deposits, summary}
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
    <td> #{r[:date]}</td>
    <td> #{r[:payee]}</td>
    <td> #{r[:amount]}</td>
    <td> #{r[:type]}</td>   
   </tr>
  RECORD
  end


end

class Transaction < BankAccount
	def deposit

    end
end
	
class DepositTransaction < Transaction
	def deposit

    end
end

class WithdrawalTransaction < Transaction
	def Withdrawal

    end
end

# instead of using hashes, create classes to represent:
# - BankAccount
# - Transaction
# - DepositTransaction
# - WithdrawalTransaction

# use blocks for your HTML rendering code
