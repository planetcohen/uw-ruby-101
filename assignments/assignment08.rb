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
      if defined? @observers
        @observers << obj
      else
        @observers = [obj]
      end
    end
    def delete_observer(obj)
      if defined? @observers
        @observers.delete obj
      end
    end
    def delete_observers
      if defined? @observers
        @observers = []
      end
    end
    def changed(new_state=true)
      @state = new_state
    end
    def changed?
      if @state.nil?
        @state = false
      else
      @state
    end

    # if changed state is true, invoke the update method in each associated observer. then changed state becomes false.
    def notify_observers(*args)   #splat operator - multipel comma-separated params at end
      if @state == true
        @observers.each do |observer| 
          observer.send ("update", args)
        end
      end
        @state = false
      end
    end
  end
end


require 'minitest/autorun'

class TestObservable < MiniTest::Test
  
  class Thermometer
    include Assignment07::Observable
    def initialize(temp)
      @temp = temp
    end

    def up
      @temp += 1
      notify_observers @temp
    end

    def down
      @temp -= 1
      notify_observers @temp
    end
  end

  class ThermometerControl
    def initialize(thermometer)
      @thermometer = thermometer
    end

    def click_up
      @thermometer.up
    end

    def click_down
      @thermometer.docn
    end
  end

  class ThermometerDisplay
    def initialize(thermometer)
      thermometer.add_observer self
    end

    def render(temp)
      puts temp
    end

    def update(temp)
      render temp
    end
  end

  def test_observable
    t = Thermometer.new 68
    tc = ThermometerControl.new t
    td = ThermometerDisplay.new t
    tc.click_up
    assert_equal 69, td.render
    tc.click_down
    assert_equal 68, td.render
    t2 = Thermometer.new 5
    tc2 = ThermometerControl.new t2
    td2 = ThermometerDisplay.new t2
    tc2.click_up
    assert_equal 6, td2.render
    tc2.clicp_down
    assert_equal 5, td2.render
  end
  
end
