# ========================================================================================
# Assignment 7
# ========================================================================================

require 'minitest/autorun'

# ========================================================================================
#  Problem 1 - Observable

# implement Observable
# validate using MiniTest unit tests

module Assignment07
  module Observable
    def add_observer(obj)
      @observers ||= []
      @observers << obj if not @observers.find_index obj
    end
    def delete_observer(obj)
      @observers ||= []
      @observers.delete obj
    end
    def delete_observers
      @observers = []
    end
    def changed(new_state=true)
      @changed = new_state
    end
    def changed?
      @changed ||= false
      @changed
    end
    def notify_observers(*args)
      return if not changed?

      @observers ||= []
      @observers.each { |observer| observer.update *args}
      changed false
    end
  end

  class ObservableTest < Minitest::Test
    class Observable
      include Assignment07::Observable
    end

    class Observer
      attr_reader :sum

      def initialize
        @sum = 0
      end

      def update(*args)
        @sum += args.reduce(:+)
      end
    end

    def setup
      @observable = Observable.new
      @observer = Observer.new
      @observer2 = Observer.new
    end

    def test_changed
      @observable.changed true
      assert(@observable.changed?)
    end

    def test_add_and_notify_observers
      @observable.add_observer @observer
      @observable.add_observer @observer2

      @observable.changed true
      @observable.notify_observers 1, 2, 3

      assert_equal(6, @observer.sum)
      assert_equal(6, @observer2.sum)
    end

    def test_add_same_observer_not_allowed
      @observable.add_observer @observer
      @observable.add_observer @observer

      @observable.changed true
      @observable.notify_observers 1, 2, 3

      assert_equal(6, @observer.sum)
    end

    def test_delete_and_notify_one_observer
      @observable.add_observer @observer
      @observable.add_observer @observer2

      @observable.delete_observer @observer

      @observable.changed true
      @observable.notify_observers 1, 2, 3

      assert_equal(0, @observer.sum)
      assert_equal(6, @observer2.sum)
    end

    def test_delete_all_observers
      @observable.add_observer @observer
      @observable.add_observer @observer2

      @observable.delete_observers

      @observable.changed true
      @observable.notify_observers 1, 2, 3

      assert_equal(0, @observer.sum)
      assert_equal(0, @observer2.sum)
    end

    def test_notify_observers_reset_changed
      @observable.add_observer @observer

      @observable.changed true
      @observable.notify_observers 1, 2, 3
      @observable.notify_observers 1, 2, 3

      assert_equal(6, @observer.sum)
    end
  end
end
