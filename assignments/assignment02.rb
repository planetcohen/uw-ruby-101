# ========================================================================================
#  Assignment submitted by Gordon Turibamwe
#
# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)  
  # PSEUDO CODE
  # get array
  # create new string
  # add each word to new string
  # if more than 2 words, add "and" before the last word
  # print sentence

  sentence = ""
  ary.each do |word|
    if ary.length > 2 && ary.index(word) == ary.length - 1
      sentence += "and "
    end
    sentence += word.to_s + ',' + " "
  end
  sentence = sentence.chomp(", ")
print sentence
return sentence #added this tests
end

# Your method should generate the following results:
#to_sentence []                       #=> ""
#to_sentence ["john"]                 #=> "john"
#to_sentence ["john", "paul"]         #=> "john and paul"
#to_sentence [1, "paul", 3, "ringo"]  #=> "1, paul, 3 and ringo"

# ========================================================================================
#  Problem 2 - `mean, median`

# implement methods "mean", "median" on Array of numbers
def mean(ary)
  # PSEUDO CODE
  # Inititate sum variable
  # iterate arry adding each velue to sum variable
  # divide sum variabe by length of the array and convert to a float

  sum = 0.0
  mean = 0.0
  ary.each do |num|
    sum += num
    mean = sum / ary.length
  end
  print mean.round(1)
  return mean.round(1)
end

def median(ary)
  # PSEUDO CODE
  # if the length is odd
  # get the ary length and 1 to it divide by 2 to get the index of the value
  # if the length is even
  # get the ary length add 1 and find the index nums between the tow values and get their average

  length = ary.length
  median = 0.0
  if length % 2 > 0
    median = ary[length / 2.0]
  else
    div = (length + 1) / 2
    median = (ary[div - 1] + ary[div] )/ 2.0
  end
print median
return median
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
  # PSEUDO CODE
  # iterate array
  # iterate the hash
  # if key, print keys
  # if vlaues print values
  keyArray = []
  ary.each do |item|
    if key.eql?(:name)
        keyArray << item[:name]
      else
        keyArray << item[:instrument]
    end
  end
print keyArray
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
#   - starting balance, total deposits, total withdrawals, ending balance

def render_html(title, records)
<<HTML
  <!doctype html>
  <html>
    #{render_head title}
    #{render_body title, records}
  </html>
HTML
end

def render_head(title)
<<HEAD
  <head>
  <title>#{title}</title>
  </head>
HEAD
end

def render_body(title, records)
<<BODY
  <body>
  <h1>#{title}</h1>
  #{render_records records}
  </body>
BODY
end

def render_records(records)
<<RECORDS
  <table>
  #{render_table_header}
  #{records.map {|r| render_record r}.join "\n"}
  </table>
RECORDS
end

def render_record(r)
<<RECORD
  <tr>
  <td>#{r[:fname]}</td>
  <td>#{r[:lname]}</td>
  <td>#{r[:age]}</td>
  <td>#{r[:addr][:street]}</td>
  <td>#{r[:addr][:city]}</td>
  <td>#{r[:addr][:state]}</td>
  <td>#{r[:addr][:zip]}</td>
  </tr>
RECORD
end



