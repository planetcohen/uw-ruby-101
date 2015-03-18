 require 'minitest/autorun'
  
  class PriorityQueue

    class SubQueue
      attr :rank, :items
      def initialize(rank)
         @rank = rank
         @items = []
      end
      def enqueue(item)
        @items<<item
      end
      def dequeue
        @items.shift
      end
      def empty?
        @items.empty?
      end
      def peek
        @items[0]
      end
      def length
        @items.length
      end
    end #SubQueue
    
    def initialize
      @high_sq = SubQueue.new(:high)
      @medium_sq = SubQueue.new(:medium)
      @low_sq = SubQueue.new(:low)
      @sq_names = {high: @high_sq, medium: @medium_sq, low: @low_sq} 
    end
    def enqueue(item, priority=:medium)
      subqueue = @sq_names.select {|i| i == priority}.values[0]
      subqueue.enqueue(item)
    end
    def dequeue
      if  @high_sq.length > 0
        @high_sq.dequeue
      elsif  @medium_sq.length > 0
        @medium_sq.dequeue
      else 
        @low_sq.dequeue
      end
    end
    def empty?
      ary = @high_sq.items + @medium_sq.items + @low_sq.items
      ary.empty?
    end
    def peek
      if  @high_sq.length > 0
        @high_sq.peek
      elsif  @medium_sq.length > 0
        @medium_sq.peek
      else 
        @low_sq.peek
      end
    end
    def length
      ary = @high_sq.items + @medium_sq.items + @low_sq.items
      ary.length
    end
  end #PriorityQueue

  
  class TestPriorityQueue < MiniTest::Test
    def test_one
      pq = PriorityQueue.new
      assert pq.empty?
      pq.enqueue "first"
      refute pq.empty?
      
      pq.enqueue "top", :high
      pq.enqueue "last", :low
      pq.enqueue "second"
      pq.enqueue "another top", :high
      assert_equal 5, pq.length   
      
      assert_equal "top", pq.dequeue
      assert_equal "another top", pq.dequeue
      assert_equal "first", pq.dequeue
      assert_equal "second", pq.dequeue
      assert_equal "last", pq.dequeue
    end
  end #class
