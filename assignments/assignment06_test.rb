require './assignment06'
require 'minitest/autorun'

include Assignment06

class TestAssignment06 < Minitest::Test
  def test_01
    pq = PriorityQueue.new
    assert pq.empty?      #=> true
  end
  def test_02
    pq = PriorityQueue.new
    pq.enqueue "first"
    refute pq.empty?      #=> false
  end
  def test_03
    pq = PriorityQueue.new
    pq.enqueue "first"
    pq.enqueue "top", :high
    pq.enqueue "last", :low
    pq.enqueue "second"
    pq.enqueue "another top", :high
    assert pq.length == 5
  end
  def test_04
    pq = PriorityQueue.new
    pq.enqueue "first"
    pq.enqueue "top", :high
    pq.enqueue "last", :low
    pq.enqueue "second"
    pq.enqueue "another top", :high
    assert pq.dequeue == "top"
    assert pq.dequeue == "another top"
    assert pq.dequeue == "first"
    assert pq.dequeue == "second"
    assert pq.dequeue == "last"  
  end
end # class TestAssignment06

