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
    attr :grid
    def initialize(size, p)
      # randomly initialize the board
      @grid = Array.new(size)
      @grid.each_with_index {|x, i| @grid[i] = Array.new(size) }
      seed_grid(p)
      @iteration = 1
    end
    
    def grid_size
      @grid.length
    end
    
    def seed_grid(p)
    # give each cell a (p * 100) percent chance to start the game as a live cell
      @grid.each_with_index do |x, i|
        x.each_with_index { |y,j| rand>(1.0-p) ? (@grid[i][j]='X') : (@grid[i][j]=nil) }
      end
    end
    
    def reseed_block
      # reseeds a grid with a 2x2 block of live cells.  assumes a grid size >=3.
      @grid.each_with_index do |x,i|
        x.each_with_index do |y,j|
          if (i==1 and j==1) or (i==1 and j==2) then
            @grid[i][j]='X'
          elsif (i==2 and j==1) or (i==2 and j==2) then
            @grid[i][j] = 'X'
          else
            @grid[i][j] = nil
          end
        end
      end
    end
  
    def reseed_blinker
      # reseeds a grid with a 3x1 block of live cells.  assumes a grid size >=5.
      @grid.each_with_index do |x,i|
        x.each_with_index do |y,j|
          if (i==2 and j==1) or (i==2 and j==2) or (i==2 and j==3) then
            @grid[i][j]='X'
          else
            @grid[i][j] = nil
          end
        end
      end
    end  
    

    def reseed_glider
      # reseeds a grid with a "glider" block of live cells.  assumes a grid size >=15.
      @grid.each_with_index do |x,i|
        x.each_with_index do |y,j|
          if (i==2 and j==1) or (i==2 and j==2) or (i==2 and j==3) then
            @grid[i][j]='X'
          elsif (i==1 and j==3) or (i==0 and j==2)then
            @grid[i][j]='X'
          else
            @grid[i][j] = nil
          end
        end
      end
    end      
    
    def neighbor_coordinates_array(i)
      out_array = []
      array_length = @grid.length
      if i >= (array_length - 1) then
        out_array = [i-1, i, -1]
      else
        out_array = [i-1, i, i+1]
      end
      out_array
    end
    

    def count_neighbors(x,y)
      # count the number of neighbors for a given live cell, not counting the cell itself as a neighbor.
      neighbor_count = 0
      x_coords = neighbor_coordinates_array(x)
      y_coords = neighbor_coordinates_array(y)
      x_coords.each do |i| 
        y_coords.each do |j|
          neighbor_count += 1 if @grid[i][j]=='X' and !(i==x and y==j)
        end
      end
      neighbor_count
    end  
    
    def evolve
      # apply rules to each cell and generate new state
      next_grid = Array.new(@grid.length)
      next_grid.each_with_index {|x,i| next_grid[i] = Array.new(@grid.length)}
      @grid.each_with_index do |row,i|
        row.each_with_index do |cell,j|
          n_count = count_neighbors(i,j)
          if (n_count<2 && cell) then
            next_grid[i][j] = nil
          elsif (n_count<=3 && cell) then
            next_grid[i][j] = "X"
          elsif (n_count>3 && cell) then
            next_grid[i][j] = nil
          elsif n_count==3 then #assume the cell is not live, since we're here in the IF 
            next_grid[i][j] = "X"
          else
            next_grid[i][j] = nil
          end
        end
      end 
      @grid = next_grid
      @iteration += 1
      nil
    end
    
    def render
      # render the current state of the board
      puts '----' * @grid.length;
      @grid.each do |col|
        c = []
        col.each_with_index {|val,i| !val ? c[i]=' ' : c[i]=val }
        puts c.join(' | ')
        puts '----' * @grid.length;
      end
      nil
    end
    
    def run(num_generations)
      # evolve and render for num_generations
      puts "generation #{@iteration}:"
      render
      num_generations.times do 
         evolve
         puts "generation #{@iteration}:"
         render
         2.times {puts ""}
         sleep(1)
      end
    end
  end
  
  g = GameOfLife.new(5,0.4)
  g.reseed_blinker
  g.render
  g.evolve
  g.render
  
  g.run(5)
  
  require 'minitest/autorun'
  class TestFinalProject < MiniTest::Test
    
    def setup
      @g = GameOfLife.new(3,0.1)
    end
    
    def test_grid_size
      assert_equal 3, @g.grid_size
    end
    
    
  end
  
end
