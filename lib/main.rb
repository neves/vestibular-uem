require 'text_parser'

dir = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "txt"))
file_name = File.join(dir, "uemin97l.txt")

file = open(file_name)

class ParserContext
	attr_reader :registros

	def initialize
		mask = " -------  -------------------------------- ------ ------ ---- ---- ----- ---- ------ ----+ ----- ---- -------- ----  ---"
		k = %w(inscricao  nome                             nasc   red    geo  his  bio   mat  port   le  i fis   qui  final    clas  ar)
		@parser = LinePositions.new(mask, k)
		@registros = []
	end

	def curso_vestibular(line)
		@dados = {}
		@dados[:codigo] = /CURSO (\d{3})/.match(line)[1].strip
		@dados[:extensao] = /EXTENSAO\s+(.+)\s+CURSO/.match(line)[1].strip rescue nil
		@dados[:curso] = /-\s{2,}(.+)\s+VESTIBULAR/.match(line)[1].strip
		@dados[:ano] = /(\d\d)$/.match(line)[1].strip
		@dados[:estacao] = /(\w\w)\d\d$/.match(line)[1].strip
	end

	def data(line)
		@data = %r((\d+/\d\d/\d\d)).match(line)[1].strip
	end

	def candidato(line)
		dados = @parser.parse(line)
		dados = dados.merge(@dados)
		@registros << dados
	end
end

class LinePositions
	def initialize(mask, fields)
		@masks = {}
		inicio = nil
		i = nil
		each_with_index(mask) do |c, i, new|
			if new && inicio
				@masks[fields.shift.to_sym] = inicio...i
			end
			inicio = i if new && c != " "
			inicio = nil if c == " "
		end
		@masks[fields.shift.to_sym] = inicio...i
	end

	def parse(line)
		h = {}
		@masks.each { |k, range| h[k] = line[range] }
		return h
	end

	private

	def each_with_index(string)
		i = 0
		ant = nil
		string.each_byte do |byte|
			yield byte.chr, i, byte != ant
			i += 1
			ant = byte
		end
	end
end

context = ParserContext.new

parser = TextParser.build(context) do
  rule :curso_vestibular, /^UNIVERSIDADE/
  rule :data, /^COMISS/
  rule :candidato, /^\s\d{5}-\d/
end

parser.parse(file)

require 'pp'
require 'faster_csv'

pp context.registros