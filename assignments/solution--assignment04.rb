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
  return  1  if (0..1).include? n
  (fib( n - 1 ) + fib( n - 2 ))
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
    attr_accessor :value, :next_node
    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end

  def initialize
    @size = 0
  end

  def empty?
    @size == 0
  end

  def length
    @size
  end

  def <<(item)
    if @head.nil?
      @head = @tail = Node.new(item, nil)
    else
      add_value = Node.new(item, nil)
      add_value.next_node = @head
      @head = add_value
    end
    @size += 1
    self
  end

  def first
    if !empty?
      @tail.value
    else
      nil
    end
  end
  def last
    if !empty?
      @head.value
    else
      nil
    end
  end
  def each(&block)
    iterate = @head
    while not iterate.nil?
      block.call iterate.item
      iterate = iterate.link
    end
  end
  def delete(value)
    @head.next_node = @head
    if @head.value = value
      @head = @head.next_node
    else
      while (@head.next_node != nil) && (@head.next_node.value != value)
        @head = @head.next_node
      end
      unless @head.next_node == nil
        @head.next_node = nil
      end
    end
  end
end

ll = LinkedList.new
p ll.empty?            #=> true

p ll << "first"
p ll.empty?            #=> false
p ll.length            #=> 1
p ll.first             #=> "first"
p ll.last              #=> "first"

p ll << "second"
p ll.length            #=> 2
p ll.first             #=> "first"
p ll.last              #=> "second"

p ll << "third"        #=> 3
# p ll.each {|x| puts x} #=> prints out "first", "second", "third"
p ll.length            #=> 3

p ll.delete "second"   #=> "second"
p ll.length            #=> 2
# ll.each {|x| puts x} #=> prints out "first", "third"
p ll.empty?            #=> true


# ========================================================================================
#  Problem 2 - Queue

# implement a Queue class that does not use Array.

# expected behavior:
# q = Queue.new
# q.empty?            #=> true
# q.enqueue "first"
# q.empty?            #=> false
# q.enqueue "second"
# q.dequeue           #=> "first"
# q.dequeue           #=> "second"
# q.dequeue           #=> nil

class Queue
  def initialize
    @val = LinkedList.new
  end

  def enqueue(item)
    @val << item
    self
  end

  def dequeue
    return nil if empty?
    @val.delete(@val.first)
  end

  def empty?
    @val.empty?
  end

  def peek
    return nil if empty?
    @val.first.item
  end

  def length
    @val.length
  end
end

q = Queue.new
p q.empty?            #=> true
p q.enqueue "first"
p q.enqueue "second"
p q.enqueue "third"
p q.empty?            #=> false
puts ""
p q.dequeue
puts q
p q.length
q.enqueue "second"
q.dequeue           #=> "first"
q.dequeue           #=> "second"
p q.dequeue           #=> nil





