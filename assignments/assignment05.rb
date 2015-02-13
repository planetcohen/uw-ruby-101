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

class PropReader
  prop_reader :flavor
  def initialize(flavor)
    @flavor = flavor
  end
end 

require 'minitest/autorun'

class TestAssignment05 < MiniTest::Test

	def test_propreader
		obj = PropReader.new "spicy"
		a = obj.respond_to? :flavor
		assert_equal true, a
		b = obj.respond_to? :"flavor="
		assert_equal false, b
		assert_equal "spicy", obj.flavor
	end

end

