# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests
module Assignment6
  require 'minitest/autorun'
  
  class PriorityQueue

    class SubQueue
      attr :rank, :items
      def initialize(rank)
         @rank = rank
         @items = []
      end
      def enqueue(item)
        @items<<item
      end
      def dequeue
        @items.shift
      end
      def empty?
        @items.empty?
      end
      def peek
        @items[0]
      end
      def length
        @items.length
      end
    end #SubQueue
    
    def initialize
      @high_sq = SubQueue.new(:high)
      @medium_sq = SubQueue.new(:medium)
      @low_sq = SubQueue.new(:low)
      @sq_names = {high: @high_sq, medium: @medium_sq, low: @low_sq} 
    end
    def enqueue(item, priority=:medium)
      subqueue = @sq_names.select {|i| i == priority}.values[0]
      subqueue.enqueue(item)
    end
    def dequeue
      if  @high_sq.length > 0
        @high_sq.dequeue
      elsif  @medium_sq.length > 0
        @medium_sq.dequeue
      else 
        @low_sq.dequeue
      end
    end
    def empty?
      ary = @high_sq.items + @medium_sq.items + @low_sq.items
      ary.empty?
    end
    def peek
      if  @high_sq.length > 0
        @high_sq.peek
      elsif  @medium_sq.length > 0
        @medium_sq.peek
      else 
        @low_sq.peek
      end
    end
    def length
      ary = @high_sq.items + @medium_sq.items + @low_sq.items
      ary.length
    end
  end #PriorityQueue

  
  class TestPriorityQueue < MiniTest::Test
    def test_one
      pq = PriorityQueue.new
      assert pq.empty?
      pq.enqueue "first"
      refute pq.empty?
      
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
  end #class
  


# ========================================================================================
#  Problem 2 - Recipe to DSL

# render a Recipe object to Recipe DSL

  class Recipe
    attr_accessor :steps, :ingredients, :name, :category, :prep_time, :rating
    def initialize(name)
      @name = name
    end
    
    def render_dsl
      dsl = RecipeExport.new(self)
      puts dsl.create_dsl
    end
  end
  

  
  class RecipeExport
  
    def initialize(recipe)
      @ingredients = recipe.ingredients
      @steps = recipe.steps
      @name = recipe.name
    end
  
    def create_dsl
    <<-DSL.gsub /^\s+/, "" 
    recipe "#{@name}" do
      #{ingredients}
      #{steps}
    end
    DSL
    end
    
    def ingredients
    <<-INGREDIENTS
      ingredients do
        #{@ingredients.map {|i| ingredient(i)}.join "" }
      end
    INGREDIENTS
    end
   
    def ingredient(ingredient)
    <<-ING
      x "#{ingredient}"
    ING
    end
    
    def step(step)
    <<-STEP
      x "#{step}"
    STEP
    end
    
    def steps
    <<-STEPS
      steps do
        #{@steps.map {|s| step(s)}.join "" }
      end
    STEPS
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
  end #RecipeBuilder

  def recipe(name, &block)
    rb = RecipeBuilder.new
    rb.recipe(name, &block)
  end 

  eggs = recipe "Scrambled Eggs" do
    ingredients do
      x "eggs"
      x "salt"
      x "pepper"
      x "butter"
    end
    steps do
      x "crack eggs"
      x "cook eggs"
    end
   end
  
end #module
