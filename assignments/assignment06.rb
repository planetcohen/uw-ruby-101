# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue
  def initialize
    @queue_high = []
    @queue_medium = []
    @queue_low = []
  end

  def enqueue(item, priority=:medium)
    if priority == :high
      @queue_high << item
    elsif priority == :medium
      @queue_medium << item
    elsif priority == :low
      @queue_low << item
    end
  end

  def dequeue
    if @queue_high.empty? == false
      @queue_high.shift
    elsif @queue_medium.empty? == false
      @queue_medium.shift
    elsif @queue_low.empty? == false
      @queue_low.shift
    else
      nil
    end
  end

  def empty?
    if @queue_low.empty? and @queue_medium.empty? and @queue_low.empty?
      true
    else
      false
    end
  end

  def peek
    if @queue_high.empty? == false
      @queue_high.first
    elsif @queue_medium.empty? == false
      @queue_medium.first
    elsif @queue_low.empty? == false
      @queue_low.first
    else
      nil
    end
  end
  def length
    @queue_low.length + @queue_medium.length + @queue_high.length
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
