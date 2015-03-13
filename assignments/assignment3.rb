#THIS IS JUST THE CSV TO HTML CLASSES VERSION

#Bank Account class that initializes an account with its file source and starting balance
class BankAccount

	attr_accessor :starting_balance

	def initialize(account_file, starting_balance, withdrawal_or_deposit_side)
		@starting_balance = starting_balance
		if withdrawal_or_deposit_side == "withdrawal_side"
			Transaction.new(account_file, @starting_balance, "withdrawal_side")
		elsif withdrawal_or_deposit_side == "deposit_side"
			Transaction.new(account_file, @starting_balance, "deposit_side")
		end
	end
end

#Transaction Class that separates transactions by withdrawal or deposit
class Transaction

	attr_accessor :withdrawals, :deposits, :starting_balance

	def initialize(account_file, starting_balance, withdrawal_or_deposit_side)
		@starting_balance = starting_balance
		if withdrawal_or_deposit_side == "withdrawal_side"
			File.open(account_file) do |file|
				lines = file.readlines
				separation_processes = lines.shift.chomp.split(",")
				@withdrawals = []
				lines.each do |transaction|
					if transaction.include?("withdrawal")
						@withdrawals << transaction
					end
				end
			end
			WithdrawalTransaction.new(@withdrawals, @starting_balance).render_withdrawal_summary
		elsif withdrawal_or_deposit_side == "deposit_side"
			File.open(account_file) do |file|
				lines = file.readlines
				separation_processes = lines.shift.chomp.split(",")
				@deposits = []
				lines.each do |transaction|
					if transaction.include?("deposit")
						@deposits << transaction
					end
				end
			end
			DepositTransaction.new(@deposits, @starting_balance).render_deposit_summary
		end
	end
end

#Deposit Transaction Class that inherits from Transaction
class DepositTransaction < Transaction

	attr_accessor :starting_balance, :sum_of_deposits, :deposits

	def initialize(deposits, starting_balance)
		@deposits = deposits
		@starting_balance = starting_balance
		array_of_deposits = @deposits.map {|i| i.split(",")}.flatten!
		array_of_deposits.delete_if {|item| item.to_f == 0 || item.include?("/")}
		array_of_deposit_floats = array_of_deposits.map {|i| i.to_f}
		@sum_of_deposits = array_of_deposit_floats.inject(:+)
	end

	def render_deposit_summary
		@deposits
		@sum_of_deposits
	end
end

#Withdrawal Transaction Class that inherits from Transaction
class WithdrawalTransaction < Transaction

	attr_accessor :starting_balance, :sum_of_withdrawals, :withdrawals

	def initialize(withdrawals, starting_balance)
		@withdrawals = withdrawals
		@starting_balance = starting_balance
		@withdrawals
		array_of_withdrawals = @withdrawals.map {|i| i.split(",")}.flatten!
		array_of_withdrawals.delete_if {|item| item.to_f == 0 || item.include?("/")}
		array_of_withdrawals_floats = array_of_withdrawals.map {|i| i.to_f}
		@sum_of_withdrawals = array_of_withdrawals_floats.inject(:+)
	end

	def render_withdrawal_summary
		@withdrawals
		@sum_of_withdrawals
	end
end

#Class that calculates the final balance after all transactions
class BankAccountBalance
	attr_accessor :finito

	def initialize(starting_balance, deposits, withdrawals)
		@final_bal = starting_balance+deposits-withdrawals
	end
end

#Class that renders HTML
class HtmlRender

	def render_html
		<<-HTML
			<html>
				<head>
					<title>Bank Account Statement</title>
				</head>

	  	<body>

				<h5>List of Withdrawals</h5>
				#{Transaction.new("csv.csv", 0.0, "withdrawal_side").withdrawals}
				
				<h3>Sum of Withdrawal Transactions, in USD($)</h3>
				#{WithdrawalTransaction.new(Transaction.new("csv.csv", 0.0, "withdrawal_side").withdrawals, 0.0).sum_of_withdrawals.to_f}

				<h5>List of Deposits</h5>
				#{Transaction.new("csv.csv", 0.0, "deposit_side").deposits}

				<h3>Sum of Deposit Transactions, in USD($)</h3>
				#{DepositTransaction.new(Transaction.new("csv.csv", 0.0, "deposit_side").deposits, 0.0).sum_of_deposits.to_f}

				<h5>Starting Balance, in USD($)</h5>
				#{BankAccount.new("csv.csv", 0.0, "").starting_balance}

				<h5>Ending Balance, in USD($)</h5>
				#{BankAccountBalance.new(BankAccount.new("csv.csv", 0.0, "").starting_balance.to_f,
				 DepositTransaction.new(Transaction.new("csv.csv", 0.0, "deposit_side").deposits, 0.0).sum_of_deposits.to_f,
				  WithdrawalTransaction.new(Transaction.new("csv.csv", 0.0, "withdrawal_side").withdrawals, 0.0).sum_of_withdrawals.to_f).final_bal}
			</body>
		</html>
		HTML
	end
end

#Method that Modifies the csv file and overwrites it as HTML
def create_html_file(some_file)
	File.open("csv.csv", "w") do |file|
	file.write some_file
	end
end

#Program execution
start = HtmlRender.new
#create_html_file(start.render_html)
