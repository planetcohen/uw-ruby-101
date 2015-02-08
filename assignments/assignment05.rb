# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# prop_reader implementation:

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

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"


# MiniTest unit tests:

require 'minitest/autorun'

class TestPropReader < Minitest::Test

  def setup
    @spicy = PropReader.new "spicy"
    @vanilla = PropReader.new "vanilla"
    @haupia = PropReader.new "haupia"
  end

  def test_class
    assert_instance_of PropReader, @spicy
    assert_instance_of PropReader, @vanilla
    assert_instance_of PropReader, @haupia
  end

  def test_flavor
    assert_equal "spicy", @spicy.flavor
    assert_equal "vanilla", @vanilla.flavor
    assert_equal "haupia", @haupia.flavor
  end

  def test_reader
    assert_equal true, @spicy.respond_to?(:flavor)
    assert_equal true, @vanilla.respond_to?(:flavor)
    assert_equal true, @haupia.respond_to?(:flavor)
  end

  def test_writer
    assert_equal false, @spicy.respond_to?(:"flavor=")
    assert_equal false, @vanilla.respond_to?(:"flavor=")
    assert_equal false, @haupia.respond_to?(:"flavor=")
  end

end


