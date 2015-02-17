# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

require 'minitest/autorun'

class Class
  def prop_reader(prop_name)
  	define_method prop_name do
  	  instance_variable_get "@#{prop_name}"
  	end
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

class PropReaderTest < Minitest::Test
  def setup
  	@spicy = PropReader.new "spicy"
  	@chocolate = PropReader.new "chocolate"
  end

  def test_instance
  	assert_instance_of PropReader, @spicy
  	assert_instance_of PropReader, @chocolate
  end

  def test_read
  	assert @spicy.respond_to? :flavor
  	assert @chocolate.respond_to? :flavor
  end

  def test_write
    refute @spicy.respond_to? :"flavor="
    refute @chocolate.respond_to? :"flavor="
  end

  def test_flavor
  	assert_equal "spicy", @spicy.flavor
  	assert_equal "chocolate", @chocolate.flavor
  end

end



