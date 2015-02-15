# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests



class Class
  def prop_reader(*prop_names)
    prop_names.each do |prop_name|
      define_method prop_name do
        instance_variable_get "@#{prop_name}"
      end
    end
  end
end

require 'minitest/autorun'

class TestMyClass < Minitest::Test
  def setup
    @obj = PropReader.new "spicy"
    assert_instance_of PropReader, @obj
  end

  def test_respond_to_flavor_Reader
    assert_respond_to @obj, :flavor
  end
  
  def test_respond_to_flavor_writer
    result = @obj.respond_to? :"flavor="
    assert_equal false, result
  end
  
  def test_flavor_reader
    assert_equal "spicy", @obj.flavor
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
