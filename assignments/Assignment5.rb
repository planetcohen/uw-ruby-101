require 'minitest/autorun'

class Class
  def prop_reader(prop_name)
    define_method(prop_name) do
      instance_variable_get("@#{prop_name}")
    end
  end
end

class PropReader
  prop_reader(:flavor)

  def initialize(flavor)
    @flavor = flavor
  end
end

class PropReaderTest < Minitest::Test
  def setup
    @prop_reader = PropReader.new("spicy")
  end

  def test_hacker
    assert @prop_reader.respond_to? :flavor
    refute @prop_reader.respond_to? :"flavor="
  end
end

obj = PropReader.new("spicy")
puts obj.respond_to? :flavor #=> true
puts obj.respond_to? :"flavor=" #=> false 
puts obj.flavor #=> spicy
