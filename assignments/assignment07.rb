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
      defined?(@observers)? @observers<<obj : @observers = [obj]
    end
    def delete_observer(obj)
      @observers.reject!{|i| i == obj}
    end
    def delete_observers
      @observers = nil
    end
    def changed(new_state=true)
      @changed = new_state
    end
    def changed?
      @changed == true
    end
    def notify_observers(*args)
      @observers.each { |observer| observer.update(*args.join(',')) }
      @changed = false
    end
  end
end


require 'minitest/autorun'

class TestObservable < MiniTest::Test
  class Observed
    include Assignment07::Observable
    def initialize(value)
      @myval = value
    end
    def increase
      @myval += 1
      notify_observers @myval
    end
  end
  
  class Observer
    attr :observerval
    def initialize(observed)
      observed.add_observer self
    end
    def update(value)
      @observerval = value
    end
  end
  
  def test_one
    observed = Observed.new(1)
    observer = Observer.new(observed)  
    assert observer
    assert observed
    observed.increase
    assert 2, observer.observerval 
    observed.increase
    assert 3, observer.observerval 
  end
  
end


