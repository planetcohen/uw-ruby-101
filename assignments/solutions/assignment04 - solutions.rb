# ========================================================================================
# Assignment 4
# ========================================================================================

# ========================================================================================
#  Problem 1 - Fibonacci

#    1, 1, 2, 3, 5, 8, 13, 21, ...
# 0, 1, 2, 3, 4, 5, 6, 7, 8

# F[0] -> 1
# F[1] -> 1
# F[n] -> F[n-2] + F[n-1]

def fib(n)
  return  n  if n <= 1
  fib(n - 1) + fib(n - 2)
end

# expected behavior:
p fib(0)     #=> 1
p fib(1)     #=> 1
p fib(5)     #=> 8
p fib(4)     #=> 5
p fib(12)    #=> 233


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
  attr_writer :items

  def initialize
    @items = []
  end

  def enqueue(item)
    @items << item
  end

  def dequeue
    puts @items[0]
  end
  def empty?
    if @items.length == 0
      puts true
    else
      puts false
    end
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
  def initialize
    @arr = []
  end
  def empty?
    if @arr.length == 0
      puts true
    else
      puts false
    end
  end
  def length
    puts @arr.length
  end
  def <<(item)
    @arr << item
  end
  def first
    puts @arr[0]
  end
  def last
    puts @arr.last
  end
  def each(&block)
    yield@arr
  end
  def delete(toDelete)
    @arr.each do |item|
      if item == toDelete
        @arr.delete(item)
      end
    end
  end
end
