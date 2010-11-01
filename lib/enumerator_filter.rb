# replace this class with 1.9 http://www.michaelharrison.ws/weblog/?p=163
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