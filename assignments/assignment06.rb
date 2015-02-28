# ========================================================================================
# Assignment 6
# ========================================================================================

# ========================================================================================
#  Problem 1 - PriorityQueue

# implement a PriorityQueue, validate using MiniTest unit tests
module Assignment06

class PriorityQueue
  def initialize
    @items_high = []
    @items_medium = []
    @items_low = []
  end

  def enqueue(item, priority=:medium)
    if priority == :high
      @items_high << item
    elsif priority == :low
      @items_low << item
    else
      @items_medium << item
    end
  end

  def dequeue
    if @items_high.empty?
      if @items_medium.empty?
        if @items_low.empty?
          return nil
        else
          @items_low.shift
        end
      else
        @items_medium.shift
      end
    else 
      @items_high.shift
    end
  end

  def empty?
    @items_high.empty? && @items_medium.empty? && @items_low.empty?
  end

  def peek
    if @items_high.empty?
      if @items_medium.empty?
        if @items_low.empty?
          nil
        else
          @items_low.first
        end
      else
        @items_medium.first
      end
    else 
      @items_high.first
    end
  end

  def length
    @items_high.length + @items_medium.length + @items_low.length
  end
end

end # module Assignment06
# expected results:
pq = Assignment06::PriorityQueue.new
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
    # refactor for heredocs and blocks
    str_output = "recipe \"" + @name + "\" do\n"
    if @category != nil
      str_output += "  category \"" + @category + "\"\n"
    end
    if @prep_time != nil
      str_output += "  prep_time \"" + @prep_time + "\"\n"
    end
    if @rating != nil
      str_output += "  rating " + @rating.to_s + "\n"
    end
    if @ingredients.length > 0
        str_output += "  ingredients do\n"
        str_temp = []
        str_temp << @ingredients.map {|ingredient| "x \"" +  ingredient}
        str_output += str_temp.join "\n"
        str_output += "\n  end\n"
    end
    if @steps.length > 0
        str_output += "  steps do\n"
        str_temp << @steps.map {|step| "x \"" +  step}
        str_output += str_temp.join "\n"
        str_output += "\n  end\n"
    end
    str_output += "end\n"
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
