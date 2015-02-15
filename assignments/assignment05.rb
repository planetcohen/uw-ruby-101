# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests
def prop_reader(*prop_names)
  prop_names.each do |prop_name|
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

# obj = PropReader.new "spicy"
# obj.respond_to? :flavor     #=> true
# obj.respond_to? :"flavor="  #=> false
# obj.flavor                  #=> "spicy"

require 'minitest/autorun'

class TestAssignment05 < Minitest::Test
  def setup
  end
  
  def test_1
    obj = PropReader.new "spicy"
    assert obj.respond_to? :flavor
  end
  
  def test_2
    obj = PropReader.new "spicy"
    refute obj.respond_to? :"flavor="
  end

  def test_3
    obj = PropReader.new "spicy"
    assert_equal "spicy", obj.flavor
  end
end
