#!/usr/bin/env ruby
# frozen_string_literal: true

def run
  number_of_columns = 3
  file_names = Dir.glob('*')
  divided_file_names = divide_file_names(file_names, number_of_columns)
  build_up(divided_file_names)
  file_names_to_output = build_up(divided_file_names)
  output(file_names_to_output)
end

def divide_file_names(file_names, number_of_columns)
  number_of_filename = Rational(file_names.size, number_of_columns).ceil
  file_names.each_slice(number_of_filename).to_a
end

def build_up(divided_file_names)
  max_length = divided_file_names.max_by(&:length).length

  file_names_to_output = []

  (0...max_length).each do |i|
    row = divided_file_names.map { |array| array[i].to_s.ljust(16) if array[i] }.join
    file_names_to_output << row
  end
  file_names_to_output
end

def output(file_names_to_output)
  file_names_to_output.each { |line| puts line }
end

run
