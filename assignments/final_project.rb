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
    attr :grid, :iteration
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
    
    def reseed(pattern_array)
      @grid.each_with_index do |x,i|
        x.each_with_index do |y,j|
          pattern_array.include?([i,j]) ? @grid[i][j]='X' : @grid[i][j]=nil
        end
      end
    end
    
    def reseed_toad
      # reseeds a grid with a "toad" pattern of live cells.  assumes a grid size >=6.
      toad_cells = [[1,2],[1,3],[1,4],[2,1],[2,2],[2,3]]
      reseed(toad_cells)
    end
    
    def reseed_block
      # reseeds a grid with a 2x2 block of live cells.  assumes a grid size >=3.
      block_cells = [[1,1],[1,2],[2,1],[2,2]]
      reseed(block_cells)
    end
  
    def reseed_blinker
      # reseeds a grid with a 3x1 block of live cells.  assumes a grid size >=5.
      blinker_cells=[[2,1],[2,2],[2,3]]
      reseed(blinker_cells)
    end  
    

    def reseed_glider
      # reseeds a grid with a "glider" pattern of live cells.  assumes a grid size >=15.
      glider_cells = [[2,1],[2,2],[2,3],[1,3],[0,2]]
      reseed(glider_cells)
    end      
    
    def neighbor_coordinates_array(i)
      out_array = []
      array_length = @grid.length
      i>=(array_length-1) ? out_array = [i-1, i, -1] : out_array = [i-1, i, i+1]
      out_array
    end
 
    def reseed_glider_gun
      gun_cells=[[1,25],[2,23],[2,25],
        [3,13],[3,14],[3,21],[3,22],[3,35],[3,36],
        [4,12], [4,16],[4,21],[4,22],[4,35],[4,36],
        [5,1],[5,2],[5,11],[5,17],[5,21],[5,22],
        [6,1],[6,2],[6,11],[6,15],[6,17],[6,18],[6,23],[6,25],
        [7,11],[7,17],[7,25],
        [8,12],[8,16],
        [9,13],[9,14]
        ]
      reseed(gun_cells)
    end

    def count_neighbors(x,y)
      # count the number of neighbors for a given live cell, not counting the cell itself as a neighbor.
      neighbor_count = 0
      x_coords = neighbor_coordinates_array(x)
      y_coords = neighbor_coordinates_array(y)
      x_coords.each do |i| 
        y_coords.each do |j|
          neighbor_count += 1 if (@grid[i][j] and !(i==x and y==j))
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
      @grid.each do |row|
        c = []
        row.each_with_index {|val,i| !val ? c[i]=' ' : c[i]=val }
        puts c.join(' | ')
        puts '----' * @grid.length;
      end
      nil
    end
    
    def run(num_generations)
      # evolve and render for num_generations
      num_generations.times do 
         evolve
         puts "generation #{@iteration}:"
         render
         2.times {puts ""}
         sleep(0.5)
      end
    end
  end
  

  
  require 'minitest/autorun'
  class TestFinalProject < MiniTest::Test
    
    def test_grid_size
      g=GameOfLife.new(3,0.1)
      assert_equal 3, g.grid_size
    end
    
    def test_generation_counter
      g=GameOfLife.new(10,0.1)
      9.times {g.evolve}
      assert_equal 10, g.iteration
    end
    
    def test_glider 
      # Seed and evolve a glider formation 4 times,
      # then count the live cells in the expected locations.
      g=GameOfLife.new(15,0.1)
      g.reseed_glider
      4.times {g.evolve}
      live_coords=[[1,3],[2,4],[3,2],[3,3],[3,4]]
      live_count,dead_count=0,0
      g.grid.each_with_index do |row, i|
        row.each_with_index do |cell, j|
          live_count+=1 if (live_coords.include?([i,j]) && cell )
          dead_count+=1 if (!live_coords.include?([i,j]) && !cell)
        end
      end
      assert_equal 5, live_count
      assert_equal 220, dead_count
    end
    
    def test_count_neighbors
      g=GameOfLife.new(10,0.1)
      g.reseed_glider
      assert_equal 5, g.count_neighbors(1,2)
      assert_equal 1, g.count_neighbors(2,1)
      assert_equal 3, g.count_neighbors(2,2)
      assert_equal 0, g.count_neighbors(8,8)
    end
    
  end
  
end
