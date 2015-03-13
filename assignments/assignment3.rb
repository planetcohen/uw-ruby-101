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

#========== ASSIGNMENT 6

class PriorityQueue
	def initialize
		@high_hash = {}
		@medium_hash = {}
		@low_hash = {}
	end

	def enqueue(item, priority=:medium)
		if priority == :high
			@high_hash[item] = priority
		elsif priority == :medium
			@medium_hash[item] = priority
		elsif priority == :low
			@low_hash[item] = priority
		end
	end

	def dequeue
		if ! @high_hash.empty?
			@high_hash.shift
		elsif ! @medium_hash.empty?
			@medium_hash.shift
		elsif ! @low_hash.empty?
			@low_hash.shift
		end
	end

	def empty?
		if @high_hash.empty? and @medium_hash.empty? and @low_hash.empty?
			return true
		else
			return false
		end
	end

	def peek
		if ! @high_hash.empty?
			@high_hash.keys[0]
		elsif ! @medium_hash.empty?
			@medium_hash.keys[0]
		elsif ! @low_hash.empty?
			@low_hash.keys[0]
		end
	end

	def length
		@high_hash.count + @medium_hash.count + @low_hash.count
	end
end

class PriorityTest < Minitest::Test

	def test_hacker
		pq = PriorityQueue.new
		assert_empty pq
		assert_equal pq.enqueue("first"), :medium
		refute_empty pq
		assert_equal pq.enqueue("top", :high), :high
		assert_equal pq.enqueue("last", :low), :low
		assert_equal pq.enqueue("second"), :medium
		assert_equal pq.enqueue("another top", :high), :high
		assert_equal pq.length, 5
		assert_equal pq.dequeue[0], "top"
		assert_equal pq.dequeue[0], "another top"
		assert_equal pq.dequeue[0], "first"
		assert_equal pq.dequeue[0], "second"
		assert_equal pq.dequeue[0], "last"
	end
end

#============================== RECIPE TO DSL, HW 6 PROBLEM 2

class Recipe
	attr_accessor :steps, :ingredients, :name, :category, :prep_time, :rating
	def initialize(name, ingredients, prep_time, category, rating, steps)
		@name = name
		@ingredients = ingredients
		@prep_time = prep_time
		@category = category
		@rating = rating
		@steps = steps
	end

	def recipe_name
		@name.map {|nam| "-#{nam}"}
	end
	
	def recipe_ingredients
		@ingredients.map {|ing| "- #{ing}"}
	end

	def recipe_prep_time
		@prep_time.map {|pt| "- #{pt}"}
	end

	def recipe_category
		@category.map {|cat| "-#{cat}"}
	end

	def recipe_rating
		@rating.map {|rate| "- #{rate}"}
	end

	def recipe_steps
		@steps.map {|stp| "- #{stp}"}
	end

	def render_dsl
		html do
			head do
				title Recipe
				stylesheet_link_tag 'scaffold'
			end
			
			body do
				"#{recipe_name}"
				"#{recipe_prep_time}"
				"#{recipe_category}"
				"#{recipe_rating}"
				"#{recipe_ingredients}"
				"#{recipe_steps}"
			end
		end
	end
end

ingred = ["tortilla", "ground beef", "guac", "cheese"]
nombr = ["The Texas Taco"]
categ = ["TexMex"]
prep_t = ["15 minutes"]
rated = ["8 out of 10"]
stepp = ["cook ground beef", "cut guac", "spread equal amounts of each #{ingred[1]},
#{ingred[2]}, and #{ingred[3]} on a #{ingred[0]}"]

new_recipe = Recipe.new(ingred, nombr, categ, prep_t, rated, stepp)
new_recipe.render_dsl

#======== ASSIGNMENT #7

#================================ #ASSIGNMENT 7

module Observable

	def add_observer(obj)
		@observed_objects << obj if !@observed_objects.include?(obj)
	end

	def delete_observer(obj)
		@observed_objects.delete(obj)
	end

	def delete_observers
		@observed_objects.clear
	end

	def count_observers
		@observed_objects.count
	end

	def changed(new_state=true)
		@changed = new_state
	end

	def changed?
		if @changed.nil?
			@changed = false
		end
		@changed
	end

	def notify_observers(*args)
		if changed?
			@observed_objects.each {|observed_object| observed_object.update(*args)}
			@changed = false
		end
	end
end

class PressureTransducer
	include Observable

	def initialize(initial_pressure_atm)
		@pressure = initial_pressure_atm
		@observed_objects = []
		#@change_status = false
		#@observed_objects = []
		#@pressure = initial_pressure_atm
		#add_observer(@pressure)
	end

	def pressuring
		last_pressure = nil
		loop do
			pressure = Pressure.fetch(@pressure)
			if pressure != last_pressure
				changed
				last_pressure = pressure
				notify_observers(Time.now, pressure)
			end
			sleep 1
		end
	end

	def pressure_up
		#changed
		@pressure = @pressure + 1
		#changed
		#notify_observers(@pressure)
	end

	def pressure_down
		@pressure = @pressure - 1
		#changed
		#notify_observers(@pressure)
	end
end

class Pressure
	def Pressure.fetch(press)
		12 + rand(1..10)
	end
end

class PressureWarningHigh
	def initialize(pressure_transducer, limit)
		@limit = limit
		pressure_transducer.add_observer(self)
	end

	def update(flow, pressure)
		if pressure > @limit
			puts "Pressure limit has been exceeded. She is going to blow, fellas! Run!"
		end
	end
end

class ObservableTest < Minitest::Test
	def test_hacker
		pressure_transducer = PressureTransducer.new(12)
		assert_equal pressure_transducer.count_observers, 0
		assert_equal pressure_transducer.pressure_up, 13
		assert_equal pressure_transducer.pressure_down, 12
	end
end

#=============================================== ASSIGNMENT #8
class RomanNumeral
	def initialize(i)
		@i = i
		@roman_hash = {100=>"C", 90=>"XC",50=>"L",40=>"XL",10=>"X",9=>"IX",
		5=>"V",4=>"IV",1=>"I"}
		@roman_num = ""
	end

	def to_s
		@roman_hash.keys.each do |n|
			q,m = @i.divmod(n)
			@roman_num << @roman_hash[n] * q
			@i = m
		end
		@roman_num
	end

	def to_i
		#COMPLETE THIS SECTION IF TIME REMAINS
	end

	def self.from_string
		#COMPLETE THIS SECTION IF TIME REMAINS
	end
end

class RomanTest < MiniTest::Test
	def test_hacker
		assert_equal "I", RomanNumeral.new(1).to_s
		assert_equal "II", RomanNumeral.new(2).to_s
		assert_equal "III", RomanNumeral.new(3).to_s
		assert_equal "IV", RomanNumeral.new(4).to_s
		assert_equal "V", RomanNumeral.new(5).to_s
		assert_equal "VI", RomanNumeral.new(6).to_s
		assert_equal "IX", RomanNumeral.new(9).to_s
		assert_equal "X", RomanNumeral.new(10).to_s
		assert_equal "XIX", RomanNumeral.new(19).to_s
		assert_equal "XXXII", RomanNumeral.new(32).to_s
		assert_equal "LI", RomanNumeral.new(51).to_s
	end
end

#============================================= ASSIGNMENT #8, problem 2

def golden_ratio(precision)
=begin
I decided to use the mathematical definition of the golden
ratio, which is golden_ratio = .5*(1+sqrt(5))
=end
	square = Math.sqrt(5)+1
	golden_r = (square/2)
	golden_r_prec = golden_r.round(precision)
	return golden_r_prec
end

class GoldenTest < MiniTest::Test
	def test_hacker
		assert_equal 1.62, golden_ratio(2)
		assert_equal 1.61803, golden_ratio(5)
		assert_equal 1.61803399, golden_ratio(8)
	end
end

#======================================== GAME OF LIFE

class GameOfLife  
   
  attr_reader :matrix
 
  #==========SET UP GAME MATRIX
  def initialize(rows, columns, input)
    @matrix = rows.times.map do |y| 
      columns.times.map do |x| 
        Cell.new(self, x, y, rand(input).to_i.even?)
      end
    end
  end
  
  #==========GAME ENGINE ON INFINITE LOOP
  def play
    while(true)
      system('clear')
      render_board
      board_update
      sleep(5)
    end
  end

  #======= METHOD ONLY USED TO VALIDATE TESTS
  def play_test

    cel = [cell_location(2, 2), cell_location(3, 2), cell_location(4, 2),
    cell_location(2, 3  ),                       cell_location(4, 3  ),
    cell_location(2, 4), cell_location(3, 4), cell_location(4, 4)]
    #STILL NEED TO FINISH TESTING ENTIRELY

    puts cell_location(3, 3)
    render_board
    board_update
    puts cell_location(3, 3)
  end
 
  #============DISPLAYS BOARD RESULTS
  def render_board
    board_row = "%" * (matrix.first.size * 2 + 3)
    [
      "\n"*4,
      board_row,
      matrix.map{|row| "% " + row.join(" ") + " %" },
      board_row,
    ].flatten.each do |line| 
      puts line
    end
  end
 
  #================UPDATES BOARD RESULTS FOR NEXT ROUND
  def board_update
    matrix.each do |row|
      row.each do |cell|
        cell.board_updates
      end
    end
  end
  
  #================CELL LOCATIONS
  def cell_location(x, y)
    matrix.fetch(y){[]}[x]
  end
end
 
class Cell
 
  attr_reader :x, :y, :game, :living, :neighbors
  
  #==================INITIALIZES STATES OF EACH CELL
  def initialize(game, x, y, state)
    @game = game
    @x = x
    @y = y
    @living = state
  end
  
  def dead
    @living = false
  end
  
  def rebirth
    @living = true
  end
  
  def is_cell_alive?
    @living == true
  end
 
  def dead?
    !is_cell_alive?
  end
  
  #================DEFINES NEIGHBORING CELLS
  def neighbors
    @neighbors ||= begin
      [
        game.cell_location(x-1, y-1), game.cell_location(x, y-1), game.cell_location(x+1, y-1),
        game.cell_location(x-1, y  ),                       game.cell_location(x+1, y  ),
        game.cell_location(x-1, y+1), game.cell_location(x, y+1), game.cell_location(x+1, y+1)
      ].compact
    end
  end
  
  def live_neighbors
    neighbors.select(&:is_cell_alive?)
  end
  
  def under_populated?
    is_cell_alive? and live_neighbors.size < 2
  end  
  
  def over_populated?
    is_cell_alive? and live_neighbors.size > 3  
  end  
  
  def to_be_reproduced?
    dead? and live_neighbors.size == 3  
  end
 
  #===============UPDATES THE STATUS OF EACH CELL
  def board_updates
    if under_populated? 
      dead
    elsif over_populated?
      dead
    elsif to_be_reproduced?
      rebirth
    end  
  end
  
  def to_s
    is_cell_alive? ? "x" : " "
  end
end

#================INITIATE GAME PLAY(COMMENTED OUT TO ALLOW FOR TESTING)
#new_game = GameOfLife.new(10,10,Time.now.to_i)
#new_game.play
#new_game.play_test

class GameOfLifeTesting < Minitest::Test
  def test_hacker
    new_game = GameOfLife.new(10,10,Time.now.to_i)
    refute_empty new_game.matrix
  end
end
