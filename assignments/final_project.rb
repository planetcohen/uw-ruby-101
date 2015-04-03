# ========================================================================================
#  Final Project: Game of Life
# ========================================================================================

#  The Game of Life is a simplified model of evolution and natural selection
#  invented by the mathematician John Horton Conway.

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
    class Board
      attr_accessor :board_array
      attr_reader :size
      def initialize(size)
        @board_array = []
        @size = size
        size.times do
          @board_array << Array.new(size, 0)
        end
      end
      def onNext?(row, col)
        # returns true if cell at row,col has 3 live neighbors
        # returns true if cell is live and has 2 live neighbors
        # returns false for anything else
        sum_of_above_row = self.board_array[row - 1][col - 1] + self.board_array[row - 1][col] + self.board_array[row - 1][(col == size - 1) ? 0 : (col + 1)]
        sum_of_sides = @board_array[row][col - 1] + @board_array[row][(col == size - 1) ? 0 : (col + 1)]
        sum_of_below_row = @board_array[(row == size - 1) ? 0 : (row + 1)][col - 1] + @board_array[(row == size - 1) ? 0 : (row + 1)][col] + @board_array[(row == size - 1) ? 0 : (row + 1)][(col == size - 1) ? 0 : (col + 1)]
        sum_of_neighbors = sum_of_above_row + sum_of_sides + sum_of_below_row
        sum_of_neighbors == 3 || (sum_of_neighbors == 2 && @board_array[row][col] == 1)
      end
    end  # class Board

    def initialize(size)
      # randomly initialize the board
      @size = size
      @board = Board.new size
      @board.board_array = @board.board_array.map do |row|
        row = row.map do |cell|
          cell = rand(2)
        end
      end
    end
    def size
      @size
    end
    def boardArray
      @board.board_array
    end

    def saveBoard(filename = "savedboard.txt", board = @board)
      # save board to text file
      output = File.open(filename, "w+")
      @board.board_array.each do |row|
        arr_row_string = row.map {|cell| cell.to_s}
        row_string = arr_row_string.join
        output.puts row_string
      end
      output.close
    end
    def loadBoard(filename = "savedboard.txt")
      # load board from text file
      input = File.open(".\\" + filename, "r")
      new_board_array = []
      input.each_line do |line|
        str_row = line.chop.split ""  # removing newline
        row = str_row.map {|cell| cell.to_i}
        new_board_array << row
      end
      input.close
      @size = new_board_array.length
      @board = Board.new @size
      @board.board_array = new_board_array
    end
    def evolve(board = @board)
      # apply rules to each cell and generate new state
      # create new empty board
      new_board = Board.new board.size
      # for each cell, if it's off, grow? if it's on, live?
      (0..(board.size - 1)).each do |row|
        (0..(board.size - 1)).each do |col|
          new_board.board_array[row][col] = board.onNext?(row, col) ? 1 : 0
        end
      end
      board.board_array = new_board.board_array
    end
    def render(board = @board)
      # render the current state of the board
      board.board_array.each do |row|
        row.each do |cell|
          print cell
        end
        print "\n"
      end
    end
    def run(num_generations, board = @board)
      # evolve and render for num_generations
      num_generations.times do
        evolve board
        render board
      end
    end

  end  # class GameOfLife
end  # module FinalProject

#  Tests
require 'minitest/autorun'

class TestFinalProject < Minitest::Test

  def test_board_initialize_size
    (1..100).each do |x|
      game = FinalProject::GameOfLife.new x
      refute_nil game
      assert_equal x, game.size
    end
  end

  def test_save_load
    # initialize random board
    game = FinalProject::GameOfLife.new 50
    test_ary = game.boardArray
    game.saveBoard("test_save_load.txt")
    game.loadBoard("test_save_load.txt")
    # verify loaded board equals saved board
    assert game.boardArray == test_ary
  end

#  def test_render
#  end

  def test_evolve
    game = FinalProject::GameOfLife.new 50
    game.saveBoard "test_evolve.txt"
    game2 = FinalProject::GameOfLife.new 50
    game2.loadBoard "test_evolve.txt"

    game.run(5)
    (1..5).each do
      game2.evolve
    end
    assert_equal game.boardArray, game2.boardArray
  end

  def test_evolve2
    game = FinalProject::GameOfLife.new 10
    game2 = game
    game.loadBoard("test_evolve2.txt")
    game.evolve
    game2.loadBoard("test_evolve2_correct.txt")
    assert_equal game.boardArray, game2.boardArray
  end
  
end  # TestFinalProject < Minitest::Test