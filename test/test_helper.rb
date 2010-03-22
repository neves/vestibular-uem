class TextLineParserContext
  attr_reader :sum
  def initialize
    @sum = {}
  end

  def respond_to?(method_sym, include_private = false)
    [:candidato, :curso].include?(method_sym) || super
  end

  def method_missing(method, line)
    @sum[method] = line
    line
  end
end
