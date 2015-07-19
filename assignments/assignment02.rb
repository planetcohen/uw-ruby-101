# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(input)
  count = input.count
    if count > 2
            last = input.pop
            input.each do |word|
            print "#{word}, "
            end
            print "and #{last}"
    elsif count == 2
            last = input.pop
            input.each do |word|
            print "#{word} "
            end
            print "and #{last}"
    else
        return input.shift
    end

# Your method should generate the following results:
to_sentence []                       #=> ""
to_sentence ["john"]                 #=> "john"
to_sentence ["john", "paul"]         #=> "john and paul"
to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"


# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers

ef mean(ary)
  count = ary.count
  total = 0
  ary.each do |num|
      total = num + total
  end
  mean = total / count
  return mean
end

def median(ary)
  count = ary.count
  total = 0
  if !(count.even?)
      middle = (count - 1)/2
      return ary[middle]
  else
      right = (count/2)
      left = (count/2)-1
      return (ary[left] + ary[right])/2.to_f
  end
end
# Your method should generate the following results:
mean [1, 2, 3]    #=> 2.0
mean [1, 1, 4]    #=> 2.0

median [1, 2, 3]  #=> 2
median [1, 1, 4]  #=> 1


# ========================================================================================
#  Problem 3 - `pluck`

# implement method `pluck` on array of hashes
def pluck(ary, key)
  ary.map {|item| item[key]}
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


#Take in file name as an arguement
filename = ARGV.first

def read_data (file)
	#Open and read file
	raw_data = open(file, 'r')
	#Separate file into lines
	lines = raw_data.readlines
	#Close file
	raw_data.close
	#Remove the first line, separate each word, and store as symbols
	keys = lines.shift.chomp.split(",").map do |key|
		key.to_sym
	end

	data = Hash.new

	lines.map do |line|
		#Separates each line and uses the value and it's index to store in an array.
		line.chomp.split(",").each_with_index {|field, index| data[keys[index]] = field}
	end
end

read_data filename
  
  # ----------------------------------------------------------------------
  
  # --------------------------------------------------------------
  
  # -------------------------------------------------------------
  
  # ---------------------------------------------------------
