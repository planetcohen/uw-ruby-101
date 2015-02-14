# ========================================================================================
# Assignment 5
# ========================================================================================

require 'minitest/autorun'

load 'assignment04.rb'

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue
  def initialize
    @low = LinkedList.new
    @medium = LinkedList.new
    @high = LinkedList.new
  end

  def enqueue(item, priority=:medium)
    case priority
      when :high
        @high << item
      when :medium
        @medium << item
      when :low
        @low << item
    end
  end

  def dequeue
    queue = get_queue
    return nil if queue.nil?
    queue.delete queue.first
  end

  def empty?
    length == 0
  end

  def peek
    queue = get_queue
    queue.nil? ? nil : queue.first
  end

  def length
    @low.length + @medium.length + @high.length
  end

  private

  def get_queue
    return @high if not @high.empty?
    return @medium if not @medium.empty?
    @low
  end
end

# expected results:
# pq = PriorityQueue.new
# pq.empty?      #=> true
#
# pq.enqueue "first"
# pq.empty?      #=> false
#
# pq.enqueue "top", :high
# pq.enqueue "last", :low
# pq.enqueue "second"
# pq.enqueue "another top", :high
#
# pq.length     #=> 5
#
# pq.dequeue    #=> "top"
# pq.dequeue    #=> "another top"
# pq.dequeue    #=> "first"
# pq.dequeue    #=> "second"
# pq.dequeue    #=> "last"

class PriorityQueueTest < Minitest::Test
  def test_priority_queue
    pq = PriorityQueue.new
    assert_empty pq
    pq.enqueue "first"
    refute_empty pq
    pq.enqueue "top", :high
    pq.enqueue "last", :low
    pq.enqueue "second"
    pq.enqueue "another top", :high
    assert_equal 5, pq.length
    assert_equal "top", pq.dequeue
    assert_equal "another top", pq.dequeue
    assert_equal "first", pq.dequeue
    assert_equal "second", pq.dequeue
    assert_equal "last", pq.dequeue
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
    def render_recipe(s, &block)
      s << "recipe \"#{@name}\" do\n"
      block.call
      s << "end\n"
    end

    def render_additional_properties(s)
      s << "  category \"#{@category}\"\n"
      s << "  prep_time \"#{prep_time}\"\n"
      s << "  rating #{rating}\n"
    end

    def render_ingredients(s)
      s << "  ingredients do\n"
      render_items(s, @ingredients)
      s << "  end\n"
    end

    def render_steps(s)
      s << "  steps do\n"
      render_items(s, @steps)
      s << "  end\n"
    end

    def render_items(s, items)
      items.each { |item| s << "    x \"#{item}\"\n" }
    end

    # your code here

    s = ''

    render_recipe(s) do
      render_additional_properties(s)
      render_ingredients(s)
      render_steps(s)
    end

    s
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

class RecipeTest < Minitest::Test
  def test_render_dsl
    dsl = <<RECIPE
recipe "Scrambled Eggs" do
  category "breakfast"
  prep_time "10 mins"
  rating 4
  ingredients do
    x "2 eggs"
    x "1/4 cup of milk"
    x "1 tbsp butter"
    x "dash of salt"
    x "dash of pepper"
  end
  steps do
    x "crack eggs into medium mixing bowl"
    x "whisk eggs"
    x "add milk"
    x "add salt & pepper to taste"
    x "heat pan to medium high heat"
    x "melt butter in pan"
    x "once hot, add eggs to pan"
  end
end
RECIPE

    recipe = eval(dsl)

    assert_equal dsl, recipe.render_dsl
  end
end
