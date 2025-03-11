#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

TYPE_LIST = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze

PERMISSION_LIST = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def main
  params = ARGV.getopts('l')

  files = Dir.glob('*')
  list_files(files, long_format: params['l'])
end

def list_files(files, long_format: false)
  long_format = list_long(files)
end

def build_filetype(file_stat)
  file_type = TYPE_LIST[format('%06o', file_stat.mode)[0, 2]]
  "#{file_type}"
end

def build_filemode(file_stat)
  permissions = file_stat.mode.to_s(8)[-3..].chars.map { |num| PERMISSION_LIST[num] }
  "#{permissions.join("")}"
end

def list_long(files)
  long_formats = files.map { |file| get_longformats(file) }
  max_length_map = get_max_length_map(long_formats)
  block_total = long_formats.map { |long_format| long_format[:blocks] }.sum

  puts "total #{block_total}"
  long_formats.each { |long_format| print_long_format(long_format, max_length_map) }
end

def get_max_length_map(long_formats)
  {
    number_of_links: long_formats.map { |long_format| long_format[:number_of_links].size }.max,
    owner_name: long_formats.map { |long_format| long_format[:owner_name].size }.max,
    group_name: long_formats.map { |long_format| long_format[:group_name].size }.max,
    file_size: long_formats.map { |long_format| long_format[:file_size].size }.max
  }
end


def get_longformats(files)
  files_stat = File::Stat.new(files)
  {
    file_type: build_filetype(files_stat),
    file_mode: build_filemode(files_stat),
    number_of_links: files_stat.nlink.to_s,
    owner_name: Etc.getpwuid(files_stat.uid).name,
    group_name: Etc.getgrgid(files_stat.gid).name,
    file_size: files_stat.size.to_s,
    last_modified_time: files_stat.mtime.strftime('%_m %_d %H:%M'),
    pathname: files,
    blocks: files_stat.blocks
  }
end

def print_long_format(long_format, max_length_map)
  print [
    "#{long_format[:file_type]}#{long_format[:file_mode]} ",
    "#{long_format[:number_of_links].rjust(max_length_map[:number_of_links])} ",
    "#{long_format[:owner_name].ljust(max_length_map[:owner_name])}  ",
    "#{long_format[:group_name].ljust(max_length_map[:group_name])}  ",
    "#{long_format[:file_size].rjust(max_length_map[:file_size])} ",
    "#{long_format[:last_modified_time]} ",
    "#{long_format[:pathname]}\n"
  ].join
end

main
