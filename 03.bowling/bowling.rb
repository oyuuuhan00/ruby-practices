#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a

point = frames.each_with_index.sum do |frame, index|
  if index < 9
    if frame[0] == 10 # Strike
      10 +
        frames[index + 1][0] +
        (frames[index + 1][0] == 10 ? frames[index + 2][0] : frames[index + 1][1])
    elsif frame.sum == 10 # Spare
      frame.sum + frames[index + 1][0]
    else
      frame.sum
    end
  else
    frame.sum
  end
end

puts point
