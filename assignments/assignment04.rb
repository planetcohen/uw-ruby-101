# Doug McGowan
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
  (n < 2) ? 1 :fib(n-1) + fib(n-2)
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
    @nodes = nil;
  end

  def enqueue(item)
    node = @nodes
    if node
      #find the last node
      while node.link
        node = node.link
      end
      #add new node
      node.link = Node.new item, nil
    else
      @nodes = Node.new item, nil
    end
    self
  end

  def dequeue
    node = @nodes
    if node.nil?
      @nodes = nil
      nil
    else
      @nodes = node.link
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
    i = 0
    while node
      node = node.link
      i += 1
    end
      i
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
    @start = nil
    @finish = @start
  end

  def empty?
    @start.nil?
  end

  def length
    count = 0
    node = @start
    while node
    count += 1
      node = node.link
    end
    count
  end

  def <<(item)
    #Check if first item added
    if @start.nil?
      @start = Node.new item, nil
      @finish = @start
    #Otherwise Add to End
    else
      node_finish = @finish
      node_finish.link = Node.new item, nil
      @finish = node_finish.link
    end
      self
  end

  def first
    @start.item
  end

  def last
    @finish.item
  end

  def delete(item)
    previous_node = nil
    node = @start

    if @start.item == item
      @start = @start.link
    else
      while node and node.item != item
        previous_node = node
        node = node.link
      end
      #if the last item found
      if node and @finish.item ==item
        @finish = previous_node
        @finish.link = nil
      #if in middle of the pack
      elsif node
        previous_node.link = node.link
      #when value not found
      else
        nil
      end
    end
  end

  def each(&block)
  node = @start
    while node do
        block.call node.item
        node = node.link
    end
  end

end
