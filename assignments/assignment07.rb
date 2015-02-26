# ========================================================================================
# Assignment 7
# ========================================================================================

# ========================================================================================
#  Problem 1 - Observable

# implement Observable
# validate using MiniTest unit tests
require 'observer'

module Assignment07
  
  def initialize
    @observers = []
    @state = false
  end

  def add_observer(obj)
    # your implementation here
    @observers << obj
  end

  def delete_observer(obj)
    # your implementation here
    @observers.delete(obj)
  end

  def delete_observers
    # your implementation here
    @observers.clear
  end

  def count_observers
    # your implementation here
    @observers.count
  end


  def changed(new_state=true)
    # your implementation here
    @state = true
  end

  def changed?
    # your implementation here
    @state
  end

  def notify_observers(*args)
    # your implementation here
    if @state then
      @observers.each{|o| o.send :update, *args}
      @state = false
    end
  end
  
end

require 'minitest/autorun'

class Observee
  include Assignment07
end


class Observer   
  def initialize
    @value = 1
  end

  def update(value)
    @value = value
  end

  def value 
    @value
  end

end


class TestMyClass < Minitest::Test
 
  def test_observable

    to = Observee.new
    ob1 = Observer.new
    ob2 = Observer.new

    to.add_observer(ob1)
    to.add_observer(ob2)
    assert_equal 2, to.count_observers
    assert_equal 1, ob1.value
    assert_equal 1, ob2.value

    assert_equal false, to.changed?
    to.changed
    assert_equal true, to.changed?

    to.notify_observers 3
    assert_equal false, to.changed?

    assert_equal 3, ob1.value
    assert_equal 3, ob2.value
    
    to.delete_observer ob1
    assert_equal 1, to.count_observers

    to.add_observer(ob1)
    to.delete_observers
    assert_equal 0, to.count_observers

  end

end






