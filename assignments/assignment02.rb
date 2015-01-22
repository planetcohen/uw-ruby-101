# ========================================================================================
# Assignment 2
# ========================================================================================

# ========================================================================================
#  Problem 1 - `to_sentence`

# implement method `to_sentence`

# creates an english string from array

def to_sentence(ary)
  return ary.join("") if ary.length < 2
  puts "#{ary.join(", ")} and #{ary.pop}"	# String interpolated join + pop last value
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
  puts "#{ ary.inject(:+) / ary.size.to_f}" # divide by the number of numbers by the size
end

def median(ary)
  s = ary.sort! # Numbers list in numerical order	
  l = ary.length # What are we working with?
  if l.odd? # Easy Middle?
  	s[l/2] # Yay, Easy Middle!
  else
    puts "#{ (s[l/2] + s[-1+l/2]) / 2}" #Middle Pair Calc halfway between
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
  ary.map{|ary| ary[key]}
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

require 'csv'
require 'date'
  
  trans = CSV.read('C:\Users\01\Desktop\assignment02-input.csv', headers:true, header_converters: :symbol, converters: :all).collect { |row| Hash[row.collect {|c,r| [c,r] }] }
  dates = trans.map {|d| d[:date] }
  types = trans.map {|d| d[:type].to_sym}.uniq
  

  withdrawls = trans.select {|t| t[:type] == "withdrawal" }.group_by {|t| t[:date]}
  withdrawals_total = trans.select {|t| t[:type] == "withdrawal" }.inject(0) {|sum, hash| sum + hash[:amount]}
  total_withdrawls = withdrawls.length

  deposits = trans.select {|t| t[:type] == "deposit" }.group_by {|t| t[:date]}
  deposits_total = trans.select {|t| t[:type] == "deposit" }.inject(0) {|sum, hash| sum + hash[:amount]}
  total_deposits = deposits.length
  
  starting_balance = "0"
  ending_balance = deposits_total - withdrawals_total
  sorted_by_date = trans.sort {|d1, d2| d1[:date] <=> d2[:date] }.uniq
  
    def to_html_file()
  # open for writing:
  html = render_html("Statement", withdrawals, deposits, summary)
  output = File.open('C:\Users\01\Desktop\Homework4.html', "w+") do |output|
   output.print html
  end
  output.close
  end

  def render_html(title, records)
  <<HTML
    <!doctype html>
   <html>
    #{render_head title}
    #{render_body records}
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
    <td> #{r[:date]}</td>
    <td> #{r[:payee]}</td>
    <td> #{r[:amount]}</td>
    <td> #{r[:type]}</td>   
   </tr>
  RECORD
  end
