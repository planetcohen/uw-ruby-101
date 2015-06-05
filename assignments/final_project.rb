# ========================================================================================
#  Final Project: Game of Life
# ========================================================================================

#  The Game of Life is a simplified model of evolution and natural selection
#  invented by the mathematician James Conway.

#  http://en.wikipedia.org/wiki/Conway's_Game_of_Life


#  ---------------------------------------------------------------------------------------
#  Rules

#  You have a grid of cells in 2 dimensions.

#  Each cell has 8 neighbors:
#  - top, right, bottom, left
#  - top-left, top-right, bottom-right, bottom-left

#  Each cell has 2 possible states: alive or dead.

#  if a cell is alive and
#  - has fewer than 2 live neighbors, it dies 
#  - has more than 3 live neighbors, it dies
#  - has 2 or 3 live neighbors, it lives to next generation

#  if cell is dead and
#  - has exactly 3 live neighbors, it becomes a live cell

#  edges of board:
#  - pretend the board is folded onto itself
#  - the edges touch each other


#  ---------------------------------------------------------------------------------------
#  Tests

#  You must have MiniTest unit tests for your class to validate your implementation.
#  You might need to add methods or change the method signatures to enable testing.


#  ---------------------------------------------------------------------------------------
#  Rendering

#  You choose how you want to render the current state of the board.
#  ASCII? HTML? Something else?


#  ---------------------------------------------------------------------------------------
#  Bonus: DSL

#  - Create a DSL that represents a state of the game.
#  - Your render method can then be formatted as the DSL, so that you can round-trip
#    between the textual DSL representation and the running instance.


#  ---------------------------------------------------------------------------------------
#  Suggested Implementation

module FinalProject
	class GameOfLife
		attr_accessor :size, :cols, :rows, :cell_grid, :run_time
		def initialize(size, run_time)
			@size  = size
			@cols = cols
			@rows = rows
			@run_time = run_time
			@cell_grid = Array.new(size) { |rows| Array.new(size) { |cols| Cell.new(rows, cols) }} # Creates new cell object with dead cells
			@cell_grid.each { |cell_bag|; (@size).times { cell_bag[rand(cell_bag.length)].live } } # Randomly makes cells alive

			run(@run_time) # Invoking the run method to run @run_time number of times
  		end

	  	def evolve
	  		@cell_grid.each_with_index do |cell_bag, index1|
	  			cell_bag.each_with_index do |cell, index2|

					#------ neighbours
					index1 == 0 ? north = @cell_grid[cell.x + (@size - 1)][index2] : north = @cell_grid[cell.x - 1][index2] # North neighbour
					index1 == @size - 1 ? south = @cell_grid[cell.x - (@size - 1)][index2] : south = @cell_grid[cell.x + 1][index2] # South neighbour
					index2 == 0 ? west = @cell_grid[index1][cell.y + (@size - 1)] : west = @cell_grid[index1][cell.y - 1] # West neighbour
					index2 == (@size - 1) ? east = @cell_grid[index1][cell.y - (@size - 1)] : east = @cell_grid[index1][cell.y + 1] # East neighbour

					#------ neighbours
					index1 == 0 ? north_west = @cell_grid[index1 + (@size - 1)][north.y - 1] : north_west = @cell_grid[index1 - 1][north.y - 1] # North west neighbour
					index1 == 0 ? north_east = @cell_grid[index1 + (@size - 1)][east.y] : north_east = @cell_grid[index1 - 1][east.y] # North east neighbour
					index1 == (@size - 1) ? south_west = @cell_grid[index1 - (@size - 1)][south.y - 1] : south_west = @cell_grid[index1 + 1][south.y - 1] # South west neighbour
					index1 == (@size - 1) ? south_east = @cell_grid[index1 - (@size - 1)][east.y] : south_east = @cell_grid[index1 + 1][east.y] # South east neighbour
					
					alive_cells = [] # Alive cells array

					if cell.alive?
						alive_cells << north if north.alive? # add to alive_cells array if north neighbour is alive
						alive_cells << south if south.alive? # add to alive_cells array if south neighbour is alive
						alive_cells << east if east.alive? # add to alive_cells array if east neighbour is alive
						alive_cells << west if west.alive? # add to alive_cells array if west neighbour is alive

						alive_cells << north_west if north_west.alive? # add to alive_cells array if north_west neighbour is alive
						alive_cells << north_east if north_east.alive? # add to alive_cells array if north_east neighbour is alive
						alive_cells << south_west if south_west.alive? # add to alive_cells array if south_west neighbour is alive
						alive_cells << south_east if south_east.alive? # add to alive_cells array if south_east neighbour is alive
					end

					#------ rules
					cell.die if cell.alive? and alive_cells.length < 2 # - Alive and has fewer than 2 live neighbors, it dies 
					cell.die if cell.alive? and alive_cells.length > 3 # - Alive and has more than 3 live neighbors, it dies
					cell.live if cell.alive? and (alive_cells.length == 2 || alive_cells.length == 3) # - Alive and has 2 or 3 live neighbors, it lives to next generation
					cell.live if cell.dead? and alive_cells.length == 3 # - Dead and has exactly 3 live neighbors, it becomes a live cell
				end
			end
			render; puts "" # calls the render method to render the new state of the board
		end

		def render
			@cell_grid.each { |cell_bag| cell_bag.each_with_index { |cell, index| if cell.alive? then print "* " else print "- " end }; puts "" } # Rendering the current state of the board
		end

		def run(num_generations)
			render; puts ""; count = 1
			while count < num_generations; evolve; count += 1; end # runs for a run_time times
		end
	end

	class Cell
		attr_accessor :x, :y, :alive
		def initialize(x=0, y=0)
			@x = x
			@y = y
			@alive = false
		end

		def alive?
			@alive == true
		end

		def dead?
			@alive == false
		end

		def die 
			@alive = false
		end

		def live
			@alive = true
		end
	end
end

#------
# playGame = FinalProject::GameOfLife.new(20, 5)
#------

require 'minitest/autorun'
class GameOfLife < MiniTest::Test
	def setup
		@game = FinalProject::GameOfLife.new(20, 5)
		@cell = FinalProject::Cell.new(3, 3)
	end

	def test_class
		assert_instance_of FinalProject::GameOfLife, @game
		assert_instance_of FinalProject::Cell, @cell
	end

	def test_game_attributes
	    assert @game.respond_to?(:size)
	    assert @game.respond_to?(:cols)
	    assert @game.respond_to?(:rows)
	    assert @game.respond_to?(:run_time)
	    assert @game.respond_to?(:cell_grid)
	end

	def test_game
	    assert_kind_of Array, @game.cell_grid
	    assert_kind_of Array, @game.cell_grid.each {|cell_bag| cell_bag}
		
		assert_equal @game.size, @game.cell_grid.size
		@game.cell_grid.each {|cell_bag| assert_equal @game.size, cell_bag.size}

		@game.cell_grid.each_with_index do |cell_bag, index1|
			cell_bag.each_with_index do |cell, index_2|

				assert_kind_of Array, cell_bag
				assert_instance_of FinalProject::Cell, cell
			    
			    assert cell.respond_to?(:x)
			    assert cell.respond_to?(:y)
			    assert cell.respond_to?(:alive)
			end
		end
	end

	def test_game_neighbours
		@game.cell_grid.each_with_index do |cell_bag, index1|
			cell_bag.each_with_index do |cell, index2|
				# testing north
				index1 == 0 ? north = @game.cell_grid[cell.x + (@game.size - 1)][index2] : north = @game.cell_grid[cell.x - 1][index2] # North neighbour
				assert_instance_of FinalProject::Cell, north
				assert_equal north.x, (cell.x - 1) if index1 != 0
				
				# testing south
				index1 == @game.size - 1 ? south = @game.cell_grid[cell.x - (@game.size - 1)][index2] : south = @game.cell_grid[cell.x + 1][index2] # South neighbour
				assert_instance_of FinalProject::Cell, south
				assert_equal south.x, (cell.x + 1) if index1 != (@game.size - 1)

				# testing west
				index2 == 0 ? west = @game.cell_grid[index1][cell.y + (@game.size - 1)] : west = @game.cell_grid[index1][cell.y - 1] # West neighbour
				assert_instance_of FinalProject::Cell, west
				assert_equal west.y, (cell.y - 1) if index2 != 0

				# testing east
				index2 == (@game.size - 1) ? east = @game.cell_grid[index1][cell.y - (@game.size - 1)] : east = @game.cell_grid[index1][cell.y + 1] # East neighbour
				assert_instance_of FinalProject::Cell, east
				assert_equal east.y, (cell.y + 1) if index2 != (@game.size - 1)

				# testing north west
				index1 == 0 ? north_west = @game.cell_grid[index1 + (@game.size - 1)][north.y - 1] : north_west = @game.cell_grid[index1 - 1][north.y - 1] # North west neighbour
				assert_instance_of FinalProject::Cell, north_west
				assert_equal north_west.y, (cell.y - 1) if index2 != 0

				# testing north east
				index1 == 0 ? north_east = @game.cell_grid[index1 + (@game.size - 1)][east.y] : north_east = @game.cell_grid[index1 - 1][east.y] # North east neighbour
				assert_instance_of FinalProject::Cell, north_east
				assert_equal north_east.x, (east.x - 1) if index1 != 0

				# testing south west
				index1 == (@game.size - 1) ? south_west = @game.cell_grid[index1 - (@game.size - 1)][south.y - 1] : south_west = @game.cell_grid[index1 + 1][south.y - 1] # South west neighbour
				assert_instance_of FinalProject::Cell, south_west

				# testing south east
				index1 == (@game.size - 1) ? south_east = @game.cell_grid[index1 - (@game.size - 1)][east.y] : south_east = @game.cell_grid[index1 + 1][east.y] # South east neighbour
				assert_instance_of FinalProject::Cell, south_east
			end
		end
	end

	def test_cell_attributes
	    assert @cell.respond_to?(:x)
	    assert @cell.respond_to?(:y)
	    assert @cell.respond_to?(:alive)
	end

	def test_cell
		assert_equal false, @cell.alive
		assert_equal @cell.alive?, false
		assert_equal @cell.dead?, true

		assert_equal @cell.live, true
		assert_equal @cell.die, false

		assert_equal 3, @cell.x
		assert_equal 3, @cell.y
	end
end
