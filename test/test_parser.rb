require '../lib/text_line_parser'
require '../lib/column_line_parser'

class UemParser

end

class Inv97 < UemParser
	MASK = " -------  -------------------------------- ------   ---- ---- ----  ---- ----  ----- ----+  ---- ----  ------   ---  ---"
	       # 01476-5  ADRIANA EVARINI                  131280   33   49,0 34,8  33,0 11,5   59,0 17,0E  17,9 34,9   705,0     2  APR
	NAMES = [:inscr,  :nome,                           :nasc,  :red, :geo,:his, :bio,:mat,  :por,:le,:i,:fis,:qui,  :sum,   :cls,:ar]
	SAIDA = [:edicao,:date,:curso_id,:curso_name,:inscr,:nome,:nasc,:red,:geo,:his,:bio,:mat,:por,:le,:i,:fis,:qui,:sum,:cls,:ar]

	def initialize
		@candidato_parser = ColumnLineParser.new(MASK, NAMES)
		@parser = TextLineParser.new(self) do
			curso_vestibular /^UNIVERSIDADE/
			date /^COMISSAO/
			candidato /^\s?\d{5}-\d/
		end
	end

	def parse(file)
		@parser.parse(file)
	end

	def curso_vestibular(line)
		line.match /CURSO (\d+)/
		p $1
		line.match /VESTIBULAR (.+)$/
		p $1
		line.match /-(.+)VESTIBULAR/
		p $1
	end

	def date(line)
		p line[-10..-1].strip
	end

	def candidato(line)
		p @candidato_parser.parse(line)
	end
end

File.open("fixtures/in97.txt") do |f|
  Inv97.new.parse(f)
end
