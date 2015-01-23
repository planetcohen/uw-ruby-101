# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  # pull all but the last element from the input array, join them with commas
  my_sentence = ary[0...-1].reduce {|word, acc| word.to_s + ", #{acc}"}
  
  # make a new array that is the sentence string and the last element in the input array
  and_last = [my_sentence, ary[-1]]
  
  # compact to handle NA values for 1 or 0 word inputs
  and_last.compact!
  
  # adding 'and' to the last element in the sentence but with a bonus oxford comma
  and_last.join ", and "
end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary)
  # add all the numbers together
  sum = ary.reduce {|i, acc| i + acc }

  # divide by the length, convert to floating point
  mean = sum/ary.length.to_f
  return mean
end

def median(ary)
  # find the length of the array 
  len = ary.length
  
  # sort the array
  ary.sort!

  # if it's odd, return the middle number
  if len % 2 == 1
    median = ary[len/2]

  # if it's even, average the two in the middle
  else
    median = (ary[len/2].to_f + ary[-1 + len/2].to_f) / 2 
  end
  return median
end

# Your method should generate the following results:
mean [1, 2, 3]    #=> 2
mean [1, 1, 4]    #=> 2

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
def pluck(ary)
  # initialize an empty array
  result = []

  # iterate over each hash in the input array
  ary.each do |hash|
  	result << hash[key]
  end
  return result
end

# Your method should generate the following results:
records = [
  {:name => "John",   :instrument => "guitar"},
  {:name => "Paul",   :instrument => "bass"  },
  {:name => "George", :instrument => "guitar"},
  {:name => "Ringo",  :instrument => "drums" }
]
pluck records, :name        #=> ["John", "Paul", "George", "Ringo"]
pluck records, :instrument  #=> ["guitar", "bass", "guitar", "drums"]


# ========================================================================================
#  Problem 4 - monthly bank statement

# given a CSV file with bank transactions for a single account (see assignment02-input.csv)
# generate an HTML file with a monthly statement

# assume starting balance is $0.00

# the monthly statement should include the following sections:
# - withdrawals
# - deposits
# - daily balance
# - summary:
#   - starting balance, total deposits, total withdrawals, ending balance


### ran into ruby version problems, will have to update with problem 4 later
