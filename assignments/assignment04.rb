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
  if (0..1).include? n
    1
  elsif n > 1
    fib(n-1) + fib(n-2)
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
    @nodes = Node.new(item, @nodes)
  end

  def dequeue
    node = @nodes
    while node
      if node.link.nil?
        @nodes = nil
        return node.item
      elsif node.link.link.nil?
        retval = node.link.item
        node.link = nil
        return retval
      end
      node = node.link
    end
  end

  def empty?
    @nodes.nil?
  end

  def peek
    node = @nodes
    while node
      if node.link.nil?
        return node.item
      end
      node = node.link
    end
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

end


# expected behavior:
q = Queue.new
q.empty?            #=> true
q.enqueue "first"
q.empty?            #=> false
q.enqueue "second"
q.dequeue           #=> "first"
q.dequeue           #=> "second"
q.dequeue           #=> nil


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
    if @nodes.nil?
      @nodes = Node.new(item, nil)
    else
      node = @nodes
      while node
        if node.link.nil?
          node.link = Node.new(item, nil)
          return length
        end
        node = node.link
      end
    end
  end

  def first
    @nodes.item
  end

  def last
    node = @nodes
    while node
      if node.link.nil?
        return node.item
      end
      node = node.link
    end
  end

  def each(&block)
    node = @nodes
    while node
      yield node.item
      node = node.link
    end
  end

  def delete(item)
    node = @nodes
    if node.item == item
      @nodes = node.link
    else
      while node
        if node.link.item == item
          node.link = node.link.link
          return item
        end
        node = node.link
      end
    end
  end

end


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

