# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# expected results:

class PropReader
  attr :flavor
  def initialize(flavor)
  	@flavor = flavor
  end
end

class Class
  def prop(prop_name)
   define_method prop_name do
    instance_variable_get "@#{prop_name}"
  end
   define_method "#{prop_name}=" do|value|
    instance_variable_set "@#{prop_name}", value
  end
 end
end

require 'minitest/autorun'

class TestPropReader < Minitest::Unit::TestCase # This adjustment was done via https://github.com/NREL/OpenStudio/issues/1345 for 64-bit Ruby on Windowss
  def setup
    obj = PropReader.new "spicy"
  end
  def test_prop_reader_respond1
    assert PropReader.respond_to? :flavor
  end
  def test_prop_reader_respond2
    refute PropReader.respond_to? :"flavor="
  end
  def test_prop_reader_flavor
    assert_equal obj, "spicy"
  end
end

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"
