# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

require 'minitest/autorun'

class Element
  #include Comparable

  attr_accessor :name, :priority

  def initialize(name, priority=:medium)
    if priority == :high
      priority = 4
    elsif priority == :medium
      priority = 3
    else priority == :low
      priority = 1
    end
    @name, @priority=name, priority
  end

  def <=>(other)
    @priority <=> other.priority
  end
end

class PriorityQueue

  attr_accessor :elements

  def initialize
    @elements = []
  end

  def enqueue(element)#<<(element)
    @elements<<element
  end

  def empty?
    @elements.empty?
  end

  def dequeue
    last_element_index = @elements.size - 1
    @elements.sort!
    @elements.delete_at(last_element_index)
  end

  def peek
    @elements[-1]
  end

  def length
    @elements.size
  end
end

q = PriorityQueue.new
q.empty?
q.enqueue(Element.new("first"))
q.empty?

q.enqueue(Element.new("top", :high))
q.enqueue(Element.new("last", :low))
q.enqueue(Element.new("second"))
q.enqueue(Element.new("another top", :high))

q.length

q.dequeue
q.dequeue
q.dequeue
q.dequeue
q.dequeue

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
