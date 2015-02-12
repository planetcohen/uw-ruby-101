# ========================================================================================
# Assignment 5
# ========================================================================================

# ========================================================================================
#  Problem 1 -  implement prop_reader, write MiniTest unit tests
class Class
  +  def prop_reader(prop_name)
  +    define_method prop_name do
+      instance_variable_get "@#{prop_name}"
+    end
+  end
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


require 'minitest/autorun'

class TestPropReader < Minitest::Test
  def setup
+   @obj = PropReader.new "spicy"
+ end
+
+ def test_respond_to_flavor
+   assert @obj.respond_to? :flavor
+ end
+
+ def test_not_respond_to_flavor=
+   refute @obj.respond_to? :"flavor="
+ end
+
+ def test_flavor_equals
+   assert_equal @obj.flavor, "spicy"
+ end
+end
