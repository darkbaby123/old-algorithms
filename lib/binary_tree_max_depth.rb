# Given a tree, find it's maximum depth
#
# There're two ways to achieve this. The 1st way uses recursion, the second way uses level order traversal.

require './lib/node'

module BinaryTreeMaxDepth
  # Recursion way
  def self.execute_1(node)
    _find_max_depth(node)
  end

  # Iteration way
  def self.execute_2(node)
    return 0 unless node

    max_depth = 0
    level_order(node) { |n, depth| max_depth = depth }
    max_depth
  end

  private

  def self._find_max_depth(node)
    return 0 unless node
    left_depth = _find_max_depth(node.left)
    right_depth = _find_max_depth(node.right)
    [left_depth, right_depth].max + 1
  end

  def self.level_order(node)
    return unless node

    max_depth = 0
    queue = [max_depth, node]

    loop do
      break if queue.empty?

      n = queue.shift

      if n.is_a?(Integer)
        unless queue.empty?
          max_depth = n + 1
          queue << max_depth
        end
      else
        yield(n, max_depth) if block_given?
        queue << n.left if n.left
        queue << n.right if n.right
      end
    end
  end
end


node = Node.new(
  value: 'A',
  left: Node.new(
    value: 'B',
    left: Node.new(
      value: 'D'
    ),
    right: Node.new(
      value: 'E'
    )
  ),
  right: Node.new(
    value: 'C',
    left: Node.new(
      value: 'F'
    ),
    right: Node.new(
      value: 'G'
    )
  )
)
