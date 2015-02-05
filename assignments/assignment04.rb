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
  if n < 0 
    puts "n cannot be negative."
  elsif n == 0 || n == 1
    return 1
  else
    return fib(n-1) + fib(n-2)
  end 
  # your implementation here
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
  attr_accessor :nodes, :head, :tail
  class Node
    attr_accessor :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end
  end

  def initialize
    @nodes = nil
  end

  def enqueue(item)
    n = Node.new item, @nodes
    if self.length == 0         #mark the very first item in the queue, so it can be dequeued
      @head = n
    end
    @nodes = n
  end

  def dequeue
    node = @nodes
    result = ""

    if node.link == nil       #if only one item in queue when dequeue is called, removing it causes @nodes to equal nil
      @nodes = nil
    end

    while node
      if node.link == @head     #dequeue head, and set head to new last element
        node.link = nil
        result = @head.item
        @head = node
      else
        result = node.item
      end
      node = node.link
    end
    result
  end

  def empty?
    @nodes.nil?
  end

  def peek
    @nodes.nil? ? nil : @nodes.item
  end

  def length
    count = 0
    node = @nodes
    while node
      count += 1
      node = node.link
    end
    count
  end

  def to_s
    puts "nodes = #{@nodes}, head = #{@head}, tail = #{@tail}"
  end

end


# ========================================================================================
#  Problem 3 - LinkedList

# implement a LinkedList class that does not use Array.

# expected behavior:
ll = LinkedList.new
ll.empty?            #=> true

ll << "first"
ll.empty?            #=> false
ll.length            #=> 1
ll.first             #=> "first"
ll.last              #=> "first"

ll << "second"
ll.length            #=> 2
ll.first             #=> "first"
ll.last              #=> "second"

ll << "third"        #=> 3
ll.each {|x| puts x} #=> prints out "first", "second", "third"

ll.delete "second"   #=> "second"
ll.length            #=> 2
ll.each {|x| puts x} #=> prints out "first", "third"

class LinkedList
  attr_accessor :nodes, :head
  class Node
    attr_accessor :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end
  end

  def initialize
    @nodes = nil
  end

  def empty?
    @nodes.nil?
  end

  def length
    count = 0
    node = @nodes
    while node
      count += 1
      node = node.link
    end
    count
  end

  def << (item)
    n = Node.new item, @nodes
    if self.length == 0         #mark the very first item in the queue, so it can be dequeued
      @head = n
    end
    @nodes = n
  end

  def first
    @nodes.nil? ? nil : @head.item
  end

  def last
    @nodes.nil? ? nil : @nodes.item
  end

  def delete (item_to_delete)
    node = @nodes
    while node
      if node.link.item == item_to_delete
        #puts "node = #{node}, item_to_delete = #{item_to_delete}"
        next_node = node.link
        node.link = next_node.link
      end
      node = node.link
    end
    item_to_delete
  end

  def to_s
    puts "Linked List = #{@nodes}, head = #{@head}, tail = #{@tail}"
  end

  def each(&block)
    for node in @nodes
      yield(node)
    end
  end
end
