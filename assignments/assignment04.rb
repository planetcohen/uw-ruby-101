# ========================================================================================
# Assignment 4
# ========================================================================================

# ========================================================================================
#  Problem 1 - Fibonacci

# 1, 1, 2, 3, 5, 8, 13, 21, ...
  0  1  2  3  4  5   6   7
# F[0] -> 1
# F[1] -> 1
# F[n] -> F[n-2] + F[n-1]

def fib(n)
  if n == 0
    1
  elsif n == 1
    1
  else
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
    attr :item
    attr_accessor :link
    def initialize(item)
      @item = item
      @link = nil
    end
  end
  
  def initialize
    @head = nil
    @tail = nil
  end
  def enqueue(new_item)
    new_node = Node.new new_item
    if (@tail.nil?)
      @head = new_node
    else
      @tail.link = new_node
    end
    @tail = new_node
  end
  def dequeue
    node = @head
    @head = node.nil? ? nil : node.link
    node.nil? ? nil : node.item
  end
  def empty?
    @head.nil?
  end
  def peek
    @head.nil? ? nil : @head.item
  end
  def length
    some_node = @head
    if some_node.nil?
      return 0
    end
    count = 1
    while some_node.link != nil
      some_node = some_node.link
      count += 1
    end
    count
  end

end  # class Queue


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
    attr :item
    attr_accessor :link
    def initialize(item)
      @item = item
      @link = nil
    end
  end  # class Node

  def initialize
    @first = nil
    @last = nil
  end
  def empty?
    @first.nil?
  end
  def length
    if @first.nil?
      count = 0
    else
      count = 1
      some_node = @first
      while some_node.link != nil
        some_node = some_node.link
        count += 1
      end
    end
    count
  end
  def <<(item)
    new_node = Node.new item
    if @last.nil?
      @first = new_node
      @last = new_node
    else
      @last.link = new_node
      @last = new_node
    end
  end
  def first
    @first.nil? ? nil : @first.item
  end
  def last
    @last.nil? ? nil : @last.item
  end
  def each(&block) # this method doesn't appear to be working
    if @head.nil?
      nil
    else
      some_node = @head
      while some_node != nil
        block.call(some_node.item)
        some_node = some_node.link
      end
    end
  end
  def delete(thing)
    if @first.nil?
      nil
    elsif @first.item == thing
      some_node = @first
      @first = some_node.link
      some_node.item
    else
      some_node = @first
      while some_node != nil
        next_node = some_node.link
        if next_node.item == thing
          some_node.link = next_node.link
          return next_node.item
        end
        some_node = next_node
      end
      # not found
      return nil
    end
  end
end  # class LinkedList
