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
      @observers << obj
    end
    def delete_observer(obj)
      # your implementation here
      @observers.delete obj
    end
    def delete_observers
      # your implementation here
      @observers.clear
    end
    def changed(new_state=true)
      # your implementation here
      @changed = new_state
    end
    def changed?
      # your implementation here
      @changed
    end
    def notify_observers(*args)
      # your implementation here
      if changed?
        @observers.each {|obs| obs.update(*args)}
        @changed = false
      end
    end
  end
end
