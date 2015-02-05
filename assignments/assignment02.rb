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
	sum/ary.count
end

def median(ary)
  ary.sort[ary.count/2]
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
  found_value
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

require 'date'


	$file = File.open("monthlystatement.html", "w")

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


$file.print "<table>"

records.map {|r| $file.print render_record r}

$file.print "</table>"

end

def render_body(title, records)

total_withdrawals = 0
	withdrawals = records.select do |t|
		t[:type][0].chr == "w"
	end
	total_withdrawals = withdrawals.map {|withdrawal| withdrawal[:amount]}.reduce{|amount, acc| amount + acc}


total_deposits = 0
	deposits = records.select do |t|
		t[:type][0].chr == "d"
	end
total_deposits = deposits.map {|deposit| deposit[:amount]}.reduce{|amount, acc| amount + acc}


$file.print <<BODY
	<body>
		<h1>#{title}</h1>
		<h2>Withdrawals</h2>
BODY


render_records withdrawals


$file.print "<h2>Deposits</h2>"


render_records deposits

$file.print "<h2>Daily Balance</h2>"
$file.print "<table>"

daily_balance = 0
trans_dates = records.map {|trans_date| trans_date[:date]}.uniq.sort
#puts trans_dates

trans_dates.reduce(0) do |daily_bal, acc_date|
	daily_deposits = records.select do |t|
		t[:date]==acc_date and t[:type][0].chr == "d"
	end
	daily_deposits_amt = daily_deposits.map {|deposit| deposit[:amount]}.reduce{|amount, acc| amount + acc}
			if daily_deposits_amt == nil
				daily_deposits_amt = 0
			end
	daily_withdrawals = records.select do |t|
		t[:date]==acc_date and t[:type][0].chr == "w"
	end
	daily_withdrawals_amt = daily_withdrawals.map {|withdrawal| withdrawal[:amount]}.reduce{|amount, acc| amount + acc}
			if daily_withdrawals_amt == nil
				daily_withdrawals_amt = 0
			end
daily_balance = daily_balance + daily_deposits_amt - daily_withdrawals_amt
$file.print <<ROW
<tr>
<td>#{acc_date}</td><td>#{daily_balance}</td>
</tr>
ROW
end


$file.print "</table>"

ending_balance = total_deposits - total_withdrawals

$file.print "<h2>Summary</h2>"
$file.print <<SUMMARY
<table>
<tr><td>Starting Balance:</td><td>0</td></tr>
<tr><td>Total Deposits:</td><td>#{total_deposits}</td></tr>
<tr><td>Total Withdrawals:</td><td>#{total_withdrawals}</td></tr>
<tr><td>Ending Balance:</td><td>#{ending_balance}</td></tr>
</table>
SUMMARY


$file.print "</body>"


end

def render_head(title)
<<HEAD
	<head>
		<title>#{title}</title>
	</head>
HEAD
end


def render_html(title, records)


html = <<HTML
		<!doctype html>
		<html>
			#{render_head title}
HTML

$file.print html


render_body title, records


$file.print "</html>"

$file.close

end

#transation_record = {:date => date, :payee => payee, :amount => amount, :type => type}
transaction_record = Array.new
x=0

File.open("assignment02-input.csv") do |input|
	records = input.readlines.map do |line|
	fields = line.split ","
		if x >=1
		transaction_record << {:date => Date.strptime(fields[0], "%m/%d/%Y"), :payee => fields[1], :amount => fields[2].to_f, :type => fields[3]}
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
