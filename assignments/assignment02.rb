# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary, punctuate=false) # Optionally capitalizes the 1st word & appends a period (just for fun...)
  new_string = ""
  last_index = ary.length - 1
  ary.each_with_index do |word, index|
    if index == last_index
      new_string << word.to_s
    elsif index == ( last_index - 1 )
      new_string << word.to_s << " and "
    else
      new_string << word.to_s << ", "
    end
  end
  if punctuate
    return new_string.capitalize << "."
  else
    return new_string
  end
end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary, keep_precision=false) # sometimes I might want to be sure I got a float back...
  if keep_precision
    return ary.inject(:+) / ary.length.to_f
  else
    return ary.inject(:+) / ary.length
  end
end

def median(ary)
  # If there are two middle numbers, they must be averaged
  if ary.length % 2 == 0
    sorted_array = ary.sort
    last_index = sorted_array.length - 1
    middle_index_1 = sorted_array.length / 2
    middle_index_2 = ( last_index / 2 ).floor
    average_of_middles = ( sorted_array[middle_index_1].to_f + sorted_array[middle_index_2].to_f ) / 2
    # No need to return a float if it's really just an integer...
    if ( average_of_middles % 1 ) == 0
      return average_of_middles.to_i
    else
      return average_of_middles
    end
  else # If there is one middle number, just do the simplest thing
    return ary.sort[ary.length / 2]
  end
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
  # your implementation here
end

# Your method should generate the following results:
records = [
  {name: "John",   instrument: "guitar"},
  {name: "Paul",   instrument: "bass"  },
  {name: "George", instrument: "guitar"},
  {name: "Ringo",  instrument: "drums" }
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
