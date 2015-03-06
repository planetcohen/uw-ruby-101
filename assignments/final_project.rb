# ========================================================================================
#  Final Project: Game of Life
# ========================================================================================

require 'minitest/autorun'
require 'tk'

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
  class Cell
    NUM_NEIGHBORS_PER_CELL = 8

    attr_accessor :row, :col, :alive
    alias_method :alive?, :alive

    def initialize(row, col, board)
      @row = row
      @col = col
      @board = board
      @alive = false
    end

    def neighbors
      cells = []

      (@row-1..@row+1).each do |row|
        (@col-1..@col+1).each do |col|
          cells << @board.cell_at(row, col)
        end
      end
      cells.delete self

      cells
    end

    def live_neighbors
      neighbors.find_all { |cell| cell.alive? }
    end
  end

  class Board
    # creates a board of size size * size
    # the top-left most cell is row 0, col(umn) 0
    # the bottom-right most cell is row size - 1, col size - 1
    def initialize(size)
      @size = size
      @board = []
      (0...size).each do |row|
        @board << []
        (0...size).each do |col|
          @board[row] << Cell.new(row, col, self)
        end
      end
    end

    def each(&block)
      (0...@size).each do |row|
        (0...@size).each do |col|
          block.call @board[row][col]
        end
      end
    end

    def cell_at(row, col)
      row += @size if row < 0
      col += @size if col < 0

      @board[row % @size][col % @size]
    end

    def to_s
      @board.map do |row|
        row.map do |cell|
          cell.alive? ? '*' : '.'
        end.join('')
      end.join("\n")
    end
  end

  class GameOfLife
    def initialize(size, render_strategy)
      @render_strategy = render_strategy
      @board = Board.new(size)
      # randomly initialize the board
      @board.each { |cell| cell.alive = [true, false].sample }
    end

    def evolve
      # apply rules to each cell and generate new state
      new_states = []
      @board.each do |cell|
        num_live_neighbors = cell.live_neighbors.length
        if cell.alive?
          new_state = num_live_neighbors == 2 || num_live_neighbors == 3
        else
          new_state = num_live_neighbors == 3
        end
        new_states << new_state
      end

      # update the board with new states
      @board.each do |cell|
        cell.alive = new_states.shift
      end
    end

    def render
      # render the current state of the board
      # delegate to the render strategy
      @render_strategy.render @board
    end

    def run(num_generations)
      # evolve and render for num_generations
      (1..num_generations).each do |i|
        evolve
        render
      end
    end
  end
end

# render strategies

module FinalProject
  class ConsoleRenderStrategy
    def render(board)
      puts board.to_s
    end
  end

  class TkRenderStrategy
    CELL_SIZE = 20

    def initialize(size)
      @size = size
      canvas_size = @size * CELL_SIZE
      root = TkRoot.new
      canvas = TkCanvas.new(root) do
        place height: canvas_size , width: canvas_size
      end

      @cells = []
      (0...@size).each do |row|
        (0...@size).each do |col|
          top = row * CELL_SIZE + 3
          left = col * CELL_SIZE + 3
          bottom = (row + 1) * CELL_SIZE - 3
          right = (col + 1) * CELL_SIZE - 3
          @cells << TkcOval.new(canvas, left, top, right, bottom, width: 0, fill: "white")
        end
      end
    end

    def render(board)
      i = 0
      board.each do |cell|
        @cells[i][:fill] = cell.alive? ? "green" : "white"
        i += 1
      end
    end
  end
end

# unit tests

module FinalProject
  class CellTest < Minitest::Test
    def setup
      @board = Board.new(8)
    end

    def test_neighbors
      # each cell should have exactly 8 neighbors
      @board.each { |cell| assert_equal Cell::NUM_NEIGHBORS_PER_CELL, cell.neighbors.count }
    end

    def test_live_neighbors
      # each cell should have no live neighbors initially
      @board.each { |cell| assert_equal 0, cell.live_neighbors.count }
      # now set the top-left most cell as alive
      # all neighbors of the alive cell should have live neighbors
      cell0 = @board.cell_at(0, 0)
      cell0.alive = true
      cell0_neighbors = cell0.neighbors
      @board.each do |cell|
        if cell0_neighbors.include? cell
          assert_equal 1, cell.live_neighbors.count
        else
          assert_equal 0, cell.live_neighbors.count
        end
      end
    end
  end

  class BoardTest < Minitest::Test
    def setup
      @board = Board.new(2)
      @cells = [@board.cell_at(0, 0), @board.cell_at(0, 1), @board.cell_at(1, 0), @board.cell_at(1, 1)]
    end

    def test_cell_at_wrapping
      assert_equal @board.cell_at(0, 0), @board.cell_at(0, 2)
      assert_equal @board.cell_at(0, 0), @board.cell_at(2, 0)
      assert_equal @board.cell_at(0, 1), @board.cell_at(0, -1)
      assert_equal @board.cell_at(0, 1), @board.cell_at(2, 1)
      assert_equal @board.cell_at(1, 0), @board.cell_at(1, 2)
      assert_equal @board.cell_at(1, 0), @board.cell_at(-1, 0)
      assert_equal @board.cell_at(1, 1), @board.cell_at(1, -1)
      assert_equal @board.cell_at(1, 1), @board.cell_at(-1, 1)
    end

    def test_each_order
      i = 0
      @board.each do |cell|
        assert_equal @cells[i], cell
        i += 1
      end
      assert @cells.count, i
    end

    def test_to_s
      assert_equal "..\n..", @board.to_s
      @cells[0].alive = true
      assert_equal "*.\n..", @board.to_s
      @cells[1].alive = true
      assert_equal "**\n..", @board.to_s
      @cells[2].alive = true
      assert_equal "**\n*.", @board.to_s
      @cells[3].alive = true
      assert_equal "**\n**", @board.to_s
    end
  end
end
