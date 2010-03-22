# Classe utilizada para processar dados de um arquivo de texto complexo.
# Cada linha do arquivo é analisada e direcionada para um método que irá tratá-la.
# @TODO a ordem importa?
# @TODO deve parar ou continuar o match após encontrar o primeiro?

class TextLineParser

  def initialize(context = nil, &block)
    @context = context
    @rules = {}
		instance_eval(&block)
  end
=begin
  def self.build(context = nil, &block)
    textParser = self.new(context)
    textParser.instance_eval(&block)
    return textParser
  end
=end
  def rule(method, matcher)
    @rules[method] = matcher
  end

  def method_missing(method, matcher)
    rule method, matcher
  end

  def parse(lines)
    return if @rules.empty?
    lines.each { |line| parse_line(line) }
  end

  def parse_line(line)
    @rules.each do |method, matcher|
      return @context.send(method, line) if match(line, matcher) && @context.respond_to?(method)
    end
  end

  def match(line, matcher = nil, &block)
    matcher = block if block_given?
    return line =~ matcher if matcher.is_a? Regexp 
    return matcher.call(line) if matcher.is_a? Proc
  end
end
