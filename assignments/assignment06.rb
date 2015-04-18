# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests

module Assignment06
  class PriorityQueue
    def initialize
      @items = []
    end

    def enqueue(item,priority=:medium)
      new_item = []
      new_item << {item: item, priority: priority}

      if @items.empty?
        @items << {item: item, priority: priority}
        @items.last[:item]
    
      elsif new_item.last[:priority] == :medium and @items.last[:priority] == :low
        if @items.first[:priority] == :low
          @items.unshift({item: item, priority: priority})
          @items.last[:item]
        else
          h = @items.rindex {|x| x[:priority] == :medium} + 1
          @items.insert(h, {item: item, priority: priority})
          @items.last[:item]
        end
      elsif new_item.last[:priority] == :high and @items.last[:priority] == :medium
        if @items.first[:priority] == :medium
          @items.unshift({item: item, priority: priority})
          @items.last[:item]
        else
          h = @items.rindex {|x| x[:priority] == :high} + 1
          @items.insert(h, {item: item, priority: priority})
          @items.last[:item]
        end
      elsif new_item.last[:priority] == :high and @items.last[:priority] == :low
        if @items.first[:priority] == :low or @items.first[:priority] == :medium
        @items.unshift({item: item, priority: priority})
        @items.last[:item]
        else
          h = @items.rindex {|x| x[:priority] == :high} + 1
          @items.insert(h, {item: item, priority: priority})
          @items.last[:item]
        end
      else
        @items << {item: item, priority: priority}
        @items.last[:item]
      end
    end
   
    def dequeue
      @items.empty? ? nil : @items.shift[:item]
    end

    def empty?
      @items.empty?
    end

    def peek
      @items.first[:item]
    end

    def length
      @items.length
    end
  end

  require 'minitest/autorun'

  class TestPriorityQueue < MiniTest::Test
    def test_priorityqueue
      pq = PriorityQueue.new
      a = pq.empty?
      assert_equal a, true
      b = pq.length
      assert_equal b, 0
      c = pq.enqueue "first"
      assert_equal c, "first"
      d = pq.length
      assert_equal d, 1
      e = pq.empty?
      assert_equal e, false
      f = pq.peek
      assert_equal f, "first"
      pq.enqueue "top", :high
      g = pq.peek
      assert_equal g, "top"
      h = pq.length
      assert_equal h, 2
      pq.enqueue "last", :low
      pq.enqueue "second"
      pq.enqueue "another top", :high
      j = pq.length
      assert_equal j, 5
      k = pq.dequeue
      assert_equal k, "top"
      l = pq.length
      assert_equal l, 4
      m = pq.dequeue
      assert_equal m, "another top"
      n = pq.dequeue
      assert_equal n, "first"
      o = pq.dequeue 
      assert_equal o, "second"
      p = pq.dequeue
      assert_equal p, "last"
      q = pq.empty?
      assert_equal q, true
      r = pq.length
      assert_equal r, 0
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
  
    def render_ingredients
      <<-INGREDIENTS
        ingredients do
          #{ingredients.map {|i| "x \"#{i}\""}}.join "\n"}
        end
      INGREDIENTS
    end

    def render_steps
      <<-STEPS
        steps do
          #{steps.map {|s| "x \"#{s}\""}}.join "\n"}
        end
      STEPS
    end

    def render_dsl
      <<-RECIPE
        recipe "#{name}" do
          category "#{category}"
          prep_time "#{prep_time}"
          rating "#{rating}"
          #{render_ingredients}
          #{render_steps}
        end
      RECIPE
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

  class TestRecipe < MiniTest::Test
    def test_recipe
      eggs = recipe "Scrambled Eggs" do
              category "breakfast"
              prep_time "10 minutes"
              rating 4
              ingredients do
              x "2 eggs"
              x "1/4 cup of milk"
              x "1 tbsp of butter"
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
      assert_equal eggs.name, "Scrambled Eggs"
      assert_equal eggs.steps, ["crack eggs into medium mixing bowl", "whisk eggs", "add milk", "add salt & pepper to taste", "heat pan to medium high heat", "melt butter in pan", "once hot, add eggs to pan"]
      assert_equal eggs.ingredients, ["2 eggs", "1/4 cup of milk", "1 tbsp of butter", "dash of salt", "dash of pepper"]
      assert_equal eggs.category, "breakfast"
      assert_equal eggs.prep_time, "10 minutes"
      assert_equal eggs.rating, 4
    end
  end
end