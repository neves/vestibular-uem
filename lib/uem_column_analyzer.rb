require '../lib/column_analyzer'
require '../lib/enumerator_filter'

class UemColumnAnalyzer
	def self.analyze_file(filename)
		indexes = []
		File.open(filename) do |f|
			lines = EnumeratorFilter.new(f) {|line| line =~ /^ ?\d{5}/}
			indexes = ColumnAnalyzer.analyze_lines(lines)
		end
		ColumnAnalyzer.line_mask(indexes)
	end
end