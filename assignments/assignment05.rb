# ========================================================================================
# Assignment 5
# ========================================================================================

require 'minitest/autorun'

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

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

# expected results:

class PropReaderTest < Minitest::Test
  # obj = PropReader.new "spicy"
  def setup
    @prop_reader = PropReader.new "spicy"
  end

  # obj.respond_to? :flavor #=> true
  def test_respond_to_flavor
    assert @prop_reader.respond_to? :flavor
  end

  # obj.respond_to? :"flavor=" #=> false
  def test_not_respond_to_flavor=
    refute @prop_reader.respond_to? :"flavor="
  end

  # obj.flavor #=> "spicy"
  def test_flavor_equals
    assert_equal @prop_reader.flavor, "spicy"
  end
end
