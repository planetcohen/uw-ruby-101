# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue

  class Node
    attr_accessor :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end
  end

  def initialize
    # your implementation here
    @hi_q = nil
    @md_q = nil
    @lo_q = nil
  end

  def enqueue(item, priority=:medium)
    # your implementation here
    case priority
    when :high
      @hi_q = Node.new(item, @hi_q)
    when :medium
      @md_q = Node.new(item, @md_q)
    when :low
      @lo_q = Node.new(item, @lo_q)
    else
      puts "Error: unknown priority, #{item} not enqueued"
    end
  end

  def dequeue
    # your implementation here

    node = @hi_q
    while node
      if node.link.nil?
        @hi_q = nil
        return node.item
      elsif node.link.link.nil?
        retval = node.link.item
        node.link = nil
        return retval
      end
      node = node.link
    end

    node = @md_q
    while node
      if node.link.nil?
        @md_q = nil
        return node.item
      elsif node.link.link.nil?
        retval = node.link.item
        node.link = nil
        return retval
      end
      node = node.link
    end

    node = @lo_q
    while node
      if node.link.nil?
        @lo_q = nil
        return node.item
      elsif node.link.link.nil?
        retval = node.link.item
        node.link = nil
        return retval
      end
      node = node.link
    end

  end

  def empty?
    # your implementation here
    if ( @hi_q.nil? && @md_q.nil? ) && @lo_q.nil?
      true
    else
      false
    end
  end

  def peek
    # your implementation here
    node = @hi_q
    while node
      if node.link.nil?
        return node.item
      end
      node = node.link
    end

    node = @md_q
    while node
      if node.link.nil?
        return node.item
      end
      node = node.link
    end

    node = @lo_q
    while node
      if node.link.nil?
        return node.item
      end
      node = node.link
    end

  end

  def length
    # your implementation here
    count = 0
    node = @hi_q
    while node
      count += 1
      node = node.link
    end
    node = @md_q
    while node
      count += 1
      node = node.link
    end
    node = @lo_q
    while node
      count += 1
      node = node.link
    end
    count
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



# MiniTest unit tests:

require 'minitest/autorun'

class PriorityQueueTest < Minitest::Test

  def setup
    @pq = PriorityQueue.new
  end

  def test_class
    assert_instance_of PriorityQueue, @pq
    assert_equal true, @pq.empty?

    assert_equal true, @pq.respond_to?(:enqueue)
    @pq.enqueue "first"
    @pq.enqueue "top", :high
    @pq.enqueue "last", :low
    @pq.enqueue "second"
    @pq.enqueue "another top", :high

    assert_equal true, @pq.respond_to?(:length)
    assert_equal 5, @pq.length

    assert_equal false, @pq.empty?

    assert_equal true, @pq.respond_to?(:peek)
    assert_equal "top", @pq.peek

    assert_equal true, @pq.respond_to?(:dequeue)
    assert_equal "top", @pq.dequeue
    assert_equal "another top", @pq.dequeue
    assert_equal "first", @pq.dequeue
    assert_equal "second", @pq.dequeue
    assert_equal "last", @pq.dequeue

    assert_equal true, @pq.empty?

  end

end


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
    puts "#{self.class.to_s.downcase} \"#{@name}\" do"
    my_methods = self.methods - Object.methods
    my_methods.delete(__method__)
    my_methods.each do |method|
      unless method =~ /=/
        if self.send(method).kind_of? Array
          puts "  #{method.to_s} do"
          self.send(method).each do |item|
            puts "    x \"#{item}\""
          end
          puts "  end"
        else
          puts "  #{method.to_s} \"#{self.send(method)}\""
        end
      end
    end
    puts "end"
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
