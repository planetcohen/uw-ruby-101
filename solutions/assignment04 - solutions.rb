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
# p fib(0)     #=> 1
# p fib(1)     #=> 1
# p fib(5)     #=> 8
# p fib(4)     #=> 5
# p fib(12)    #=> 233


# ========================================================================================
#  Problem 2 - Queue

# implement a Queue class that does not use Array.

# expected behavior:
q = Queue.new
p q.empty?            #=> true
# p q.enqueue "first"
p q.empty?            #=> false
# q.enqueue "second"
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


# # ========================================================================================
# #  Problem 3 - LinkedList

# # implement a LinkedList class that does not use Array.

# # expected behavior:
# ll = LinkedList.new
# ll.empty?            #=> true

# ll << "first"
# ll.empty?            #=> false
# ll.length            #=> 1
# ll.first             #=> "first"
# ll.last              #=> "first"

# ll << "second"
# ll.length            #=> 2
# ll.first             #=> "first"
# ll.last              #=> "second"

# ll << "third"        #=> 3
# ll.each {|x| puts x} #=> prints out "first", "second", "third"

# ll.delete "second"   #=> "second"
# ll.length            #=> 2
# ll.each {|x| puts x} #=> prints out "first", "third"

# class LinkedList
#   def initialize
#     # your implementation here
#   end
#   def empty?
#     # your implementation here
#   end
#   def length
#     # your implementation here
#   end
#   def <<(item)
#     # your implementation here
#   end
#   def first
#     # your implementation here
#   end
#   def last
#     # your implementation here
#   end
#   def each(&block)
#     # your implementation here
#   end
# end

