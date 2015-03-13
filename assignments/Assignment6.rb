#ASSIGNMENT 6

#========================================= ASSIGNMENT #6 #1

class PriorityQueue
	def initialize
		@high_hash = {}
		@medium_hash = {}
		@low_hash = {}
	end

	def enqueue(item, priority=:medium)
		if priority == :high
			@high_hash[item] = priority
		elsif priority == :medium
			@medium_hash[item] = priority
		elsif priority == :low
			@low_hash[item] = priority
		end
	end

	def dequeue
		if ! @high_hash.empty?
			@high_hash.shift
		elsif ! @medium_hash.empty?
			@medium_hash.shift
		elsif ! @low_hash.empty?
			@low_hash.shift
		end
	end

	def empty?
		if @high_hash.empty? and @medium_hash.empty? and @low_hash.empty?
			return true
		else
			return false
		end
	end

	def peek
		if ! @high_hash.empty?
			@high_hash.keys[0]
		elsif ! @medium_hash.empty?
			@medium_hash.keys[0]
		elsif ! @low_hash.empty?
			@low_hash.keys[0]
		end
	end

	def length
		@high_hash.count + @medium_hash.count + @low_hash.count
	end
end

class PriorityTest < Minitest::Test

	def test_hacker
		pq = PriorityQueue.new
		assert_empty pq
		assert_equal pq.enqueue("first"), :medium
		refute_empty pq
		assert_equal pq.enqueue("top", :high), :high
		assert_equal pq.enqueue("last", :low), :low
		assert_equal pq.enqueue("second"), :medium
		assert_equal pq.enqueue("another top", :high), :high
		assert_equal pq.length, 5
		assert_equal pq.dequeue[0], "top"
		assert_equal pq.dequeue[0], "another top"
		assert_equal pq.dequeue[0], "first"
		assert_equal pq.dequeue[0], "second"
		assert_equal pq.dequeue[0], "last"
	end
end

#============================== RECIPE TO DSL, HW 6 PROBLEM 2

class Recipe
	attr_accessor :steps, :ingredients, :name, :category, :prep_time, :rating
	def initialize(name, ingredients, prep_time, category, rating, steps)
		@name = name
		@ingredients = ingredients
		@prep_time = prep_time
		@category = category
		@rating = rating
		@steps = steps
	end

	def recipe_name
		@name.map {|nam| "-#{nam}"}
	end
	
	def recipe_ingredients
		@ingredients.map {|ing| "- #{ing}"}
	end

	def recipe_prep_time
		@prep_time.map {|pt| "- #{pt}"}
	end

	def recipe_category
		@category.map {|cat| "-#{cat}"}
	end

	def recipe_rating
		@rating.map {|rate| "- #{rate}"}
	end

	def recipe_steps
		@steps.map {|stp| "- #{stp}"}
	end

	def render_dsl
		html do
			head do
				title Recipe
				stylesheet_link_tag 'scaffold'
			end
			
			body do
				"#{recipe_name}"
				"#{recipe_prep_time}"
				"#{recipe_category}"
				"#{recipe_rating}"
				"#{recipe_ingredients}"
				"#{recipe_steps}"
			end
		end
	end
end

ingred = ["tortilla", "ground beef", "guac", "cheese"]
nombr = ["The Texas Taco"]
categ = ["TexMex"]
prep_t = ["15 minutes"]
rated = ["8 out of 10"]
stepp = ["cook ground beef", "cut guac", "spread equal amounts of each #{ingred[1]},
#{ingred[2]}, and #{ingred[3]} on a #{ingred[0]}"]

new_recipe = Recipe.new(ingred, nombr, categ, prep_t, rated, stepp)
new_recipe.render_dsl
