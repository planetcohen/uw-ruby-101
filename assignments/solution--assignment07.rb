# # ========================================================================================
# # Assignment 7
# # ========================================================================================

# # ========================================================================================
# #  Problem 1 - Observable

# # implement Observable
# # validate using MiniTest unit tests

module Assignment07
  module Observable
    def add_observer(obj)
      if defined?(@observers) then @observers<<obj else @observers = [obj] end
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
      @observers.each { |observer| observer.update(*args) }
      @changed = false
    end
  end
end


# ########################
require 'observer'
class Car
  include Observable
  attr_accessor :mileage, :service

  def initialize(mileage= 0, service= 3000)
    @mileage, @service = mileage, service
    add_observer(Notifier.new)
  end
  
  def log(miles)
    @mileage += miles
    changed
    notify_observers(self, miles)
  end
end

class Notifier
  def update(car, miles)
    car.mileage
  end
end


car = Car.new(100)
car.log(200)



