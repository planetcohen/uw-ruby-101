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

#module FinalProject
  class GameOfLife
    attr_accessor :gameboard, :seeds
    def initialize(gameboard = GameBoard.new, seeds=[])
      @gameboard = gameboard
      @seeds = seeds

      seeds.each do |seed|
        gameboard.board[seed[0]][seed[1]].is_alive = true
      end
    end

    def evolve!

      cell_is_dead_in_next_state = []
      cell_is_alive_in_next_state = []

      gameboard.cells.each do |cell|
        #Rule #1
        if cell.is_alive? && gameboard.neighbors(cell).count < 2
          cell_is_dead_in_next_state << cell
        end
        #Rule #2
        if cell.is_alive? && gameboard.neighbors(cell).count > 3
          cell_is_dead_in_next_state << cell
        end
        #Rule #3
        if cell.is_alive? && gameboard.neighbors(cell).count == 2
          cell_is_alive_in_next_state << cell
        end

        if cell.is_alive? && gameboard.neighbors(cell).count == 3
          cell_is_alive_in_next_state << cell
        end
        #Rule #4
        if !cell.is_alive? && gameboard.neighbors(cell).count == 3
          cell_is_alive_in_next_state << cell
        end
      end

      cell_is_dead_in_next_state.each do |cell|
        cell.kill_cell!
      end
      cell_is_alive_in_next_state.each do |cell|
        cell.resurrect!
      end
    end
  end

  class GameBoard
    attr_accessor :rows, :columns, :board, :cells

    def initialize(rows=3, columns=3)
      @rows = rows
      @columns = columns
      @cells = []
      @board = Array.new(rows) do |row|
        Array.new(columns) do |column|
          cell = Cell.new(column,row)
          cells << cell
          cell
        end
      end
    end

    def neighbors(cell)
      neighbors = []

      #northeast neighbor
      if cell.x_pos < (columns - 1) && cell.y_pos > 0
        neighbor = self.board[cell.y_pos - 1][cell.x_pos + 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos < (columns - 1) && cell.y_pos == 0
        neighbor = self.board[cell.y_pos + (self.rows - 1)][cell.x_pos + 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos == (columns - 1) && cell.y_pos > 0
        neighbor = self.board[cell.y_pos - 1][0]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[cell.y_pos + (self.rows - 1)][0]
        neighbors << neighbor if neighbor.is_alive?
      end

      #southeast neighbor
      if cell.x_pos < (columns - 1) && cell.y_pos < (rows - 1)
        neighbor = self.board[cell.y_pos + 1][cell.x_pos + 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos < (columns - 1) && cell.y_pos == (rows - 1)
        neighbor = self.board[0][cell.x_pos + 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos == (columns - 1) && cell.y_pos < (rows - 1)
        neighbor = self.board[cell.y_pos + 1][0]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[0][0]
        neighbors << neighbor if neighbor.is_alive?
      end

      #southwest neighbor
      if cell.x_pos > 0 && cell.y_pos < (rows - 1)
        neighbor = self.board[cell.y_pos + 1][cell.x_pos - 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos > 0 && cell.y_pos == (rows - 1)
        neighbor = self.board[0][cell.x_pos - 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos == 0 && cell.y_pos < (rows - 1)
        neighbor = self.board[cell.y_pos + 1][cell.x_pos + (self.columns - 1)]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[0][cell.x_pos + (self.columns - 1)]
        neighbors << neighbor if neighbor.is_alive?
      end

      #northwest neighbor
      if cell.x_pos > 0 && cell.y_pos > 0
        neighbor = self.board[cell.y_pos - 1][cell.x_pos - 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos > 0 && cell.y_pos == 0
        neighbor = self.board[cell.y_pos + (self.rows - 1)][cell.x_pos - 1]
        neighbors << neighbor if neighbor.is_alive?
      elsif cell.x_pos == 0 && cell.y_pos > 0
        neighbor = self.board[cell.y_pos - 1][cell.x_pos + (self.columns - 1)]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[cell.y_pos + (self.rows - 1)][cell.x_pos + (self.columns - 1)]
        neighbors << neighbor if neighbor.is_alive?
      end

      #north neighbor
      if cell.y_pos > 0
        neighbor = self.board[cell.y_pos - 1][cell.x_pos]
        neighbors << neighbor if neighbor.is_alive?
      else 
        neighbor = self.board[cell.y_pos + (self.rows - 1)][cell.x_pos]
        neighbors << neighbor if neighbor.is_alive?
      end
      
      #east neighbor
      if cell.x_pos < (columns - 1)
        neighbor = self.board[cell.y_pos][cell.x_pos + 1]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[cell.y_pos][0]
        neighbors << neighbor if neighbor.is_alive?
      end

      #south neighbor
      if cell.y_pos < (rows - 1)
        neighbor = self.board[cell.y_pos + 1][cell.x_pos]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[0][cell.x_pos]
        neighbors << neighbor if neighbor.is_alive?
      end
      
      #west_neighbor
      if cell.x_pos > 0
        neighbor = self.board[cell.y_pos][cell.x_pos - 1]
        neighbors << neighbor if neighbor.is_alive?
      else
        neighbor = self.board[cell.y_pos][cell.x_pos + (self.columns - 1)]
        neighbors << neighbor if neighbor.is_alive?
      end

      neighbors
    end

    def live_cells
      cells.select{|cell| cell.is_alive?}
    end

    def randomly_populate
      cells.each do |cell|
        cell.is_alive = [true, false].sample
      end
    end

  end

  class Cell
    attr_accessor :x_pos, :y_pos, :is_alive

    def initialize(xpos=0, ypos=0)
      @x_pos = xpos
      @y_pos = ypos
      @is_alive = false
    end

    def is_alive?
      is_alive
    end

    def kill_cell!
      @is_alive = false
    end

    def resurrect!
      @is_alive = true
    end
  end 

  require 'gosu'

  class GameOfLifeWindow < Gosu::Window

    def initialize(height=800, width=600)
      @height = height
      @width = width
      super height, width, false
      self.caption = "Conway's Game Of Life"

      @background_color = Gosu::Color.new(0xffdedede)
      @cell_color = Gosu::Color.new(0xff121212)
      @blank_color = Gosu::Color.new(0xffededed)

      #game
      @columns = width / 10
      @rows = height / 10
      @column_width = width / @columns
      @row_height = height / @rows
      @gameboard = GameBoard.new(@columns, @rows)
      @game = GameOfLife.new(@gameboard)
      @game.gameboard.randomly_populate
    end

    def update
      @game.evolve!
    end

    def draw
      draw_quad(0, 0, @background_color,
                width, 0, @background_color,
                width, height, @background_color,
                0, height, @background_color)

        @game.gameboard.cells.each do |cell|
        
        if cell.is_alive?
          draw_quad(cell.x_pos * @column_width, cell.y_pos * @row_height, @cell_color,
                    cell.x_pos * @column_width + (@column_width - 1), cell.y_pos * @row_height, @cell_color,
                    cell.x_pos * @column_width + (@column_width - 1), cell.y_pos * @row_height + (@row_height - 1), @cell_color,
                    cell.x_pos * @column_width, cell.y_pos * @row_height + (@row_height - 1), @cell_color)
        
        else
          draw_quad(cell.x_pos * @column_width, cell.y_pos * @row_height, @blank_color,
                    cell.x_pos * @column_width + (@column_width - 1), cell.y_pos * @row_height, @blank_color,
                    cell.x_pos * @column_width + (@column_width - 1), cell.y_pos * @row_height + (@row_height - 1), @blank_color,
                    cell.x_pos * @column_width, cell.y_pos * @row_height + (@row_height - 1), @blank_color)
        end
      end
    end

    def needs_cursor?
      true
    end


  end

  GameOfLifeWindow.new.show

  require 'minitest/autorun'

  class TestGameOfLife < Minitest::Test
    
    def test_GameBoard
      a = GameBoard.new
      assert_instance_of GameBoard, a
      assert_respond_to a, :rows
      assert_respond_to a, :columns
      assert_respond_to a, :board
      assert_respond_to a, :neighbors
      assert_respond_to a, :cells
      assert_respond_to a, :randomly_populate
      assert_respond_to a, :live_cells
      assert_instance_of Array, a.board
      a.board.each do |row|
        assert_instance_of Array, row
        row.each do |column|
          assert_instance_of Cell, column
        end
      end

      assert_equal 9, a.cells.count

      a.cells.each do |cell|
        assert_equal false, cell.is_alive?
      end

      assert_equal 0, a.live_cells.count
      a.randomly_populate
      refute_equal 0, a.live_cells.count
    end

    def test_Cell
      b = Cell.new
      assert_instance_of Cell, b
      assert_respond_to b, :is_alive
      assert_equal false, b.is_alive
      assert_respond_to b, :x_pos
      assert_respond_to b, :y_pos
      assert_respond_to b, :kill_cell!
      assert_respond_to b, :resurrect!
      assert_equal b.x_pos, 0
      assert_equal b.y_pos, 0
    end

    def test_GameOfLife
      c = GameOfLife.new
      assert_instance_of GameOfLife, c
      assert_respond_to c, :gameboard
      assert_respond_to c, :seeds
      assert_instance_of GameBoard, c.gameboard
      assert_instance_of Array, c.seeds

      d = GameOfLife.new(GameBoard.new, [[1,2], [0,2]])
      assert_equal true, d.gameboard.board[1][2].is_alive?
      assert_equal true, d.gameboard.board[0][2].is_alive?

      e = GameOfLife.new(GameBoard.new, [[1,0], [2,0]])
      e.evolve!
      assert_equal false, e.gameboard.board[1][0].is_alive?
      assert_equal false, e.gameboard.board[2][0].is_alive?

      f = GameOfLife.new(GameBoard.new, [[0,1], [1,1], [2,1]])
      assert_equal 2, f.gameboard.neighbors(f.gameboard.board[1][1]).count
      assert_equal 2, f.gameboard.neighbors(f.gameboard.board[0][1]).count
      assert_equal true, f.gameboard.board[1][1].is_alive?
      f.evolve!
      assert_equal true, f.gameboard.board[0][1].is_alive?
      assert_equal true, f.gameboard.board[1][1].is_alive?
      assert_equal true, f.gameboard.board[2][1].is_alive?

      g = GameOfLife.new(GameBoard.new, [[0,1], [1,1], [2,1], [2,2]])
      assert_equal 3, g.gameboard.neighbors(g.gameboard.board[1][1]).count
      assert_equal true, g.gameboard.board[1][1].is_alive?
      g.evolve!
      assert_equal false, g.gameboard.board[0][1].is_alive?
      assert_equal true, g.gameboard.board[1][1].is_alive?
      assert_equal true, g.gameboard.board[2][1].is_alive?
      assert_equal true, g.gameboard.board[2][2].is_alive?

      h = GameOfLife.new(GameBoard.new, [[0,1], [1,1], [2,1], [2,2], [1,2]])
      assert_equal 4, h.gameboard.neighbors(h.gameboard.board[1][1]).count
      assert_equal true, h.gameboard.board[2][2].is_alive?
      assert_equal 3, h.gameboard.neighbors(h.gameboard.board[2][2]).count
      h.evolve!
      assert_equal true, h.gameboard.board[0][1].is_alive?
      assert_equal false, h.gameboard.board[1][1].is_alive?
      assert_equal true, h.gameboard.board[2][1].is_alive?
      assert_equal true, h.gameboard.board[2][2].is_alive?
      assert_equal false, h.gameboard.board[1][2].is_alive?
    end
  end
#end