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
  return  n  if ( 0..1 ).include? n
  ( fib( n - 1 ) + fib( n - 2 ) )
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
    node = @nodes
    if node
      while node.link
      node = node.link
    @nodes = Node.new item, @nodes
  end
  
  def dequeue
    @items.shift
  end
  
  def empty?
    @nodes.empty?
  end
  
  def peek
    @nodes
  end
  
  def length
    @items.length
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
  def initialize
    # your implementation here
  end
  def empty?
    # your implementation here
  end
  def length
    # your implementation here
  end
  def <<(item)
    # your implementation here
  end
  def first
    # your implementation here
  end
  def last
    # your implementation here
  end
  def each(&block)
    # your implementation here
  end
end
