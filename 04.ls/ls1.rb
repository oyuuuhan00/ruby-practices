#!/usr/bin/env ruby
# frozen_string_literal: true

def run
  number_of_columns = 3
  file_name = Dir.glob('*')
  nested_file_name = file_name_arrange(file_name, number_of_columns)
  build_up(nested_file_name)
end

def file_name_arrange(file_name, number_of_columns)
  file_names = Rational(file_name.size, number_of_columns).ceil
  file_name.each_slice(file_names).to_a
end

def build_up(nested_file_name)
  max_length = nested_file_name.max_by(&:length).length

  (0...max_length).each do |i|
    nested_file_name.each do |array|
      print array[i].to_s.ljust(16) if array[i]
    end
    puts
  end
end

run
