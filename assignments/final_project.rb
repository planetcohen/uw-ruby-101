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
# Final project hosted here for redundancy https://github.com/clairmont/Game-Of-Life
# Final project video of it in progress: https://gfycat.com/FatalThoseHorse
# This project works best if split into the three logical parts, GameOfLife.rb, test_GameOfLife.rb and gosu_GameOfLife.rb
# Final project requires gosu gem installed for render class. I attempted making a proper Gemfile to include it.
# gosu installs via:
# gem install gosu
# http://www.libgosu.org/ if the gem install gives troubles


# Gemfile
source 'http://rubygems.org'

gem 'gosu'
##############
# GameOfLife.rb
# Game

class Game
	attr_accessor :world, :spawns

	def initialize(world=World.new, spawns=[])
	  @world = world
	  spawns.each do |spawn|
	    world.cell_grid[spawn[0]][spawn[1]].alive = true
	  end
	end

	def nextgen!
	  next_generation_respawn_cells = []
	  next_generation_kill_cells = []

	  @world.cells.each do |cell|
	  	around = self.world.living_neighborhood(cell).count
	  	# Rule 1: If a cell is alive and has fewer than 2 live neighbors, it dies
	  	 if cell.alive? and around < 2
	  	   next_generation_kill_cells << cell
	  	 end
	  	# Rule 2: If a cell is alive and has more than 3 live neighbors, it dies
	  	 if cell.alive? and around > 3
	  	   next_generation_kill_cells << cell
	  	 end
	  	# Rule 3: If a cell is alive and has 2 or 3 live neighbors, it lives to next generation
	  	 if cell.alive? and ([2,3].include? around)
	  	   next_generation_respawn_cells << cell
	  	 end
	  	# Rule 4: If a cell is dead and has exactly 3 live neighbors, it becomes a live cell
	  	 if cell.dead? and around == 3
	  	   next_generation_respawn_cells << cell
	  	 end

	  	 next_generation_respawn_cells.each do |cell|
	  	 	cell.respawn!
	  	 end

	  	 next_generation_kill_cells.each do |cell|
	  	 	cell.kill!
	  	 end
	  end
	end
end

class Cell
	attr_accessor :xcord, :ycord, :alive, :dead, :kill, :respawn

	def initialize(xcord=0, ycord=0); @xcord = xcord; @ycord = ycord; alive = false;  end
	def alive?; @alive ; end
	def respawn!; @alive = true; end
	def dead?; !alive; end
	def kill!; @alive = false; end
end

class World
	attr_accessor :rows, :cols, :cell_grid, :cells, :living

	def initialize(rows=3,cols=3)
		@rows = rows
		@cols = cols
		@cells = []

		@cell_grid = Array.new(rows) do |row|
			Array.new(cols) do |col|
				Cell.new(col, row)
			end
		end

		cell_grid.each do |row|
			row.each do |item|
				if item.is_a?(Cell)
				cells << item
				end
			end
		end
	end

	def living; cells.select { |cell| cell.alive}; end

	def instance
	  cells.each do |cell|
	  	cell.alive = [true, false, false, false, false, false, false].sample
		end
	end	

	def living_neighborhood(cell)
	  moore_neighborhood = []

	  #Detects a Neighbor to the North
	  if cell.ycord > 0
	  	detected = self.cell_grid[cell.ycord - 1][cell.xcord]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the North West
	  if cell.ycord > 0 and cell.xcord > 0
	  	detected = self.cell_grid[cell.ycord - 1][cell.xcord - 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the North East
	  if cell.ycord > 0 and cell.xcord < (cols - 1 )
	  	detected = self.cell_grid[cell.ycord - 1][cell.xcord + 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the South
	  if cell.ycord < (rows - 1)
	  	detected = self.cell_grid[cell.ycord + 1][cell.xcord]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the South West
	  if cell.ycord < (rows - 1) and cell.xcord > 0
	  	detected = self.cell_grid[cell.ycord + 1][cell.xcord - 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the South East
	  if cell.ycord < (rows - 1) and cell.xcord < (cols - 1 )
	  	detected = self.cell_grid[cell.ycord + 1][cell.xcord + 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the East
	  if cell.xcord < (cols - 1)
	  	detected = self.cell_grid[cell.ycord][cell.xcord + 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  #Detects a Neighbor to the West
	  if cell.xcord > 0
	  	detected = self.cell_grid[cell.ycord][cell.xcord - 1]
	  	moore_neighborhood << detected if detected.alive?
	  end

	  moore_neighborhood
	end

end
##############
############# gosu_GameOfLife.rb
# Gosu
require 'rubygems'
require 'gosu'
require_relative 'GameOfLife.rb'

class GameOfLife < Gosu::Window
	def needs_cursor?; true; end
	def update; @game.nextgen!; @gen += 1; puts "Game of Life Generation # #{@gen}"; end
	def initialize(height=800, width=600)
		@height = height
		@width = width
		super height, width, false
		self.caption = "Gosu Game of Life"


		@background_color = Gosu::Color.new(0xff808080)
		@alive_color = @randalive
		@dead_color = Gosu::Color.new(0xFF47CFF5)

		

		@columns = @width/10
		@column_width = @width/@columns
		@rows = @height/10
		@rows_height = @height/@rows
		
		@world = World.new(@columns, @rows)
		@game = Game.new(@world)
		@gen = 0
		@game.world.instance
	end
	def draw
		@randalive = [     Gosu::Color.argb(0xffff0000),    Gosu::Color.argb(0xffffff00),     Gosu::Color.argb(0xffff00ff),     Gosu::Color.argb(0xff00ffff),     Gosu::Color.argb(0xff00ff00)].sample
		@randadead = [         Gosu::Color.argb(0xff000000)].sample
	  	draw_quad(0, 0, @background_color,
	  			width, 0, @background_color,
	  			width, height, @background_color,
	  			0, height, @background_color)
	  	#Cell Alive / Dead
	  	@game.world.cells.each do |cell|
	      if cell.alive?
	        draw_quad(cell.xcord * @column_width, cell.ycord * @rows_height, @randalive,
	      			cell.xcord * @column_width + (@column_width - 1), cell.ycord * @rows_height, @randalive,
	      			cell.xcord * @column_width + (@column_width - 1), cell.ycord * @rows_height + (@rows_height -1), @randalive,
	      			cell.xcord * @column_width, cell.ycord * @rows_height + (@rows_height-1), @randalive)
	      else
	        draw_quad(cell.xcord * @column_width, cell.ycord * @rows_height, @randadead,
	      			cell.xcord * @column_width + (@column_width -1), cell.ycord * @rows_height, @randadead,
	      			cell.xcord * @column_width + (@column_width -1), cell.ycord * @rows_height + (@rows_height - 1), @randadead,
	      			cell.xcord * @column_width, cell.ycord * @rows_height + (@rows_height - 1), @randadead)
	    end	
	  end
	end
end

GameOfLife.new.show
###########################
###### test_GameOfLife.rb
#MiniTests
require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require_relative 'GameOfLife.rb'

### World #################################################P
    class WorldTest < Minitest::Test
      def setup
        @world = World.new
      end
      def test_WorldResponses
        assert_respond_to @world, :rows
        assert_respond_to @world, :cols
        assert_respond_to @world, :cell_grid
        assert_respond_to @world, :cells
      end
      def test_WorldGridCreate #Create a cell grid on initialize
        assert @world.cell_grid.is_a?(Array)
          @world.cell_grid.each do |row|
            assert row.is_a?(Array)
            assert row.each do |col|
              assert col.is_a?(Cell)
            end
      end
      def test_WorldCellCount #Test World Cell Count
        assert @world.cells.count == 9
      end
      def test_WorldInstance #Randomly populate the world
        assert @world.living.count == 0
        @world.instance
        refute @world.living.count == 0 
      end
    end
### Cell #################################
    class CellTest < Minitest::Test
      def setup
        @cell = Cell.new(1,1)
      end
      def test_Cell
        #Create a new cell object
        assert @cell.is_a?(Cell)
        #Respond to methods
        assert_respond_to @cell, :alive
        assert_respond_to @cell, :xcord
        assert_respond_to @cell, :ycord
        assert_respond_to @cell, :alive?
        assert_respond_to @cell, :kill
        #Test Cell Coordinate
        refute @cell.alive
        assert @cell.xcord == 1
        assert @cell.ycord == 1
      end
    end
### Game  #################################
    class GameTest < Minitest::Test
      def setup
        @cell = Cell.new(1,1)
        @world = World.new
        @game = Game.new(@world, [[1, 1], [2,0]])
      end
      def test_Game
        #Create a New Game
        assert @game.is_a?(Game)
        #Respond to methods
        assert_respond_to @game, :world
        assert_respond_to @game, :spawns
        #Initialize
        assert @world.is_a?(World)
        assert @world.cell_grid.is_a?(Array)
        #Check Spawns
        assert @world.cell_grid[1][1].alive
        assert @world.cell_grid[2][0].alive
      end
    end
### Rules  #################################################
    class RulesTest < Minitest::Test
      def setup
        @world = World.new
      end
      def test_Rule_01 # Rule 1: If a cell is alive and has fewer than 2 live neighbors, it dies
       	#Kills a live cell with 0 live neighbors
        world = World.new
        game = Game.new(world, [[1, 1]])
        assert world.cell_grid[1][1].alive
       	game.nextgen!
        assert world.cell_grid[1][1].dead?
       	#Kills a live cell with 1 live neighbor
       	game = Game.new(world, [[1, 0], [2, 0]])
       	game.nextgen!
        assert world.cell_grid[1][0].dead?
        assert world.cell_grid[2][0].dead? 
        #Does not kill a live cell with 2 live neighbors
       	game = Game.new(world, [[2, 1], [1, 1], [2, 2]])
       	game.nextgen!
        assert world.cell_grid[1][1].alive
        assert world.cell_grid[2][1].alive
        assert world.cell_grid[2][2].alive
      end
      def test_Rule_02 # Rule 2: If a cell is alive and has more than 3 live neighbors, it dies
        world = World.new
        game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2], [1, 2]])
        assert_equal 4, world.living_neighborhood(world.cell_grid[1][1]).count
       	game.nextgen!
       	assert world.cell_grid[0][1].alive?
        assert world.cell_grid[1][1].dead?
        assert world.cell_grid[2][1].alive
        assert world.cell_grid[2][2].dead?
        assert world.cell_grid[1][2].dead?
      end
      def test_Rule_03 # Rule 3: If a cell is alive and has 2 or 3 live neighbors, it lives to next generation
        world = World.new
       	game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2]])
        assert_equal 3, world.living_neighborhood(world.cell_grid[1][1]).count
       	game.nextgen!
       	assert world.cell_grid[0][1].dead?
        assert world.cell_grid[1][1].alive
        assert world.cell_grid[2][1].alive
       	assert world.cell_grid[2][2].alive
      end
      def test_04 # Rule 4: If a cell is dead and has exactly 3 live neighbors, it becomes a live cell
        world = World.new
        game = Game.new(world, [[0, 0], [0, 1], [1, 0], [1, 1]])
       	assert_equal 3, world.living_neighborhood(world.cell_grid[1][1]).count
       	game.nextgen!
        assert world.cell_grid[0][1].alive
        assert world.cell_grid[0][0].alive
      end   		
    end
end
