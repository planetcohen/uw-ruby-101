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
  def fib_helper(n, acc1, acc2)
    return acc1 if n == 0

    fib_helper(n - 1, acc2, acc1 + acc2)
  end

  fib_helper(n, 1, 1)
end

# expected behavior:
fib(0)     #=> 1
fib(1)     #=> 1
fib(5)     #=> 8
fib(4)     #=> 5
fib(12)    #=> 233


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
    @head = @tail = nil
    @count = 0
  end

  def empty?
    @count == 0
  end

  def length
    @count
  end

  def <<(item)
    node = Node.new(item, nil)
    if @head.nil?
      @head = @tail = node
    else
      @tail.link = node
      @tail = node
    end
    @count += 1
    self
  end

  def first
    @head.nil? ? nil : @head.item
  end

  def last
    @tail.nil? ? nil : @tail.item
  end

  def each(&block)
    node = @head
    while not node.nil?
      block.call node.item
      node = node.link
    end
  end

  # removes the first node matching item from the linked list
  def delete(item)
    node = @head
    node_prev = nil
    while not node.nil?
      if node.item == item
        if node_prev.nil?
          @head = node.link
          @tail = nil if @head.nil?
        else
          node_prev.link = node.link
        end
        node.link = nil
        @count -= 1
        return node.item
      end
      node_prev = node
      node = node.link
    end
    nil
  end
end

# expected behavior:
# ll = LinkedList.new
# ll.empty?            #=> true
#
# ll << "first"
# ll.empty?            #=> false
# ll.length            #=> 1
# ll.first             #=> "first"
# ll.last              #=> "first"
#
# ll << "second"
# ll.length            #=> 2
# ll.first             #=> "first"
# ll.last              #=> "second"
#
# ll << "third"        #=> 3
# ll.each {|x| puts x} #=> prints out "first", "second", "third"
#
# ll.delete "second"   #=> "second"
# ll.length            #=> 2
# ll.each {|x| puts x} #=> prints out "first", "third"


# ========================================================================================
#  Problem 2 - Queue

# implement a Queue class that does not use Array.

class Queue
  def initialize
    @list = LinkedList.new
  end

  def enqueue(item)
    @list << item
    self
  end

  def dequeue
    return nil if empty?
    @list.delete(@list.first)
  end

  def empty?
    @list.empty?
  end

  def peek
    return nil if empty?
    @list.first.item
  end

  def length
    @list.length
  end
end

# expected behavior:
# q = Queue.new
# q.empty?            #=> true
# q.enqueue "first"
# q.empty?            #=> false
# q.enqueue "second"
# q.dequeue           #=> "first"
# q.dequeue           #=> "second"
# q.dequeue           #=> nil
