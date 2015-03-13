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

#require 'matrix'
#require 'set'

module FinalProject
  class GameOfLife
    def initialize(rows, columns)
      # randomly initialize the board
     @current_grid = Array.new(rows) { Array.new(columns) {Cell.new("random") } }
     @previous_grid = Array.new(rows) { Array.new(columns) {Cell.new("default") } }
    end
    
    def evolve
      # apply rules to each cell and generate new state
      
      rows = @previous_grid.length
      columns = @previous_grid[0].length
        
      #Copy current grid to previous grid  
      0.upto(rows-1) do |x|
            0.upto(columns-1) do |y|
                #puts  @previous_grid[x][y].state
                #puts @current_grid[x][y].state
                @previous_grid[x][y].state = @current_grid[x][y].state
            end
        end

        
        #live_nb_debug = String.new
        0.upto(rows-1) do |x|
            0.upto(columns-1) do |y|
                live_neighbors = @previous_grid[(x-1)][(y-1)].bool_value.to_i + #top-left
                                    @previous_grid[(x-1)][(y)].bool_value.to_i + #top
                                    @previous_grid[(x-1)][(y+1) % columns].bool_value.to_i + #top-right
                                    @previous_grid[(x)][(y-1)].bool_value.to_i + #left
                                    @previous_grid[(x)][(y+1) % columns].bool_value.to_i + #right
                                    @previous_grid[(x+1) % rows][(y-1)].bool_value.to_i + #bottom-left
                                    @previous_grid[(x+1) % rows][(y)].bool_value.to_i + #bottom
                                    @previous_grid[(x+1) % rows][(y+1) % columns].bool_value.to_i  #bottom-right
               # live_nb_debug << live_neighbors.to_s
                
                case @previous_grid[x][y].state
                    when "Alive"
                        if live_neighbors < 2 || live_neighbors > 3 
                            @current_grid[x][y].state = "Dead"
                        else
                             @current_grid[x][y].state = "Alive"
                        end
                    when "Dead"
                        if live_neighbors == 3
                            @current_grid[x][y].state = "Alive"
                        else
                             @current_grid[x][y].state = "Dead"
                        end
                end
            end
            #puts live_nb_debug
            #live_nb_debug.clear
        end

    end
    
    def render
      # render the current state of the board (in ASCII)
      row_display = String.new
      @current_grid.each do |row|
          row.each do |column|
              row_display << column.display
          end
          puts row_display
          row_display.clear
      end
    end
    
    def run(num_generations)
      # evolve and render for num_generations
      
      #initial run
      render
      
       1.upto(num_generations) do |i|
        system "clear"    #clear terminal window for "animation" each iteration
        puts "*#{i}*"
        evolve
        render
        sleep 0.1
        end
    end
  end
  
    class Cell
    
        attr_accessor :state
      
        def initialize(type)
            if type == "random"
               @state = rand(2) == 1 ? "Alive" : "Dead"
            else
              @state = "Dead"
            end
        end
        
        def display
            case @state
                when "Alive"
                    "O"
                when "Dead"
                    "-"
            end
        end
        
        def bool_value
            case @state
                when "Alive"
                    1
                when "Dead"
                    0
            end
        end
    end
       
    newGame = GameOfLife.new(10, 10)
    newGame.run(200)
end
