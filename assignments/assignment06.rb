# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class PriorityQueue  
  def initialize
    # your implementation here
    @qs = {high: [], medium: [], low: []}
    
  end

  def enqueue(item, priority=:medium)
    # your implementation here
    @qs[priority]<< item
    self
  end

  def dequeue
    # your implementation here 
    @qs[:high].shift || @qs[:medium].shift || @qs[:low].shift
  end

  def empty?
    # your implementation here
    @qs[:high].empty? && @qs[:medium].empty? && @qs[:low].empty?
  end

  def peek
    @qs[:high].first || @qs[:medium].first || @qs[:low].first
  end

  def length
    # your implementation here
    @qs[:high].length +  @qs[:medium].length + @qs[:low].length
  end

end


require 'minitest/autorun'

class TestMyClass < Minitest::Test
 
  def test_pq
    pq = PriorityQueue.new
    assert_instance_of PriorityQueue, pq

    assert_equal true, pq.empty?      

    pq.enqueue "first"
    assert_equal "first", pq.peek
    assert_equal false, pq.empty? 


    pq.enqueue "top", :high
    assert_equal "top", pq.peek

    pq.enqueue "last", :low
    assert_equal "top", pq.peek

    pq.enqueue "second"
    assert_equal "top", pq.peek

    pq.enqueue "another top", :high
    assert_equal "top", pq.peek

    assert_equal 5, pq.length 

    assert_equal "top", pq.dequeue    #=> "top"
    assert_equal "another top", pq.dequeue    #=> "another top"
    assert_equal "first", pq.dequeue    #=> "first"
    assert_equal "second", pq.dequeue    #=> "second"
    assert_equal "last", pq.dequeue    #=> "last"

    assert_equal true, pq.empty?   

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

pq.peek    #=> "top"
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
  def initialize(name, category, time, rating, ingredients, steps)
    @name = name
    @category = category
    @prep_time = time
    @rating = rating
    @ingredients = ingredients
    @steps = steps
  end
  
  def render_ingredients
    return if @ingredients.none?
    <<-DSL
      ingredients do 
      #{@ingredients.map {|i| "x \"#{i}\""}.join "\n"}
      end
    DSL
  end

  def render_steps
    return if @steps.none?
    <<-DSL
      steps do 
      #{@steps.map {|i| "x \"#{i}\""}.join "\n"}
      end
    DSL
  end


  def render_dsl
    # your code here
    <<-DSL
      recipe "#{name}" do 
        category "#{category}"
        rating "#{rating}"
        prep_time "#{prep_time}"

        #{render_ingredients}
        #{render_steps}

      end
    DSL
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

r = Recipe.new( "Scrambled Eggs", "breakfast", "10 mins", 4,
    [
    "2 eggs",
    "1/4 cup of milk",
    "1 tbsp butter",
    "dash of salt",
    "dash of pepper"
    ],
    [
    "crack eggs into medium mixing bowl",
    "whisk eggs",
    "add milk",
    "add salt & pepper to taste",
    "heat pan to medium high heat",
    "melt butter in pan",
    "once hot, add eggs to pan"
    ])

r.render_dsl

