# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests

# expected results:

class Class
	def prop_reader(prop)
		define_method prop do
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

require 'minitest/autorun'

class TestAssignment5 < Minitest::Unit::TestCase
	def setup
		obj = PropReader.new "spicy"
	end

	def test_propreader_1
		assert PropReader.respond_to? :flavor
	end

	def test_propreader_2
		refute PropReader.respond_to? :"flavor="
	end

	def test_propreader_3
		asser_equal obj, "spicy"
	end
end

obj = PropReader.new "spicy"
obj.respond_to? :flavor     #=> true
obj.respond_to? :"flavor="  #=> false
obj.flavor                  #=> "spicy"
