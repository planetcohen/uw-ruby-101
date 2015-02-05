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
  if n < 2
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


class Queue
  class Node
    attr :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end

    def link=(new_link)
      @link = new_link
    end
    
  end
  
  def initialize
    @nodes = nil;
  end

  def enqueue(item)
    node = @nodes
    if node
      #get to the end of the queue
      while node.link do
        node = node.link
      end
      #add to the end of the queue
      node.link = Node.new item, nil 
    else
      @nodes = Node.new item, nil
    end
    self
  end

  def dequeue
    node = @nodes
    @nodes = node.nil? ? nil : node.link
    node.nil? ? nil : node.item
  end

  def empty?
    @nodes.nil?
  end

  def peek
    @nodes.nil? ? nil : @nodes.item
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
    attr :item, :link
    def initialize(item, link)
      @item = item
      @link = link
    end

    def link=(new_link)
      @link = new_link
    end
    
  end

  def initialize
    @head = nil;
    @tail = @head;
  end

  def empty?
    @head.nil?
  end

  def length
    count = 0
    node = @head
    while node
      count += 1
      node = node.link
    end
    count 
  end

  def <<(item)
    #first node 
    if @head.nil?
      @head = Node.new item, nil
      @tail = @head
    else
      last_node = @tail
      last_node.link = Node.new item, nil
      @tail = last_node.link
    end
    self
  end

  def first
    @head.item
  end

  def last
    @tail.item
  end

  def delete(item)
    prev_node = @head
    node = @head
    found = false
    #move head
    while @head.item == item
      @head = head.link
    end

    #delete node
    while node do 
      if node.item == item 
        prev_node.link = node.link
        found = true
      end

      #move tail to the last node
      if node.link
        @tail = node
      end 

      node = node.link
    end

    #if not found return nil
    found ? item : nil
  end


  def each(&block)
    node = @head
    while node do 
      if block_given?
        block.call node.item
      else
        puts "no block"
      end
      node = node.link
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
