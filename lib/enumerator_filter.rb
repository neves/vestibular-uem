class EnumeratorFilter
  def initialize(it, &block)
    @it = it
    @block = block
  end

  def each
    @it.each {|v| yield v if accept?(v)}
  end

  def accept?(v)
    @block.call(v)
  end
end