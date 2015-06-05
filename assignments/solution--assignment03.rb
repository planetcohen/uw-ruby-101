# ========================================================================================
# Assignment 3
# ========================================================================================

# ========================================================================================
#  Problem 1 - re-implement titleize, palindrome?

class String
	def titleize
		words = split.collect {|word| word.downcase!.capitalize! }
		words.join(" ")
	end
	def palindrome? 
		string1 = downcase.delete(", ")
		string2 = string1.reverse
		string1 == string2
	end
end
# re-implement titleize and palindrome? as methods on String
"hEllo WORLD".titleize                         #=> "Hello World"
"gooDbye CRUel wORLD".titleize                 #=> "Goodbye Cruel World"

"abba".palindrome?                             #=> true
"aBbA".palindrome?                             #=> true
"abb".palindrome?                              #=> false

"Able was I ere I saw elba".palindrome?        #=> true
"A man, a plan, a canal, Panama".palindrome?   #=> true


# ========================================================================================
#  Problem 2 - re-implement mean, median, to_sentence
class Array
	def mean
		sum = self.inject {|sum, num| sum += num}
		sum / self.length.to_f
	end

	def median
		if self.length % 2 != 0
			self[self.length/2]
		else
			p = self.length/2
			((self[p-1] + ary[p]) / 2.0)
		end
	end

	def to_sentence
		if self.length == 0
			"" if self.empty?
		elsif self.length == 1
			self[0]
		else
			a = self.pop
			str = self.join(", ") + " and #{a}"
		end
	end
end
# re-implement mean, median, to_sentence as methods on Array

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
	def initialize(balance=0, total_deposits=0, total_withdrawals=0)
		@file = File.open("assignment02-input.csv", "r")
		@output = File.open("bankStatement_2.html", "w")
		@balance = balance
		@total_deposits = total_deposits
		@total_withdrawals = total_withdrawals
		@trans_bag = []
	end
	def method_missing(m, *args, &block) 
		puts "There is no such a method"
	end

	private
	def sort_transactions
		@file.each do |item|
			@trans_bag << item.split(",")
		end
		@trans_bag.each {|i| i.insert(0, i[0].to_s.split("/")[1]); i[0] = i[0].to_i}
		@trans_bag.shift; @trans_bag = @trans_bag.sort;

		@trans_bag.each {|item| @total_deposits += item[3].to_f if item[4].include?("deposi")}
		@trans_bag.each {|item| @total_withdrawals += item[3].to_f if item[4].include?("withdrawa")}
	end
	def create_html
		@output.puts <<-RECORDS
		<html>
			<head>
				<title>Bank Statement</title>
				<style>
					h1,h2,h3,th,td, p {font-family: arial}
					h3 {font-size: 16px}
					body {font-size:12px}
					td {padding:6px 16px}
					th {text-align:rignt; padding: 8px 16px}
					td {text-align:right}
					table, th, td {
					border: 1px solid #ccc;
					border-collapse: collapse;
					}
				</style>
			</head>
		<body>
		RECORDS
	end
	
	public
	def summary
		sort_transactions
		create_html
		@output.puts "<h1> SUMMARY </h1>"
		@output.puts "<table>"
		@output.puts "<tr><th>Date</th><th>Deposits</th><th>Withdrawals</th></tr>"
  		@output.puts "<tr><td><strong>Total</strong></td> <td><strong>$#{(@total_deposits * 100).round/100.0}</strong></strong></td><td><strong>$#{(@total_withdrawals * 100).round/100.0}</strong></td></tr>"
		@output.puts "</table>"
	end
	def deposits
		sort_transactions
		@output.puts "<h1> DEPOSITS </h1>"
		@output.puts "<table>"
  		@output.puts "<tr><th>Date</th><th>Deposits</th></tr>"
		@trans_bag.each do |item|
	    	if item[4].include?("deposit")
	      		@balance += item[3].to_f
				@output.puts "<tr><td>#{item[1]}</td><td>$#{item[3]}</td></tr>"
		    else
		      @balance -= item[3].to_f
			end
		end
		@output.puts "<tr><td><strong>Total</strong></td><td><strong>$#{@total_deposits}</strong></td></tr>"
		@output.puts "</table>"
	end
	def withdrawals
		sort_transactions
		@output.puts "<h1> WITHDRAWALS </h1>"
		@output.puts "<table>"
  		@output.puts "<tr><th>Date</th><th>Withdrawals</th></tr>"
		@trans_bag.each do |item|
	    	if item[4].include?("withdraw")
	      		@balance -= item[3].to_f
				@output.puts "<tr><td>#{item[1]}</td><td>$#{item[3]}</td><td>$#{(@balance * 100).round/100.0}</td></tr>"
		    else
		      @balance += item[3].to_f
			end
		end
		@output.puts "<tr><td><strong>Total</strong></td><td><strong>$#{(@total_withdrawals * 100).round / 100.0}</strong></td></tr>"
		@output.puts "</table>"
	end
end


class Transaction < BankAccount
	def transaction
		sort_transactions
		create_html
		@output.puts "<h1> TRANSACTIONS </h1>"
		@output.puts "<tr><th>Date</th><th>Deposits</th><th>Withdrawals</th><th>Balance</th></tr>"
		@trans_bag.each do |item|
			if item[4].include?("withdraw")
				@balance -= item[3].to_f
				@output.puts "<tr><td>#{item[1]}</td> <td> _ </td><td>$#{item[3]}</td><td>$#{(@balance * 100).round/100.0}</td></tr>"
			else
				@balance += item[3].to_f
				@output.puts "<tr><td>#{item[1]}</td> <td>$#{item[3]}</td><td> _ </td><td>$#{(@balance * 100).round/100.0}</td></tr>"
			end
		end
  		@output.puts "<tr><td><strong>Total</strong></td> <td><strong>$#{(@total_deposits * 100).round/100.0}</strong></strong></td><td><strong>$#{(@total_withdrawals * 100).round/100.0}</strong></td><td><strong>$#{(@balance * 100).round/100.0}</strong></td></tr>"
	end
end

# class DepositTransaction < BankAccount
# 	def deposits
# 		deposits
# 	end
# end

# class WithdrawalTransaction < BankAccount
# 	def withdrawals
# 		withdrawals
# 	end
# end

account = BankAccount.new
account.summary
account.withdrawals
account.deposits

# tr = Transaction.new
# tr.transaction


