# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests
def prop_reader(prop_name)
  prop_names.each do |prop_name|
    define_method prop_name do
      instance_variable_get "@#{prop_name}"
    end
  end
end

# expected results:
# class PropReader
#   prop_reader :flavor
#   def initialize(flavor)
#     @flavor = flavor
#   end
# end

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"
