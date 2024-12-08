require 'date'

year = Date.today.year 
month = Date.today.month 
lastday_date = Date.new(year, month, -1).day

puts year
puts month

wday = ["日", "月", "火", "水", "木", "金", "土"]

wday.each do |w|
  print w
end

(1..lastday_date).each do |date|
  print date
end
