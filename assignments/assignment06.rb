# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

class Priority_Queue
  attr :list, :nL, :nH, :length
  def initialize
    @list = []
    @nL = 0
    @nH = 0
    @length = 0
  end

  def enqueue(item, priority = :normal)
    entry = {item: item, priority: priority}
    case priority
    when :high
      @list.insert(@length - @nH, entry)
      @nH += 1
    when :low
      @list.insert(0, entry)
      @nL += 1
    else
      @list.insert(@nL, entry)
    end
    @length += 1
  end

  def dequeue
    if @length > 0
      last = @list.pop
      if last[:priority] == :high
        @nH -= 1
      elsif last[:priority] == :low
        @nL -= 1
      end
      @length -= 1
      last[:item]
    else
      nil
    end
  end

  def empty?
    @length == 0
  end

  def peek
    @last
  end
end


require 'minitest/autorun'

class TestPriorityQueue < Minitest::Test
  def test_create_object
    pq = Priority_Queue.new
    assert_equal [], pq.list
    assert_equal true, pq.empty?
  end

  def test_enqueue
    pq = Priority_Queue.new
    pq.enqueue "first"
    assert_equal false, pq.empty?
  end

  def test_priority
    pq = Priority_Queue.new
    pq.enqueue "first"
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


# # expected results:
# pq = PriorityQueue.new
# pq.empty?      #=> true

# pq.enqueue "first"
# pq.empty?      #=> false

# pq.enqueue "top", :high
# pq.enqueue "last", :low
# pq.enqueue "second"
# pq.enqueue "another top", :high

# pq.length     #=> 5

# pq.dequeue    #=> "top"
# pq.dequeue    #=> "another top"
# pq.dequeue    #=> "first"
# pq.dequeue    #=> "second"
# pq.dequeue    #=> "last"


# ========================================================================================
#  Problem 2 - Recipe to DSL

# render a Recipe object to Recipe DSL

class Recipe
  attr_accessor :steps, :ingredients, :name, :category, :prep_time, :rating
  def initialize(name)
    @name = name
  end

  def render_dsl
    def render_ingredients
      list_i = ""
      @ingredients.each do |i|
         list_i << "    x \""+i.to_s+"\"\n"
      end
      list_i.chomp
    end

    def render_steps
      list_s = ""
      @steps.each do |s|
         list_s << "    x \""+s.to_s+"\"\n"
      end
      list_s.chomp
    end

    dsl =
<<RECIPE
recipe "#{@name}" do
  category "#{@category}"
  prep_time "#{@prep_time}"
  rating #{@rating}
  ingredients do
#{render_ingredients}
  end
  steps do
#{render_steps}
  end
end
RECIPE
    # puts dsl
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


require 'minitest/autorun'

class TestDSLRender < Minitest::Test
  def test_dsl_render
    r = recipe "Bacon" do
      category "delicious"
      prep_time "15 min"
      rating 5
      ingredients do
        x "bacon"
        x "so much bacon"
      end
      steps do
        x "lay down ya bacon"
        x "sizzle it"
      end
    end

    r_compare =
<<RECIPE
recipe "Bacon" do
  category "delicious"
  prep_time "15 min"
  rating 5
  ingredients do
    x "bacon"
    x "so much bacon"
  end
  steps do
    x "lay down ya bacon"
    x "sizzle it"
  end
end
RECIPE
     assert_equal r.render_dsl, r_compare
  end

end
