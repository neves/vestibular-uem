require 'rubygems'
require 'nanotest'
include  Nanotest

require '../lib/column_line_parser'
require 'test_helper'

assert { ColumnLineParser.mask2unpack(" -  --+ ") == "x1A1x2A2A1x1" }

mask = " -------  -------------------------------- ------   ---- ---- ----  ---- ----  ----- ----+  ---- ----  ------   ---  ---"
line = " 06925-6  ANA PAULA BAQUETA                050879   36   26,3 31,1  15,0 10,0   39,5 10,5E   5,2 15,8   539,2    15  APR"
names = [:inscricao, :nome,                        :nasc,  :red, :geo,:his, :bio,:mat,  :por,:le,:i,:fis,:qui,  :sum,   :cls,:ar]

expected = {
  :inscricao => "06925-6",
  :nome => "ANA PAULA BAQUETA",
  :nasc => "050879",
  :red => "36",
  :geo => "26,3",
  :his => "31,1",
  :bio => "15,0",
  :mat => "10,0",
  :por => "39,5",
  :le => "10,5",
  :i => "E",
  :fis => "5,2",
  :qui => "15,8",
  :sum => "539,2",
  :cls => "15",
  :ar => "APR"
}

assert { ColumnLineParser.new(mask, names).parse(line) == expected }