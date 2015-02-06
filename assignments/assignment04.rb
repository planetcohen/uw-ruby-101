# ========================================================================================
# Assignment 4
# ========================================================================================

# ========================================================================================
#  Problem 1 - Fibonacci

def fib(n)
  if (0..1).include? n
  (fib(n-1) + fib(n-2)) 
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
    attr: :item, :link
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
      end
      node.link = Node.new item, nil
    else
      @nodes = Node.new item, nil
    end
  end

  def dequeue
    node = @nodes
    if @nodes = node.nil?
      node.link
    else
      node.item
    end
  end

  def empty?
    @nodes.nil?
  end

  def peek
    if @nodes.nil?
      nil
    else
      @nodes.item
    end
  end

  def length
    node = @nodes
    count = 0
    while node
      node = node.link
      count += 1
      end
      count
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

  def <<(item)
    if @node.nil?
      @head = Node.new item, nil
    else
      @head
    end
  end

  def first
    if @nodes.nil?
      @head.item
    end
  end

  def last
    if @nodes.nil?
      @nodes.item
    end
  end

  def each(&block)
    for node in @nodes
      yield(node)
    end
  end
end
