class TextParser

  def initialize(context)
    @context = context
    @rules = []
  end
  
  def self.build(context, &block)
    textParser = TextParser.new(context)
    textParser.instance_eval(&block)
    return textParser
  end

  def rule(method, regexp)
    @rules << {:method => method, :regexp => regexp}
  end
  
  def parse(file)
    return if @rules.empty?
    file.each_line { |line| parse_line(line) }
  end
  
  private
  def parse_line(line)
    @rules.each do |rule|
      @context.send(rule[:method], line) if line =~ rule[:regexp]
    end
  end
end
