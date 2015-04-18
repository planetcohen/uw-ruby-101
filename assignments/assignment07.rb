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
      if @observers.nil?
        @observers = []
      end
      @observers << obj
    end
    def delete_observer(obj)
      if @observers.nil?
        @observers = []
      end
      @observers.delete obj
    end
    def delete_observers
      if @observers.nil?
        @observers = []
      end
      @observers.clear
    end
    def count_observers
      if @observers.nil?
        @observers = []
      end
      @observers.count
    end
    def changed(new_state=true)
      @changed = new_state
    end
    def changed?
      if @changed.nil?
        @changed = false
      end
      @changed
    end
    def notify_observers(*args)
      if changed?
        @observers.each {|observer| observer.update(*args)}
        @changed = false
      end
    end
  end
end

require 'minitest/autorun'

class ObserveMe
  include Assignment07::Observable
  def initialize(some_int)
    @my_value = some_int
  end
  def up
    @my_value += 1
    changed
    notify_observers @my_value
  end
  
end  # class ObserveMe

class Observer
  attr_reader :value
  def initialize(target)
    target.add_observer self
    @value = nil
  end
  def update(some_value)
    @value = some_value
  end
end  # class observer

class TestAssignment07 < Minitest::Test
  # refactor into separate tests
  def test_observer
    om = ObserveMe.new 68
    assert_equal 0, om.count_observers
    obr1 = Observer.new om
    assert_equal 1, om.count_observers
    obr2 = Observer.new om
    assert_equal 2, om.count_observers
    
    refute om.changed?

    om.up
    refute om.changed?
    assert_equal 69, obr1.value
    assert_equal 69, obr2.value

    om.delete_observer(obr1)
    assert_equal 1, om.count_observers
    
    om.up
    assert_equal 69, obr1.value
    assert_equal 70, obr2.value
    
    om.add_observer(obr1)
    
    om.up
    assert_equal 71, obr1.value
    assert_equal 71, obr2.value
    
    om.notify_observers("foo")
    assert_equal 71, obr1.value
    
    obr3 = Observer.new om
    obr4 = Observer.new om
    obr5 = Observer.new om
    obr6 = Observer.new om
    assert_equal 6, om.count_observers
    om.delete_observers
    assert_equal 0, om.count_observers    
  end
end # class TestAssignment07 < Minitest::Test
