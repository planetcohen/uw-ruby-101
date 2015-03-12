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
    attr_accessor :state_now


    #This is the method that renders the board into a text file
    #It is called by the actual render method.  Separated
    #to facilitate changes to render method at a later date
    def write_to_file
      File.open(@title, "w+") do |output|
        o = <<-BOARD
 #{"-" * @m}
#{(@state_now.map { |row| "|" + row.join + "|" }).join("\n")}
 #{"-" * @m}
        BOARD
        output.write o
      end
    end

    #sets up the intiial board with random entries.  Can be initiated
    #with or without dsl method.  If DSL is used, then the random board is
    #created but immediately overwritten by the user specified board.
    def initialize(n, m)
      @title = "GOL-output.txt"
      empty_setup = Array.new(n) { Array.new(m) }
      @n = n
      @m = m

      @state_now = empty_setup.map do |row|
        row.map {rand(2) == 1 ? "#" : " "}
      end

      write_to_file
    end

    #invokes the rules of the game of life and generates the next generation
    #it will count all 8 neighbors, but could be improved to stop when it
    #reaches 4 since >4 doesn't change result.
    #state = the "state" of the entire board
    #status = the "status" of a single cell
    def evolve
      def status_next(alive, row_index, col_index)
        c = 0
        checks = [-1, 0, 1]
        checks.each do |row_increment|
          checks.each do |col_increment|
            row_index + row_increment > @n - 1 ? row_check_index = 0 : row_check_index = row_index + row_increment
            col_index + col_increment > @m - 1 ? col_check_index = 0 : col_check_index = col_index + col_increment
            if @state_now[row_check_index][col_check_index] == "#"
              c += 1
            end
          end
        end
        if alive
          c==2 || c==3 ? "#" : " "
        else
          c==3 ? "#" : " "
        end
      end

      state_next = @state_now.map.with_index do |row, row_index|
        row.map.with_index do |i,col_index|
          alive = i == "#"
          status_next(alive, row_index, col_index)
        end
      end
      @state_now = state_next
    end

    def render
      self.write_to_file
    end

    def run(num_generations)
      c = 0
      until c >= num_generations
        self.evolve
        self.render
        c += 1
        puts c
      end
    end
  end



  #DSL code below.  If a specific initial state is desired, this
  #makes it quite easy

  class GameBuilder
    def game(&block)
      @initial_board = []
      self.instance_eval &block
      n = @initial_board.length
      m = @initial_board[0].length
      @game_new = GameOfLife.new n, m
      @game_new.state_now = @initial_board
      @game_new
    end

    def row(row_pattern)
      @initial_board << row_pattern.split("")
    end
  end


#Was having trouble with this code when making the mini tests
  # def self.game(&block)
  #   g = GameBuilder.new
  #   g.game(&block)
  # end


  # game do
  #   row "####"
  #   row "#   "
  #   row "#   "
  #   row "#   "
  # end
end


  #A few tests to make sure everything is workng tip top
  require 'minitest/autorun'

  class TestGameOfLife < Minitest::Test
    include FinalProject

    #test that the alive/dead rules work
    def test_alive_dead
      test = GameOfLife.new(4,4)
      test.state_now = [["#", "#", "#", "#"],
                        ["#", " ", " ", " "],
                        ["#", " ", " ", " "],
                        ["#", " ", " ", " "]]

      test_gen2      = [[" ", " ", "#", " "],
                        [" ", " ", "#", " "],
                        ["#", "#", " ", "#"],
                        [" ", " ", "#", " "]]
      test.evolve
      assert_equal test.state_now, test_gen2
    end

    #test that the dsl entry method works
    def test_dsl_entry
      tester = GameBuilder.new
      tg = tester.game do
        row "####"
        row "#   "
        row "#   "
        row "#   "
      end

      check_matrix = [["#", "#", "#", "#"],
                      ["#", " ", " ", " "],
                      ["#", " ", " ", " "],
                      ["#", " ", " ", " "]]

      assert_equal tg.state_now, check_matrix

      #test that the "run" method works
      tg.run(1)

      check_matrix      = [[" ", " ", "#", " "],
                           [" ", " ", "#", " "],
                           ["#", "#", " ", "#"],
                           [" ", " ", "#", " "]]

      assert_equal tg.state_now, check_matrix
    end

    #enjoyable to watch the text file update over several generations, but doesn't
    #really test anything
    # def test_large_board
    #   test=GameOfLife.new(100,100)
    #   test.run(100)
    # end
  end
