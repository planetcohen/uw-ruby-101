# ========================================================================================
# Assignment 7
# ========================================================================================

# ========================================================================================
#  Problem 1 - Observable

# implement Observable
# validate using MiniTest unit tests

module Assignment07
  module Observable
    def initiate_observable
      @observers = []
      @change = false
    end
    def add_observer(obj)
      @observers << obj
    end
    def delete_observer(obj)
      @observers.delete obj
    end
    def delete_observers
      @observers = []
    end
    def changed(new_state=true)
      @change = true
    end
    def changed?
      @change == true
    end
    def notify_observers(*args)
      if @change
        @observers.each { |o| o.update(*args) }
        @change = false
      end
    end
  end

  class Thermometer
    include Observable
    def initialize(temp)
      @temp = temp
      initiate_observable
    end
    def up
      @temp += 1
      changed(new_state=true)
      notify_observers @temp
    end
    def down
      @temp -= 1
      changed(new_state=true)
      notify_observers @temp
    end
  end


  class Thermometer_Control
    def initialize(thermometer)
      @thermometer = thermometer
    end
    def click_up
      @thermometer.up
    end
    def click_down
      @thermometer.down
    end
  end

  class Thermometer_Display
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

  class Mercury_Display
    def initialize(thermometer)
      thermometer.add_observer self
    end
    def render(temp)
      if temp < 0
        l = 0
      elsif temp > 100
        l = 10
      else
        l = (temp.to_f/10).round
      end
      mercury = Array.new(l.round,"X")
      space = Array.new(10-l.round, " ")
      reading = "Temp = 0degC[#{mercury.join}#{space.join}]100degC"
      puts reading
      reading
    end
    def update(temp)
      render temp
    end
  end


  require 'minitest/autorun'

  class TestThermometer < Minitest::Test
    def setup
      @t1 = Thermometer.new 25
      @tc = Thermometer_Control.new @t1
      @td = Thermometer_Display.new @t1
      @md = Mercury_Display.new @t1
    end

    def test_render_output
      # @tc.click_up
      assert_output (/26/) { @tc.click_up}
      assert_output (/[XXX       ]/) { @tc.click_up}
      assert_output (/26/) { @tc.click_down}
      assert_output (/[XX        ]/) { 2.times {@tc.click_down}}  #24

      assert_output (/124/) { 100.times {@tc.click_up}}
      assert_output (/[XXXXXXXXXX]/) { 1.times {@tc.click_down}} #123

      assert_output (/-1/) { 124.times {@tc.click_down}}
      assert_output (/[          ]/) { 1.times {@tc.click_down}} #-125
    end
  end

end
