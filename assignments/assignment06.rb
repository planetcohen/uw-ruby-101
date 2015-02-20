# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue

  def initialize
      @low = Array.new
      @medium = Array.new
      @high = Array.new
  end

  def empty?
     @low.empty? && @medium.empty? && @high.empty?
  end

  def enqueue(item, priority=:medium)
    if priority ==:high
      @high << item
    elsif priority == :medium
      @medium << item
    else
      @low << item
    end
  end

  def dequeue
    if @high.empty?
      if @medium.empty?
        if @low.empty?
          nil
        else
        @low.pop
        end
      else
      @medium.pop
      end
    else
    @high.pop
    end
  end

  def peek
    @nodes.nil? ? nil : @nodes.item
  end

  def length
    @low.length + @medium.length + @high.length
  end

end


require 'minitest/autorun'

class TestPriorityQueue < Minitest::Unit::TestCase
  def setup
    pq = PriorityQueue.new
  end
  def test_01
    assert pq.empty?
  end
  def test_02
    pq.enqueue "first"
    assert pq.empty?
    pq.enqueue "top", :high
    pq.enqueue "last", :low
    pq.enqueue "second"
    pq.enqueue "another top", :high
  end
  def test_03
    assert pq.legnth == 5
    pq.dequeue
    pq.dequeue
    pq.dequeue
    pq.dequeue
  end

end

# expected results:
pq = PriorityQueue.new
pq.empty?      #=> true

pq.enqueue "first"
pq.empty?      #=> false

pq.enqueue "top", :high
pq.enqueue "last", :low
pq.enqueue "second"
pq.enqueue "another top", :high

pq.length     #=> 5

pq.dequeue    #=> "top"
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
    # your code here
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
