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
  # your implementation here
  if n==0 then
    1
  elsif n==1 then
    1
  else 
    fib(n-2) + fib(n-1)
  end
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
  def initialize
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
 # include Enumerable

  class Node
    attr :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end
    def item=(something)
      @item == something
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
  
  def <<(item)
    @nodes = Node.new item, @nodes
  end
  
  def first
    node = @nodes
    lastnode = @nodes
    while node
      lastnode = node
      node = node.link
    end
    lastnode.item
  end
  def last
    @nodes.item
  end
  
  def each(&block)
    node = @nodes
    while node
      yield node.item
      node = node.link
    end
  end
  
  def print_nodes
    node = @nodes
    while node
      puts node.item
      node = node.link
    end
    nil
  end
  
  def delete(myitem)
    newnodes = nil
    node = @nodes
    while node
      if node.item == myitem then
        node = node.link
      else
        newnodes = Node.new node.item, newnodes
        node = node.link
      end
    end
    @nodes = newnodes
    myitem
  end
end

ll = LinkedList.new
ll << "first"
ll << "second"
ll << "third"
ll << "fourth"
ll << "fifth"
ll.length
ll.delete "third"
ll.length

ll.each {|x| puts x }
