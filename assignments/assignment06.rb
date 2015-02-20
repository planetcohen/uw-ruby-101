# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

require 'minitest/autorun'

class PriorityQueue
  def initialize
    @low_priority = []
    @med_priority = []
    @high_priority = []
  end
  def enqueue(item, priority=:medium)
    case priority
+      when :high
+        @high_priority << item
+      when :medium
+        @med_priority << item
+      when :low
+        @low_priority << item
+    end
  end
  def dequeue
    if @high_priority.empty? nil : @high_priority.shift
    if @med_priority.empty? nil : @med_priority.shift
    if @low_priority.empty? nil : @low_priorirt.shift
  end
  def empty?
    length == 0
  end
  def peek
    if @high_priority.empty? nil : @high_priority.first
    if @med_priority.empty? nil : @med_priority.first
    if @low_priority.empty? nil : @low_priorirt.first
  end
  def length
    @items_high.length + @items_medium.length + @items_low.length
  end
end

+class PriorityQueueTest < Minitest::Test
+  def priority_test_queue
+    pq = PriorityQueue.new
+    assert_empty pq
+    pq.enqueue "first"
+    refute_empty pq
+    pq.enqueue "top", :high
+    pq.enqueue "last", :low
+    pq.enqueue "second"
+    pq.enqueue "another top", :high
+    assert_equal 5, pq.length
+    assert_equal "top", pq.dequeue
+    assert_equal "another top", pq.dequeue
+    assert_equal "first", pq.dequeue
+    assert_equal "second", pq.dequeue
+    assert_equal "last", pq.dequeue
+  end
+end

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
