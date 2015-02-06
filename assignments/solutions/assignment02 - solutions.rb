# ========================================================================================
#  Assignment submitted by Gordon Turibamwe
#
# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
# Problem 1 - `to_sentence`
# implement method `to_sentence`
# creates an english string from array

def to_sentence(arr)
  first_sentence, second_sentence, sentence = "", "", ""
  "\"\"" if arr.empty?
  arr.each do |word|
    if arr.index(word) < arr.length-1
      first_sentence << word.to_s + ", "
    elsif arr.length >= 2
      second_sentence << " and " + word.to_s
    else
      second_sentence << word.to_s
    end
  end
  sentence = first_sentence.chop.chop + second_sentence
  return sentence
end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo", 4]  #=> "1, paul, 3 and ringo"

# ========================================================================================
 # Problem 2 - `mean, median`

 def mean(ary)
  sum = 0.0
  mean = 0.0
  ary.each do |num|
    sum += num
  end
  mean = sum/ary.length
  return mean.round(1)
end

# Median
def median(ary)
  length = ary.length
  median = 0.0
  if length % 2 > 0
    median = ary[length / 2.0]
  else
    div = (length + 1) / 2
    median = (ary[div - 1] + ary[div] )/ 2.0
  end
  return median
end

# Your method should generate the following results:
mean [1, 2, 3, 7]    #=> 2.0
mean [1, 1, 4]    #=> 2.0

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
def pluck(ary, key)
  keyArray = []
  ary.each do |item|
    if key.eql?(:name)
      keyArray << item[:name]
    else
      keyArray << item[:instrument]
    end
  end
  return keyArray
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

def statement
  data = File.open("assignment02-input.csv", "r")
  new_file = File.open("newFile.pdf", "w")
  lines = data.readlines
  new_file << lines
  keys = lines.shift.chomp.split(",").map {|key| key.to_sym}
  p lines
  p keys
  data.close
end

statement
















