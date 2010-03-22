require 'rubygems'
require 'nanotest'
include  Nanotest

require '../lib/column_analyzer'
require '../lib/enumerator_filter'
require 'test_helper'

line = " 123 456  789 \n";

assert { ColumnAnalyzer.spaces(line) == [0, 4, 8, 9, 13] }
assert { ColumnAnalyzer.not_spaces(line) == [1, 2, 3, 5, 6, 7, 10, 11, 12, 14] }

lines = <<T
A  B   C
12 2   34
4  5   6
7  80  9
T
assert { ColumnAnalyzer.analyze_lines(lines) == [2, 5, 6] }

assert { ColumnAnalyzer.line_mask([2, 5, 6]) == "-- --  " }


=begin

start = Time.now
File.open("../downloads/txt/uemin97l.txt") do |f|
  lines = EnumeratorFilter.new(f) {|line| line =~ /^ \d{5}/}
  indexes = ColumnAnalyzer.analyze_lines(lines)
  p ColumnAnalyzer.line_mask(indexes)
end

p Time.now - start

=end