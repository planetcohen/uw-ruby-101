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
  n = n.to_i
  fn = (n <= 1 ? 1 : fib(n-2) + fib(n-1))
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
  def initialize
    @wholepile = nil
    @bottom = nil
  end

  class Piece
    attr :chunk, :therest
    def initialize(chunk, therest)
      @chunk = chunk
      @therest = therest
    end
    def chunk=(new_chunk)
      @chunk = new_chunk
    end
    def therest=(new_therest)
      @therest = new_therest
    end
  end

  def enqueue(chunk)
    @wholepile = Piece.new chunk, @wholepile
    self
  end

  def dequeue
    def qDigger(leveldown)
      if leveldown.therest.nil?
        @bottom = leveldown.chunk
        return nil
      else
        leveldown.therest = qDigger(leveldown.therest)
        leveldown
      end
    end

    if @wholepile.nil?
      @bottom = nil
    elsif @wholepile.therest.nil?
      @bottom = @wholepile.chunk
      @wholepile = nil
    else
      @wholepile.therest = qDigger(@wholepile.therest)
    end
    @bottom
  end

  def empty?
    @wholepile.nil?
  end

  def peek
    if @wholepile.nil?
      return nil
    else
      digger = @wholepile
      until digger.nil?
        bottom = digger.chunk
        digger = digger.therest
      end
      bottom
    end
  end

  def length
    if @wholepile.nil?
      return 0
    else
      counter = 0
      digger = @wholepile
      until digger.nil?
        counter += 1
        digger = digger.therest
      end
      counter
    end
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

class LinkedList < Queue
  def initialize
    @wholepile = nil
    @bottom = nil
  end

  def <<(chunk)
    enqueue(chunk)
  end

  def first
    peek
  end

  def last
    if @wholepile.nil?
      return nil
    else
      @wholepile.chunk
    end
  end

  def each(&block)
    def eachdigger(leveldown, &block)
      if leveldown.therest.nil?
        block.call leveldown.chunk
      else
        eachdigger(leveldown.therest, &block)
        block.call leveldown.chunk
      end
    end

    if @wholepile
      eachdigger(@wholepile, &block)
    end
  end

#I suspect I can make this code more efficient....
  def delete(match)
    def deldigger(leveldown, match)
      if leveldown.chunk == match
        #if it was the last chunk in the wholepile, then have to return nil
        if leveldown.therest.nil?
          return nil
        #if it was the second to last chunk, then can delete and reassign
        #otherwise digger would get called for a nil value -- no bueno
        elsif leveldown.therest.therest.nil?
          leveldown.chunk = leveldown.therest.chunk
          leveldown.therest = nil
          leveldown
        #otherwise, good to go for calling digger again
        else
          leveldown.chunk = leveldown.therest.chunk
          leveldown.therest = deldigger(leveldown.therest.therest, match)
          leveldown
        end
      #check if we're at the end and need to stop calling digger
      elsif leveldown.therest.nil?
        return nil
      else
        leveldown.therest = deldigger(leveldown.therest, match)
      end
    end

    if @wholepile
      #check if there is only one entry in @wholepile, and if that entry is a
      #match
      if @wholepile.therest.nil?
        if @wholepile.chunk == match
          @wholepile = nil
        end
      #oterwise, go on as usual
      else
        @wholepile.therest = deldigger(@wholepile, match)
      end
    end
  end
end
