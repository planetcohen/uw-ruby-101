# ========================================================================================
# Assignment 2
# ========================================================================================
#Doug McGowan
# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)

if ary.count > 1
	last_word=ary.pop
	first_words=ary.join ", "
	new_sentence=first_words + " and " + last_word	
else
	new_sentence=ary.join
end

return new_sentence

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
sum=0.0  
ary.each {|item| sum+=item}
return sum/ary.count
end

def median(ary)
  return ary.sort[ary.count/2]
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
   found_value = Array.new
   ary[0].fetch(key)
   ary.each {|item| found_value << item.fetch(key)}
   return found_value
end

# Your method should generate the following results:
records = [ {:name => "John", :instrument => "guitar"}, {:name => "Paul", :instrument => "bass"}, {:name => "George", :instrument => "guitar"}, {:name => "Ringo", :instrument => "drums"}]

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


# line format: date, payee, amount, type

def monthlystatement

#transation_record = {:date => date, :payee => payee, :amount => amount, :type => type}  
transaction_record = Array.new
x=0

File.open("assignment02-input.csv") do |input| 
  records = input.readlines.map do |line|
  fields = line.split "," 
    if x >=1
    transaction_record << {:date => fields[0], :payee => fields[1], :amount => fields[2], :type => fields[3]} 
    end

  #puts line
  #puts "newline" 
  #puts fields
  x+=1
  end 
 end

#puts transaction_record

render_html "Monthly Statement", transaction_record

end



def render_record(r)
<<RECORD
  <tr>
    <td>#{r[:date]}</td>
    <td>#{r[:payee]}</td>
    <td>#{r[:amount]}</td>
    <td>#{r[:type]}</td>
  </tr>
RECORD
end

def render_records(records)
<<RECORDS
  <table>
    #{records.map {|r| render_record r}.join "\n"}
  </table>
RECORDS
end

def render_body(title, records)

withdrawals = records.select do |t|
	t[:type][0].chr == "w"
end

deposits = records.select do |t|
	t[:type][0].chr == "d"
end


<<BODY
  <body>
    <h1>#{title}</h1>
    <h2>Withdrawals</h2>
    #{render_records withdrawals}
    <h2>Deposits</h2>
    #{render_records deposits}
  </body>
BODY

end

def render_head(title)
<<HEAD
  <head>
    <title>#{title}</title>
  </head>
HEAD
end


def render_html(title, records)


file = File.open("monthlystatement.html", "w+")

html = <<HTML
    <!doctype html>
    <html>
      #{render_head title}
HTML

file.print html

html = <<HTML
 #{render_body title, records}
HTML

file.print html

file.print "</html>"

end
