# ========================================================================================
# Assignment 4
# ========================================================================================

require 'minitest/autorun'


module Assignment04

  # ========================================================================================
  #  Problem 1 - Fibonacci

  # 1, 1, 2, 3, 5, 8, 13, 21, ...

  # F[0] -> 1
  # F[1] -> 1
  # F[n] -> F[n-2] + F[n-1]

  def self.fib(n)
    n < 2 ? 1 : fib(n-2)+fib(n-1)
  end



  # ========================================================================================
  #  Problem 2 - Queue

  # implement a Queue class that does not use Array.
  class Queue

    class Node
      attr_accessor :item, :link
      def initialize(item, link)
        @item = item
        @link = link
      end
      def to_s
        "[item => #{item}, link => #{link}]"
      end
    end

    def initialize
      @nodes = nil
    end

    def enqueue(item)
      new_node = Node.new item, nil

      if empty?
        @nodes = new_node
      else
        node = @nodes
        while node.link
          node = node.link
        end
        node.link = new_node
      end
      self
    end

    def dequeue
      node = @nodes
      @nodes = node.nil? ? nil : node.link
      node.nil? ? nil : node.item
    end

    def empty?
      @nodes.nil?
    end

    def peek
      @nodes.nil? ? nil : @nodes.item
    end

    def length
      return 0  if empty?

      node = @nodes
      count = 1
      while node.link
        count += 1
        node = node.link
      end
      count
    end
  end


  # ========================================================================================
  #  Problem 3 - LinkedList

  # implement a LinkedList class that does not use Array.
  class LinkedList

    class Node
      attr_accessor :item, :link
      def initialize(item, link)
        @item = item
        @link = link
      end
      def to_s
        "[item => #{item}, link => #{link}]"
      end
    end

    def initialize
      @nodes = nil
    end

    def empty?
      @nodes.nil?
    end

    def length
      return 0  if empty?

      node = @nodes
      count = 1
      while node.link
        count += 1
        node = node.link
      end
      count
    end

    def <<(item)
      new_node = Node.new item, nil

      if empty?
        @nodes = new_node
      else
        node = @nodes
        while node.link
          node = node.link
        end
        node.link = new_node
      end
      self
    end

    def first
      empty? ? nil : @nodes.item
    end

    def last
      return nil  if empty?

      node = @nodes
      while node.link
        node = node.link
      end

      node.item
    end

    def delete(item)
      return nil  if empty?

      node = @nodes
      if item == node.item
        @nodes = node.link
        return node.item
      end

      while node.link
        if item == node.link.item
          node.link = node.link.link
          return item
        end
        node = node.link
      end

      nil
    end

    def each(&block)
      return  if empty?

      node = @nodes
      while node != nil
        yield node.item
        node = node.link
      end
    end
  end

end


# ========================================================================================
require 'minitest/autorun'

class TestAssignment04 < Minitest::Test

  def test_fib
    assert_equal 1,   Assignment04.fib(0)     #=> 1
    assert_equal 1,   Assignment04.fib(1)     #=> 1
    assert_equal 8,   Assignment04.fib(5)     #=> 8
    assert_equal 5,   Assignment04.fib(4)     #=> 5
    assert_equal 233, Assignment04.fib(12)    #=> 233
  end

  def test_queue
    q = Assignment04::Queue.new
    refute_nil q
    assert_empty q            #=> true
    assert_equal 0, q.length

    assert_equal q, q.enqueue("first")
    refute_empty q            #=> true
    assert_equal 1, q.length
    assert_equal "first", q.peek

    assert_equal q, q.enqueue("second")
    refute_empty q            #=> true
    assert_equal 2, q.length
    assert_equal "first", q.peek

    assert_equal q, q.enqueue("third")
    refute_empty q            #=> true
    assert_equal 3, q.length
    assert_equal "first", q.peek

    assert_equal "first", q.dequeue           #=> "first"
    refute_empty q            #=> true
    assert_equal 2, q.length
    assert_equal "second", q.peek

    assert_equal "second", q.dequeue           #=> "second"
    refute_empty q            #=> true
    assert_equal 1, q.length
    assert_equal "third", q.peek

    assert_equal "third", q.dequeue           #=> "second"
    assert_empty q            #=> true
    assert_equal 0, q.length

    assert_nil q.dequeue           #=> nil
  end
  
  def test_linked_list
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal ll, ll << "third"
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    items = []
    ll.each {|item| items << item}
    assert_equal ["first", "second", "third"], items

    assert_equal "second", ll.delete("second")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    items = []
    ll.each {|item| items << item}
    assert_equal ["first", "third"], items
  end

  def test_linked_list_delete_only
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal "first", ll.delete("first")
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last
  end

  def test_linked_list_delete_first_of_two
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal "first", ll.delete("first")
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "second", ll.first
    assert_equal "second", ll.last
  end

  def test_linked_list_delete_last_of_two
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal "second", ll.delete("second")
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last
  end

  def test_linked_list_delete_first_of_three
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal ll, ll << "third"
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_equal "first", ll.delete("first")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "second", ll.first
    assert_equal "third", ll.last
  end

  def test_linked_list_delete_middle_of_three
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal ll, ll << "third"
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_equal "second", ll.delete("second")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last
  end

  def test_linked_list_delete_last_of_three
    ll  = Assignment04::LinkedList.new
    refute_nil ll
    assert_empty ll
    assert_equal 0, ll.length
    assert_nil ll.first
    assert_nil ll.last

    assert_equal ll, ll << "first"
    refute_empty ll
    assert_equal 1, ll.length
    assert_equal "first", ll.first
    assert_equal "first", ll.last

    assert_equal ll, ll << "second"
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last

    assert_equal ll, ll << "third"
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_nil ll.delete("other")
    refute_empty ll
    assert_equal 3, ll.length
    assert_equal "first", ll.first
    assert_equal "third", ll.last

    assert_equal "third", ll.delete("third")
    refute_empty ll
    assert_equal 2, ll.length
    assert_equal "first", ll.first
    assert_equal "second", ll.last
  end

end
