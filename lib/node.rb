class Node
  attr_accessor :value, :left, :right, :parent

  def initialize(opts = {})
    @value = opts[:value]
    @left  = opts[:left]
    @right = opts[:right]
    @parent = opts[:parent]
  end
end
