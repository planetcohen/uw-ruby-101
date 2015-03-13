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
require 'minitest/autorun'

module FinalProject
  class GameOfLife
    attr :cells
    def initialize(size)
      # randomly initialize the board
      @size = size
      @cells = Array.new(@size){Array.new(@size){Random.rand(@size)%2}}
    end

    def cells=(new_cells)
      @cells = new_cells
    end

    def evolve
      new_cells = Array.new(@size){Array.new(@size)}
      # apply rules to each cell and generate new state
      @cells.each_with_index do |row, x|
        row.each_with_index do |cell, y|
          neighbors = living_neighbors(x,y)
          new_cells[x][y] = @cells[x][y]
          if @cells[x][y] == 1 then
            if (neighbors < 2 || neighbors > 3) then
              new_cells[x][y] = 0
            end
          else
            if neighbors == 3 then
              new_cells[x][y] = 1
            end
          end
        end
      end
      @cells = new_cells
    end
  
    def living_neighbors(x,y)
      [[-1,1], [0,1], [1,1],
       [-1,0], [1, 0],
       [-1,-1], [0, -1], [1, -1]
      ].inject(0) do |alive, offset|
        nx = (x + offset[0].to_i)
        ny = (y + offset[1].to_i) 

        nx = nx < 0 ? nx+@size : nx % @size
        ny = ny < 0 ? ny+@size : ny % @size
      
        alive = alive + @cells[nx][ny].to_i
      end
    end

    def render
      # render the current state of the board
      print "- - " * @size
      print "\n"
      
      @cells.map do |row| 
        print "|"; 
        print row.map{|cells| cells==1 ? 'o ' : '  '}.join(" "); 
        print "|\n"
      end
      
      print "- - " * @size
      print "\n"
    end

    def run(num_generations)
      # evolve and render for num_generations
      num_generations.times do |i| 
        system "clear"
        print "Generation ", i+1, "\n"
        evolve
        render
        sleep 1
      end
    end
  end
  
  gol = GameOfLife.new(10)
  puts "initial board"
  gol.render
  gol.run(10)
end

class TestMyClass < Minitest::Test
  include FinalProject

  def test_living_neighbors
   gol = GameOfLife.new(3)
   #test no neighbor
   gol.cells = [[0,0,0], [0,1,0], [0,0,0]]
   assert_equal 0, gol.living_neighbors(1,1)
   #test 8 neighbors
   gol.cells = [[1,1,1], [1,1,1], [1,1,1]]
   assert_equal 8, gol.living_neighbors(1,1)
   #test border neighbor
   gol.cells = [[0,0,0], [0,1,0], [1,0,0]]
   assert_equal 2, gol.living_neighbors(0,0)
  end

  def test_evolve
   
   gol = GameOfLife.new(3)
   #test 3 neighbor become alive
   gol.cells = [[0,1,0], [1,0,1], [0,0,0]]
   assert_equal 0, gol.cells[1][1]
   gol.evolve
   assert_equal 1, gol.cells[1][1]
   #test alive 0 neighbor dies
   gol.cells = [[0,0,0], [0,1,0], [0,0,0]]
   assert_equal 1, gol.cells[1][1]
   gol.evolve
   assert_equal 0, gol.cells[1][1]
   #test alive 3 neighbor stay alive
   gol.cells = [[1,0,0], [1,1,1], [0,0,0]]
   assert_equal 1, gol.cells[0][0]
   gol.evolve
   assert_equal 1, gol.cells[0][0]
  
  end

end
