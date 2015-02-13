# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# expected results:

require 'minitest/autorun'

class Class
	#prop_reader :flavor

	def prop_reader(*flavors)
		flavors.each do |flavor|
	    define_method flavor do
	      instance_variable_get "@#{flavor}"
	    end
		end
	end

  def initialize(flavor)
    @flavor = flavor
  end

end


class PropReaderTest < Minitest::Test
  def setup
    @ivar = PropReader.new "spicy"
    assert_instance_of PropReader, @ivar
    refute_nil @ivar
  end

  def test_respond_to_prop_reader
    assert_respond_to @ivar, :flavor
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
