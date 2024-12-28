#!/usr/bin/env ruby
require 'date'
require "optparse"

option = {}
OptionParser.new do |opt|
  opt.on('-m value') { |n| option[:m] = n }
  opt.on('-y value') { |n| option[:y] = n }
  opt.parse!(ARGV)
end

month = option[:m]&.to_i || Date.today.month

year = option[:y]&.to_i || Date.today.year

firstday_date = Date.new(year, month, 1)
lastday_date = Date.new(year, month, -1)
weekday = "日 月 火 水 木 金 土"

head = "#{month}月 #{year}"
puts head.center(20)
print weekday
puts "\n"

print "   " * firstday_date.wday
(firstday_date..lastday_date).each do |date|
  print date.day.to_s.rjust(2) + " "
  print "\n" if date.saturday?
end
