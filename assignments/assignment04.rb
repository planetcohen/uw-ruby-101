# ========================================================================================
# Assignment 4
# ========================================================================================

# ========================================================================================
#  Problem 1 - Fibonacci

# 1, 1, 2, 3, 5, 8, 13, 21, ...

# F[0] -> 1
# F[1] -> 1
# F[n] -> F[n-2] + F[n-1]

def fib(n)
  (n == 0 or n == 1) ? 1 : fib(n-2) + fib(n-1)
end
# expected behavior:
fib(0)     #=> 1
fib(1)     #=> 1
fib(5)     #=> 8
fib(4)     #=> 5
fib(12)    #=> 233


# ========================================================================================
#  Problem 2 - Queue

# implement a Queue class that does not use Array.

# expected behavior:
q = Queue.new
q.empty?            #=> true
q.enqueue "first"
q.empty?            #=> false
q.enqueue "second"
q.dequeue           #=> "first"
q.dequeue           #=> "second"
q.dequeue           #=> nil

class Queue
  attr_accessor :head, :tail

  class Node
    attr_accessor :item, :prev, :nxt
    def initialize(item,prev,nxt)
      @item = item
      @prev = prev
      @nxt = nxt
    end
  end

  def initialize
    @tail = nil
    @head = nil
  end
  
  def enqueue(item)
    if @tail == nil
      @tail = @head = Node.new item, @tail, nil
    else
      @tail = Node.new item, @tail, nil
      @tail.prev.nxt = @tail
    end
  end
  
  def dequeue
    node = @head
    if node == nil
      node
    elsif
      node.nxt == nil
      @tail = nil
      @head = nil
      node.item
    else
      node.nxt.prev = nil
      @head = node.nxt
      node.item
    end
  end
  
  def empty?
    @tail.nil?
  end

  def peek
    @tail.nil? ? nil : @head.item
  end
  
  def length
    count = 0
    node = @tail
    while node
      count += 1
      node = node.prev
    end
    count
  end
end


# ========================================================================================
#  Problem 3 - LinkedList

class LinkedList
  attr_accessor :head, :tail, :pointer

  class Node
    attr_accessor :item, :prev, :nxt
    def initialize(item,prev,nxt)
      @item = item
      @prev = prev
      @nxt = nxt
    end
  end

  def initialize
    @tail = nil
    @head = nil
    @pointer = nil
  end

  def empty?
    @tail.nil?
  end

  def length
    count = 0
    node = @tail
    while node
      count += 1
      node = node.prev
    end
    count
  end

  def <<(item)
    if @tail == nil
      @tail = @head = @pointer = Node.new item, @tail, nil
    else
      @tail = Node.new item, @tail, nil
      @tail.prev.nxt = @tail
    end
  end

  def delete(item)
    @pointer = @tail
    #case of no nodes
    if @pointer == nil
      puts "List is empty"
      return
    else
      until (@pointer.item <=> item) == 0
        if @pointer.prev == nil
          puts "No such item"
          return
        else
          @pointer = @pointer.prev
        end
      end
    end

    # case of only one node
    if @pointer.prev == nil and pointer.nxt == nil
      @head = @tail = nil
    # case of item is at head node
    elsif @pointer == @head
      @pointer.nxt.prev = nil
      @head = @pointer.nxt
    # case of item is at tail node
    elsif @pointer == @tail
      @pointer.prev.nxt = nil
      @tail = @pointer.prev
    else
      @pointer.prev.nxt = @pointer.nxt
      @pointer.nxt.prev = @pointer.prev
    end
  end

  def first
    @tail.nil? ? nil : @head.item
  end
  
  def last
    @tail.nil? ? nil : @tail.item
  end
  
  def each(&block)
    @pointer = @head
    while @pointer != nil
      block.call(@pointer.item)
      @pointer = @pointer.nxt
    end
  end
end
