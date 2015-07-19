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
      # your implementation here
      @observers = []
      @observers << obj unless @observers.include?(obj)
    end
    def delete_observer(obj)
      # your implementation here
      @observer.delete(obj)
    end
    def delete_observers
      # your implementation here
      @observer = []
    end
    def changed(new_state=true)
      # your implementation here
      @changed = new_state
    end
    def changed?
      # your implementation here
      @changed == true
    end
    def notify_observers(*args)
      # your implementation here
      @observers.each {|obs| obs.update *args}
      @changed = false
    end
  end
end

require 'minitest/autorun'

class ObservableTest < Minitest::Test
  class Observable
    include Assignment07::Observable
  end
    
  def setup
    @observerable1 = Observable.new
    @observerable2 = Observable.new
  end
  
  def test_add_observerable
    @observable1.add_observer(self)
    @observable2.add_observer(self)
    assert_equal true, @observable.changed?
  end
  
  def test_delete_observerable
    @observable1.add_observer(self)
    @observable2.add_observer(self)
    
    @observer.delete_observers
    
    assert_equal(0, @observable1.sum)
    assert_equal(0, @observable2.sum)
  end
end
    


