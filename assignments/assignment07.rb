# ========================================================================================
# Assignment 7
# ========================================================================================

# ========================================================================================
#  Problem 1 - Observable

# implement Observable
# validate using MiniTest unit tests

module Assignment07
  module Observable
    
    attr_accessor :state
    
    def add_observer(observer)
      @observers ||= []
      @observers << observer unless @observers.include? observer
    end

    def delete_observer(observer)
      @observers.delete(observer) unless @observers == nil
    end

    def delete_observers
      @observers.clear unless @obervers == nil
    end

    def count_observers
      @observers.count
    end

    def changed(new_state=true)
      @state = new_state
    end

    def changed?
      @state unless @state == nil
    end
    
    def notify_observers(*args)
      if @state == true
        @observers.each do |observer|
          observer.update(*args)
        end
        @state = false
      end
    end

  end
end