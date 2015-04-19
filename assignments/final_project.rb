module FinalProject
class Cell
  attr_accessor :alive, :live_neighbors, :next_state
  def initialize(state=false)
  	@alive = state
  end

  def staying_alive
  	self.next_state = @alive ? [2,3].include?(@live_neighbors) : @live_neighbors == 3
  end

  def to_i
    @alive? 1 : 0
  end

  def to_s
    @alive ? '*' : ' '
  end
end

class GameOfLife
  attr_accessor :grid, :size

  def initialize(size=50)
  	@size = size
    #creates a two dimensional array of @size by @size unqiue cells with random initial states
  	@grid = Array.new(@size) {Array.new(@size) { Cell.new(rand(3).zero?)}}
  end
  
  def evolve
  	# apply rules to each cell and generate new state
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cell.live_neighbors = alive_neighbours(x, y)
      end
    end
    @grid.each {|row| row.each {|cell| cell.staying_alive}}
  end

  def alive_neighbours(x, y)
    #counting neighbor cells with state alive = true
    [[-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1], [-1, -1], [0, -1], [1, -1]].inject(0) do |sum, (neighbor_col, neighbor_row)|
      sum + @grid[(y + neighbor_row) % @size][(x + neighbor_col) % @size].to_i
    end
  end

  def render
    #renders @size by @size "grid" with "*" representing cells with alive = true
  	@grid.map { |row| row.join }.join("\n")
  end

  def run(num_generations=20)
  	(1..num_generations).each do |i|
  		evolve
  		system "clear"
  		puts render
      sleep(0.5)
  	end
  end
end
end

#-----------------------------------------------------------------------------------
require "minitest/autorun"

module FinalProject

  class TestCell < MiniTest::Unit::TestCase
    def setup
      @cell = Cell.new(true)
    end

    def test_cell_instance
      assert_instance_of Cell, @cell
    end

    def test_cell_attributes
      assert_respond_to @cell, :alive
      assert_respond_to @cell, :live_neighbors
      assert_respond_to @cell, :next_state
    end

    def test_cell_state
      assert @cell.alive == true
    end

    def test_cell_next_state
      assert @cell.next_state == nil
    end

    def test_live_neighbors
      assert @cell.live_neighbors == nil
    end

    def test_staying_alive
      @live_neighbors == 4
      assert @cell.staying_alive == false
    end

  end

  class TestGameBoard < MiniTest::Unit::TestCase
  	def setup
  	  @game = GameOfLife.new(3)
  	end

  	def test_gol_instance
  	  assert_instance_of GameOfLife, @game

  	  assert_respond_to @game, :grid
  	  assert_respond_to @game, :size
  	end

  	def test_gol_grid
  	  assert_equal 3, @game.size
  	  assert @game.grid.is_a?(Array)
  	  @game.grid.each do |row|
        assert row.is_a?(Array) 
        row.each do |cell|
          assert_instance_of Cell, cell
          assert_equal cell.alive, cell.alive
        end
      end
  	end
  end
end
