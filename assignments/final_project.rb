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


module FinalProject

  class GameOfLife
  
    attr_reader :width,:height,:probability,:generations,:petri
    attr_accessor :migration_rate,:mutation_rate,:mutation_factor
  
    def initialize(w, h, p=50, mig_r=10, mut_r=10, mut_f=2)
      @width = w
      @height = h
      @probability = p
      @generations = 0
      @migration_rate = mig_r
      @migrations = 0
      @mutation_rate = mut_r
      @mutations = 0
      @mutation_factor = mut_f
      @mutation_free_generations = 0
      culture if substrate
    end
  
    def evolve
      a = Array.new(0, nil)
      @generations += 1
      @mutation_free_generations += 1
      @migrations += 1
      @height.times { a << Array.new(@width, 0) }
      @petri.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          result = calculate(x, y)
          @heat_map[y][x] = result
          if result > 3 || result < 2
             a[y][x] = 0
          else
             if ( cell == 0 && result == 3 ) || cell == 1
               a[y][x] = 1
             end
          end
        end
      end
      @petri = a
  
      if @migrations == @migration_rate
        @migrations = 0
        migrate
      end
  
      if @mutation_free_generations == @mutation_rate
        @mutation_free_generations = 0
        mutate
      end
  
    end

    def run(num_generations)
      num_generations.times do
        evolve
        render
      end
    end

  
    def migrate
      y = rand(@height)
      x = rand(@width)
      if @petri[y][x] == 0
        @petri[y][x] = 1
      else
        @petri[y][x] = 0
      end
    end
  
    def mutate
      @mutations += 1
      y = rand(@height)
      x = rand(@width)
      if @petri[y][x] == 1
        @mutations = 0
        @petri[y][x] = rand(@mutation_factor) + 1
      else
        if @mutations > 5
          @mutations = 0
          return
        else
          mutate
        end
      end
    end
  
    def print
      @petri.each do |row|
        puts row.inspect
      end
    end
  
    def render
      @petri.each do |row|
        line = ""
        row.each do |cell|
          if cell > 0
            line << "■"
          else
            line << " "
          end
        end
        puts line
      end
    end
  
    def render_heat_map
      @heat_map.each do |row|
        line = ""
        row.each do |cell|
          case cell
          when 7..8
            line << "█"
          when 5..6
            line << "■"
          when 3..4
            line << "·"
          else
            line << " "
          end
        end
        puts line
      end
    end
  
    def count
      @petri.flatten.reduce(:+)
    end
  
  
    private
  
    def substrate
      @petri = Array.new(0, nil)
      @height.times { @petri << Array.new(@width, 0) }
  
      @heat_map = Array.new(0, nil)
      @height.times { @heat_map << Array.new(@width, 0) }
  
    end
  
    def culture
      @petri.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          @petri[y][x] = (rand(100).to_i + 1) <= @probability ? 1 : 0
        end
      end
    end
  
    def calculate(x, y)
      retval = 0
      retval += @petri[y - 1][x - 1] if @petri[y - 1][x - 1]
      retval += @petri[y - 1][x] if @petri[y - 1][x]
      retval += @petri[y - 1][x + 1] if @petri[y - 1][x + 1]
      retval += @petri[y][x - 1] if @petri[y][x - 1]
      retval += @petri[y][x + 1] if @petri[y][x + 1]
      if @petri[y + 1]
        retval += @petri[y + 1][x - 1] if @petri[y + 1][x - 1]
        retval += @petri[y + 1][x] if @petri[y + 1][x]
        retval += @petri[y + 1][x + 1] if @petri[y + 1][x + 1]
      end
      retval
    end
  
  end

end



# Demonstration code:
#
# game = GameOfLife.new(80,20)
#
# while true
#   system("clear")
#   game.render_heat_map
#   puts "Count:       #{game.count}"
#   puts "Generations: #{game.generations}"
#   game.evolve
# end


require 'minitest/autorun'

class GameOfLifeTest < Minitest::Test

  def setup
    @world = GameOfLife.new(100,100)
  end

  def test_world
    assert_instance_of GameOfLife, @world
    assert_equal false, @world.petri.empty?
    assert @world.count > 0
  end

  def test_class
    assert_equal true, @world.respond_to?(:evolve)
    assert_equal true, @world.respond_to?(:migrate)
    assert_equal true, @world.respond_to?(:mutate)
    assert_equal true, @world.respond_to?(:render)
    assert_equal true, @world.respond_to?(:render_heat_map)
    assert_equal true, @world.respond_to?(:print)
  end

  def test_evolve
    assert_equal 0, @world.generations
    @world.evolve
    assert_equal 1, @world.generations
    5.times { @world.evolve }
    assert_equal 6, @world.generations
    assert @world.count > 0
    1000.times { @world.evolve }
    assert @world.count > 0
  end

end


