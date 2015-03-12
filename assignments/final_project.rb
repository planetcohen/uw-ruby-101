require 'minitest/autorun'
require_relative 'final_project.rb'

class TestGameOfLife < Minitest::Unit::TestCase
	attr_reader :game_1, :game_2, :game_3, :game_default, :cell_0_0, :cell_5_4, :cell_default, :cell_top_left, :cell_top_right, :cell_bottom_right, :cell_bottom_left, :game_neighbors
	def setup
		@game_1 = GameOfLife.new 10, 10, 30
		@game_2 = GameOfLife.new 20, 15, 100
		@game_3 = GameOfLife.new 99, 4, 111
		@game_default = GameOfLife.new         # if no params are passed
		@game_neighbors = GameOfLife.new 20, 70

		@cell_0_0 = Cell.new 0, 0
		@cell_5_4 = Cell.new 5, 4
		@cell_default = Cell.new
		@cell_top_left = Cell.new 0, 0
		@cell_top_right = Cell.new 5, 0
		@cell_bottom_right = Cell.new 5, 3
		@cell_bottom_left = Cell.new 0, 3
	end

	def test_initialize
		refute_nil @size
		assert_equal @game_1.width, 10
		assert_equal @game_2.height, 20
		assert_equal @game_3.num_generations, 111
		assert_equal @game_default.width, 5
		assert_equal @game_default.height, 4
		assert_equal @game_default.num_generations, 10

		assert_instance_of Array, @game_1.board
		@game_1.board.each do |row|
			#puts "in loop"
			assert row.instance_of? Array
		end

		assert_equal self.cell_5_4.x, 5
		assert_equal self.cell_5_4.y, 4
		assert_equal self.cell_0_0.x, 0
		assert_equal self.cell_0_0.y, 0
		assert_equal self.cell_default.x, 1
		assert_equal self.cell_default.y, 2
	end

	def test_evolve
		assert_respond_to self.game_neighbors, :evolve
		self.game_neighbors.evolve
	end

	def test_neighbors
		puts ""
		puts ""
		puts ""
		puts self.game_neighbors.to_s
		puts ""
		puts ""
		assert_respond_to self.game_neighbors, :neighbors
		assert_equal self.game_neighbors.neighbors(self.cell_0_0), x
		self.game_neighbors.neighbors(Cell.new 1, 1)

		assert_equal self.game_neighbors.neighbors(self.cell_top_left), true
		assert_equal self.game_neighbors.neighbors(Cell.new(0, 1)), true


		assert_equal self.game_neighbors.neighbors(self.cell_top_left), "top left cell"
		assert_equal self.game_neighbors.neighbors(self.cell_top_right), "top right cell"
		assert_equal self.game_neighbors.neighbors(self.cell_top_right), "bottom right cell"
		assert_equal self.game_neighbors.neighbors(self.cell_top_right), "bottom left cell"

		assert_equal self.game_1.width-1, self.game_1.neighbors(self.cell_0_0).y
		assert_equal self.game_1.height-1, self.game_1.neighbors(self.cell_0_0).x
		assert_equal self.game_2.height-1, self.game_2.neighbors(self.cell_0_0).x
		assert_equal self.game_2.width-1, self.game_2.neighbors(self.cell_0_0).y
		
	end


	def test_render
		assert_respond_to self.game_neighbors, :render
	end

	def test_run
		assert_respond_to self.game_neighbors, :run
	end
end
