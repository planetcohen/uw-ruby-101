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
      @observers.delete obj
    end
    def delete_observers
      @observers.clear
    end
    def count_observers
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
    notify_observers @temp
  end
  
  def down
    @my_value += 1
    changed
    notify_observers @temp
  end
  
end  # class ObserveMe

class Observer
  def initialize(target)
    target.add_observer self
  end
  
  def update(some_value)
    puts some_value
  end
end  # class observer

class TestAssignment07 < Minitest::Test

#  def test_queue
#    q = Assignment04::Queue.new
#    refute_nil q
#    assert_empty q            #=> true
#    assert_equal 0, q.length
#
#    assert_equal q, q.enqueue("first")
#    refute_empty q            #=> true
#    assert_equal "first", q.peek

#    assert_nil q.dequeue           #=> nil
#  end

  def test_notify_changed
    # create observable thing
    om = ObserveMe.new 68
    # add observer to thing
    obr = Observer.new om
    # change thing's state
    # notify_observers
    # verify observer was notified
    assert_equal 69, om.up
    # notify_observers
    # verify observer was not notified
    assert_nil om.notify_observers
    # change thing's state
    om.up
    # delete observer
    om.delete_observer(obr)
    # notify_observers
    # verify observer was not notified
    assert_nil om.notify_observers
  end

  def test_changed_query
    # create observable thing
    # verify changed? returns false
    # add observer to thing
    # verify changed? returns false
    # .changed()
    # verify changed? returns true
    # .changed(false)
    # verify changed? returns false
    # .changed(true)
    # verify changed? returns true
    # notify_observers
    # verify changed? returns false
    # .changed(false)
    # verify changed? returns false
  end

  def test_changed_bad
    # create observable thing
    # .changed(foo)
    # verify no assert :)
    # verify changed? returns false
    # .changed()
    # verify changed? returns true
    # .changed(foo)
    # verify no assert :)
    # verify changed? returns true
  end

  def test_delete_notify
    # create observable thing
    # add 3 observers to thing
    # change thing's state
    # notify_observers
    # verify observers were notified
    # delete 2nd observer
    # change thing's state
    # verify deleted observer is not notified
    # verify remaining 2 observers are notified
  end

  def test_count_observers
    # create observable thing
    # count_observers - verify count = 0
    # add 3 observers to thing
    # count_observers - verify count = 3
    # delete 2nd observer
    # count_observers - verify count = 2
    # delete_observers
    # count_observers - verify count = 0
  end

  def test_delete
    # create observable thing
    # delete_observer
    # verify no assert :)
    # delete_observers
    # verify no assert :)
    # add 6 observers
    # count_observers - verify count = 6
    # delete_observer
    # delete_observer
    # delete_observer
    # count_observers - verify count = 3
    # delete_observers
    # count_observers - verify count = 0
  end

  # test_notify_observers

end # class TestAssignment07 < Minitest::Test