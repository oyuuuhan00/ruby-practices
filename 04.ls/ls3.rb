#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('ar')

def run(options)
  number_of_columns = 3
  file_names = enter_files(options)
  divided_file_names = divide_file_names(file_names, number_of_columns)
  file_names_to_output = build_up(divided_file_names)
  output(file_names_to_output)
end

def divide_file_names(file_names, number_of_columns)
  number_of_filename = Rational(file_names.size, number_of_columns).ceil
  file_names.each_slice(number_of_filename).to_a
end

def build_up(divided_file_names)
  max_length = divided_file_names.max_by(&:length).length

  columns_max_length = divided_file_names.map do |array|
    array.map(&:to_s).map(&:length).max
  end

  file_names_to_output = []

  (0...max_length).each do |i|
    row = divided_file_names.map.with_index do |array, col_index|
      item = array[i].to_s
      item.ljust(columns_max_length[col_index] + 6)
    end.join

    file_names_to_output << row
  end

  file_names_to_output
end

def output(file_names_to_output)
  file_names_to_output.each { |line| puts line }
end

def enter_files(options)
  files = if options['a']
            Dir.glob('*', File::FNM_DOTMATCH)
          else
            Dir.glob('*')
          end
  files = files.reverse if options['r']
  files
end

run(options)
