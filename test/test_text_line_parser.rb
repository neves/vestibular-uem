require 'rubygems'
require 'nanotest'
include  Nanotest

require '../lib/text_line_parser'
require 'test_helper'

context = TextLineParserContext.new
parser = TextLineParser.new(context) do
  rule :candidato, /^\s?\d{5}-\d/
  curso /^CURSO: /
end

assert("regexp") { parser.match "UNIVERSIDADE ESTADUAL", /^UNIVERSIDADE/ }
assert { parser.match "UNIVERSIDADE ESTADUAL", /ESTADUAL/ }

assert "should accept proc that returns true if match" do 
  parser.match("123\r\n") {|line| line.strip.length == 3}
end

assert "should call candidato method on context, passing string as parameter" do
  parser.parse_line("44053-7  ADRIANE OLIVEIRA COSTA") == context.sum[:candidato]
end

assert "should call curso method on context, passing string as parameter" do
  parser.parse_line("CURSO: 022 - Administração") == context.sum[:curso]
end

assert "should call curso and candidato with lines from a string" do
  lines = ["44053-7  ADRIANE OLIVEIRA COSTA\n", "CURSO: 022 - Administração\n"]
  parser.parse(lines.join)
  context.sum[:curso] = lines.first && context.sum[:candidato] = lines.last
end