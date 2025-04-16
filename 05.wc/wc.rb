# frozen_string_literal: true

require 'optparse'

def main
  options = parse_options
  options = { c: true, l: true, w: true } if options.values.none?

  paths = ARGV
  counts = paths.empty? ? [count_from_text($stdin.read)] : paths.map { |path| count_from_file(path) }

  counts.each { |count| print_count(count, options) }
  print_total(counts, options) if counts.size > 1
end

def parse_options
  options = { c: false, l: false, w: false }
  OptionParser.new do |opt|
    opt.on('-c') { options[:c] = true }
    opt.on('-l') { options[:l] = true }
    opt.on('-w') { options[:w] = true }
  end.parse!
  options
end

def count_from_file(path)
  text = File.read(path, encoding: 'UTF-8', invalid: :replace, undef: :replace, replace: '?')
  count_data(text).merge(path: path)
end

def count_from_text(text)
  count_data(text).merge(path: '')
end

def count_data(text)
  {
    l: text.count("\n"),
    w: text.split(/\s+/).size,
    c: text.bytesize
  }
end

def print_count(count, options)
  output = []
  output << count[:l].to_s.rjust(8) if options[:l]
  output << count[:w].to_s.rjust(8) if options[:w]
  output << count[:c].to_s.rjust(8) if options[:c]
  output << " #{count[:path]}" unless count[:path].empty?
  puts output.join
end

def print_total(counts, options)
  total = {
    l: counts.sum { |c| c[:l] },
    w: counts.sum { |c| c[:w] },
    c: counts.sum { |c| c[:c] },
    path: 'total'
  }
  print_count(total, options)
end

main
