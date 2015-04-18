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


class Cell
  attr_accessor :alive, :x, :y
  def initialize(x=1, y=2)
    @alive = true if 0.5 > rand
    #@alive = true
    @x = x
    @y = y
  end

  def to_s                  # enable this for rendering
    @alive ? "O" : " "
  end

  def alive?
    @alive
  end

end

class GameOfLife
  attr_accessor :width, :height, :board, :cells

  def initialize(height=60, width=230)
    @width, @height = width, height
    # @board = Array.new(height) {Array.new(width){Cell.new}}
    # The board will be a multidimensional array of cells:
    @cells = []   
    @board = Array.new(height) do |row|
              Array.new(width) do |col|
                cell = Cell.new(col, row)
                cells << cell
                cell
              end
            end
         
  end

  def evolve
    # apply rules to each cell and generate new state
    alive_cells = []
    dead_cells = []
    #puts self.cells
    # test_cell = self.cells[5]
    # puts ""
    # puts "test_cell = #{test_cell}"
    # puts "test_cell_neighbors = #{self.neighbors(test_cell).count}"

    self.cells.each do |cell|
      # puts "*******NEW CELL*******"
      # puts "cell.x = #{cell.x}"
      # puts "cell.y = #{cell.y}"
      #puts "self.neighbors(cell) = #{self.neighbors(cell)}"
      # puts "self.neighbors(cell).count = #{self.neighbors(cell).count}"
      
      count_live_neighbors = self.neighbors(cell).count
      
      # puts "count_live_neighbors = #{count_live_neighbors}"
      # puts ""
      # puts ""
      # puts "cell.alive? = #{cell.alive?}"
      # puts cell
      # puts "count = #{count}"
      # puts "cell.alive? = #{cell.alive?}"
      # puts "count = #{count}"


      if (cell.alive? and (count_live_neighbors < 2  or count_live_neighbors > 3))       # Rule 1 and 2 - cell dies
        #puts "cell was alive. count < 2 or > 3. it must die."
        # puts "cell was alive, and count < 2  or count > 3.... cell will now be dead"
        dead_cells << cell
      elsif ((cell.alive?) and (count_live_neighbors == 2 or count_live_neighbors == 3))    # Rule 3 - cell remains alive
        #puts "cell was alive. count is 2 or 3. cell may continue living."
        # puts "cell was alive, and count == 2 or 3... cell will remain alive."
        alive_cells << cell
      elsif ((cell.alive? == false) and (count_live_neighbors == 3))     #Rule 4 - cell was dead, but becomes alive.
        #puts "cell was dead. count is exactly 3. cell becomes alive."
        # puts "cell was dead, and count == 3... cell will become alive."
        alive_cells << cell
      else
        #puts "cell was dead, but count is not exactly 3, so it will stay dead."
        # puts "cell did not meet any other conditions, so it will be dead."
        dead_cells << cell
      end
      #puts "*******END CELL*******"
    end

    alive_cells.each do |cell|
        cell.alive = true
      end

    dead_cells.each do |cell|
      cell.alive = false
    end
    self.cells

    # puts "test_cell after logic = #{test_cell}"

  end

  def neighbors(cell)       #return neighboring cells array
    ca = []
    ca << cell
    #puts "cell at beginning = #{ca}"
    alive_neighbors = []
    #puts "cell = #{ca}"

    # Misc. Debugging...
    # puts "height:"
    # puts self.height
    # puts "width:"
    # puts self.width
    # puts "result.x:"
    # puts result.x
    # puts "result.y:"
    # puts result.y
    # puts""

    #### TOP-LEFT NEIGHBOR ####
    neighbor_tl = self.board[cell.y-1][cell.x-1]
    alive_neighbors << neighbor_tl if neighbor_tl.alive == true

    #### TOP NEIGHBOR ####
    neighbor_t = self.board[cell.y-1][cell.x]
    alive_neighbors << neighbor_t if neighbor_t.alive == true

    #### LEFT NEIGHBOR ####
    neighbor_l = self.board[cell.y][cell.x-1]
    alive_neighbors << neighbor_l if neighbor_l.alive == true

    #############################################################
    #### SPECIAL CASES - AVOID GOING BEYOND FINAL INDEX OF ARRAYS:

    #### TOP-RIGHT NEIGHBOR ####
    if cell.x == self.width-1
      neighbor_tr = self.board[cell.y-1][0]
    else
      neighbor_tr = self.board[cell.y-1][cell.x+1]
    end
    alive_neighbors << neighbor_tr if neighbor_tr.alive == true

    #### BOTTOM-RIGHT NEIGHBOR ####
    if ((cell.y == self.height-1) and (cell.x == self.width-1))
      neighbor_br = self.board[0][0]
    elsif cell.y == self.height-1
      neighbor_br = self.board[0][cell.x+1]
    elsif cell.x == self.width-1
      neighbor_br = self.board[cell.y+1][0]
    else
      neighbor_br = self.board[cell.y+1][cell.x+1]
    end
    alive_neighbors << neighbor_br if neighbor_br.alive == true

    # #### BOTTOM-LEFT NEIGHBOR ####
    if cell.y == self.height-1
      neighbor_bl = self.board[0][cell.x-1]
    else
      neighbor_bl = self.board[cell.y+1][cell.x-1]
    end
    alive_neighbors << neighbor_bl if neighbor_bl.alive == true

    # #### RIGHT NEIGHBOR ####
    if cell.x == self.width-1
      neighbor_r = self.board[cell.y][0]
    else
      neighbor_r = self.board[cell.y][cell.x+1]
    end
    alive_neighbors << neighbor_r if neighbor_r.alive == true

    # #### BOTTOM NEIGHBOR ####
    if cell.y == self.height-1
      neighbor_b = self.board[0][cell.x]
    else
      neighbor_b = self.board[cell.y+1][cell.x]
    end
    alive_neighbors << neighbor_b if neighbor_b.alive == true

    
    alive_neighbors
    # Misc. debugging used:
    # puts "alive_neighbors.count = #{alive_neighbors.count}"
    # puts "alive_neighbors is an Array? #{alive_neighbors.instance_of? Array}"
    # puts "alive_neighbors.count = #{alive_neighbors.count}"
    # puts "alive_neighbors = #{alive_neighbors}"
      
  end

  def render
    @board.map { |row| row.join }.join("\n")
    #print @board.to_s                         # Not Needed, since run calls puts
  end

  def run(num_generations = 10)
    # evolve and render for num_generations
    (1..num_generations).each do |x|
      #puts "Generation #{x}"
      evolve
      system "clear" or system "cls"
      #puts self.to_s
      puts self.render
      sleep(0.25)
    end
  end

end
