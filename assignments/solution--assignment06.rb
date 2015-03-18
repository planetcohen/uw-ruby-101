# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue
  attr_accessor :size, :peek
  def initialize
    @high = []
    @medium = []
    @low = []
    @bag = []
    @peek = -1
    @size = 0
  end
  def enqueue(item, priority=:medium)
    if priority == :high
      @high.push(item).reverse!
    elsif priority == :low
      @low.unshift(item)
    else
      @medium.push(item).reverse!
    end
    @size += 1
    @bag = @low + @medium + @high
  end
  def dequeue
    if empty?
      nil
    else
      @size -= 1
      @bag.pop
    end
  end
  def empty?
    @size == 0
  end
  def peek
    @bag[@peek]
  end
  def length
    @size
  end
  def to_s
    "#{@bag}"
  end
end

require "minitest/autorun"
class TestPriorityQueue < Minitest::Test
  def setup
    @priorityqueue = PriorityQueue.new
  end
  def test_one
    assert @priorityqueue.empty?, "This should be true"
    @priorityqueue.enqueue "first"
    refute @priorityqueue.empty?, "This should be false"
    @priorityqueue.enqueue "top", :high
    @priorityqueue.enqueue "last", :low
    @priorityqueue.enqueue "second"
    @priorityqueue.enqueue "another top", :high
    assert_equal 5, @priorityqueue.length, "The length of the items is wrong"
    assert_equal "top", @priorityqueue.dequeue, "This should be \"top\""
    assert_equal "another top", @priorityqueue.dequeue, "This should be \"another top\""
    assert_equal "first", @priorityqueue.dequeue, "This should be \"first\""
    assert_equal "second", @priorityqueue.dequeue, "This should be \"second\""
    assert_equal "last", @priorityqueue.dequeue, "This should be \"last\""
  end
end

# expected results:
pq = PriorityQueue.new
pq.empty?      #=> true

pq.enqueue "first"
pq.empty?      #=> false

pq.enqueue "top", :high
pq.enqueue "last", :low
pq.peek
pq.enqueue "second"
pq.enqueue "another top", :high

pq.length     #=> 5

pq.dequeue    #=> "top"
pq.length
pq.dequeue    #=> "another top"
pq.dequeue    #=> "first"
pq.dequeue    #=> "second"
pq.dequeue    #=> "last"


# ========================================================================================
#  Problem 2 - Recipe to DSL

# render a Recipe object to Recipe DSL

class Recipe
  attr_accessor :steps, :ingredients, :name, :category, :prep_time, :rating
  def initialize(name)
    @name = name
  end
  
  def render_dsl
    <<-PRINT
      RECIPE: #{name}
      Category: #{category}
      Time: #{prep_time}
    PRINT
  end
end

class RecipeBuilder
  def recipe(name, &block)
    @recipe = Recipe.new(name)
    self.instance_eval &block
    @recipe
  end
  
  def category(value)
    @recipe.category = value
  end
  
  def prep_time(value)
    @recipe.prep_time = value
  end
  
  def rating(value)
    @recipe.rating = value
  end
  
  def ingredients(&block)
    @recipe.ingredients = []
    @items = @recipe.ingredients
    self.instance_eval &block
  end
  
  def steps(&block)
    @recipe.steps = []
    @items = @recipe.steps
    self.instance_eval &block
  end
  
  def x(item)
    @items << item
  end
end

def recipe(name, &block)
  rb = RecipeBuilder.new
  rb.recipe(name, &block)
end
