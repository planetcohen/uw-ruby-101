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
  end
end

require 'minitest/autorun'
class TestMyClass < Minitest::Test
  def setup
    @prop_reader = PropReader.new "spicy"
  end

  def test_respond_to_flavor
    assert @prop_reader.respond_to? :flavor
  end

  def test_respond_to_flavoreq
    refute @prop_reader.respond_to? :"flavor="
  end

  def test_flavor_reader
    assert_equal @prop_reader.flavor, "spicy"
  end
end


# expected results:
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
