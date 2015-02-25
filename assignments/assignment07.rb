# ========================================================================================
# Assignment 7
# ========================================================================================

# ========================================================================================
#  Problem 1 - Observable

# implement Observable
# validate using MiniTest unit tests

module Assignment07

  module Observable

    def add_observer(obj)
      @observers ||= []
      @observers << obj
    end

    def delete_observer(obj)
      if defined?(@observers)
        @observers.delete(obj)
      end
    end

    def delete_observers
      if defined?(@observers)
        @observers.clear
      end
    end

    def changed(new_state=true)
      @observable_state = new_state
    end

    def changed?
      if defined?(@observable_state) && @observable_state
        true
      else
        false
      end
    end

    def notify_observers(*args)
      if defined?(@observable_state) && @observable_state
        if defined?(@observers)
          @observers.each do |obj|
            obj.send("update", *args)
          end
        end
        @observable_state = false
      end
    end

  end
end


# MiniTest unit tests:

require 'minitest/autorun'

class TestPropReader < Minitest::Test

  include Assignment07::Observable

  class Dummy
    def initialize(value)
      @object_value = value
    end
    def update(value)
      @object_value += value
    end
    def value
      @object_value
    end
  end

  def setup
    @object1 = Dummy.new(1)
    @object2 = Dummy.new(2)
    @object3 = Dummy.new(3)
  end

  def test_add_observer
    assert_instance_of Array, add_observer(@object1)
    assert_instance_of Array, add_observer(@object2)
    assert_instance_of Array, add_observer(@object3)
    assert_equal false, changed?
  end

  def test_notify_observers
    assert_instance_of Array, add_observer(@object1)
    assert_instance_of Array, add_observer(@object2)
    assert_instance_of Array, add_observer(@object3)
    assert_equal false, changed?
    changed
    assert_equal true, changed?
    notify_observers(2)
    assert_equal 3, @object1.value
    assert_equal 4, @object2.value
    assert_equal 5, @object3.value
  end

  def test_delete_observer
    assert_instance_of Array, add_observer(@object1)
    assert_instance_of Array, add_observer(@object2)
    assert_instance_of Array, add_observer(@object3)
    delete_observer(@object2)
    assert_equal false, changed?
    changed
    assert_equal true, changed?
    notify_observers(2)
    assert_equal 3, @object1.value
    assert_equal 2, @object2.value
    assert_equal 5, @object3.value
    delete_observers
    changed
    assert_equal true, changed?
    notify_observers(2)
    assert_equal 3, @object1.value
    assert_equal 2, @object2.value
    assert_equal 5, @object3.value
  end

end


