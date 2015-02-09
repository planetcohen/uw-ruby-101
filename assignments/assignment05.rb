# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

class Class
  def prop_reader(prop_name)
    define_method prop_name do
      instance_variable_get "@#{prop_name}" 
    end
    #define_method "#{prop_name}=" {|val| instance_variable_set "@#{prop_name}", val }
  end
end

# expected results:
class PropReader
  prop_reader :flavor
#  def initialize(flavor)
#    @flavor = flavor
#  end
end



require 'minitest/autorun'

class TestPropReader < Minitest::Test
  def test_check
    assert true
  end
end

#obj = PropReader.new "spicy"
#obj.respond_to? :flavor     #=> true
#obj.respond_to? :"flavor="  #=> false
#obj.flavor                  #=> "spicy"
