#!/usr/bin/env ruby
require "debug"
require 'date'
require "optparse"

option = {}
OptionParser.new do |opt|
  opt.on('-m value') {|n| option[:m] = n}
  opt.on('-y value') {|n| option[:y] = n}
  opt.parse!(ARGV)
end

if option[:m]
  month = option[:m].to_i
else
  month = Date.today.month 
end

if option[:y]
  year = option[:y].to_i
else
  year = Date.today.year
end

cell_width = 2

firstday_date = Date.new(year, month, 1).day
lastday_date = Date.new(year, month, -1).day
weekday = ["日", " 月", " 火", " 水", " 木", " 金", " 土"]
start_day_of_week = Date.new(year, month, 1).wday

head = "#{month}月 #{year}"
puts head.center(20)
weekday.each do |week|
  print week
end
puts "\n"

print " " * (cell_width * start_day_of_week + start_day_of_week)
(firstday_date..lastday_date).each do |day|
  date = Date.new(year, month, day)
  print date.day.to_s.rjust(2) + " "
  print "\n" if date.saturday?
end
