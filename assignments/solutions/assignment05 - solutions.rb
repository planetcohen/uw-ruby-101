# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# expected results:

class Class
  def prop_reader(prop_name)
    define_method prop_name do
      instance_variable_get "@#{prop_name}" 
    end
  end
end


class PropReader
  prop_reader :flavor
  def initialize(flavor)
    @flavor = flavor
  end
end

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"

################


require 'minitest/autorun'

class TestPropReader < Minitest::Test
  def test_class
    pr = PropReader.new("to_use")
    assert_equal "to_use", pr.flavor
    assert pr.respond_to? :flavor
    refute pr.respond_to? :"flavor="
  end
end