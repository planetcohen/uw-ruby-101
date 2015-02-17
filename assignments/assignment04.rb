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
  return 1 if n <= 1
  return fib(n-2) + fib(n-1)
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
  attr :item, :link
  
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
 
   def enqueue(item)
     @nodes = Node.new item, @nodes
     self
   end

   def dequeue
     node = @nodes
     @nodes = node.nil? ? nil : node.link
     node.nil? ? nil : node.item
   end
 
   def peek
     @nodes.nil? ? nil : @nodes.item
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
  attr :item

    def initialize(item)
      @item = item
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
       node = node
     end
     count
    end

   def <<(item)
   	n = Node.new item, @nodes
   	if self.length == 0 
     @first = n
    end
    @item = n
   end

   def first
     @nodes.first
   end

   def last
     @nodes.last
   end

   def delete
   	 @nodes.delete
   end

   def each(&block)
     @nodes.each(&block)
   end
end
