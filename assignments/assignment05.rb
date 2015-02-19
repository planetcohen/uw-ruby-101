# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# expected results:
# class PropReader
#   prop_reader :flavor
#   def initialize(flavor)
#     @flavor = flavor
#   end
# end
#
# obj = PropReader.new "spicy"
# obj.respond_to? :flavor     #=> true
# obj.respond_to? :"flavor="  #=> false
# obj.flavor                  #=> "spicy"


class Class
  def prop(*prop_names)
    prop_names.each do |prop_name|
      define_method prop_name do
        instance_variable_get "@#{prop_name}"
      end
    end
  end
end

class PropReader
  prop :flavor
  def initialize(flavor)
    @flavor = flavor
  end
end



require 'minitest/autorun'

class TestPropReader < Minitest::Test
  def test_flavor_is_defined
    obj = PropReader.new "spicy"
    assert obj.respond_to? :flavor
    refute obj.respond_to? :"flavor="
    assert_equal "spicy", obj.flavor
  end

end
