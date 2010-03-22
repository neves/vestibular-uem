require 'pathname'
__DIR__ = Pathname.new(File.dirname __FILE__)

require "../lib/uem_column_analyzer"

target_dir = __DIR__ + "../downloads/txt"
File.open("../masks.txt", "w") do |out|
	Dir[target_dir+"*"].each do |filename|
		puts File.basename(filename)
		out.puts File.basename(filename)
		mask = UemColumnAnalyzer.analyze_file(filename)
		puts mask
		out.puts mask
	end
end