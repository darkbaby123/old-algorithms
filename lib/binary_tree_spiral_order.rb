# Read a tree in spiral order
#
# Example
#
#      1
#    2   3
#   7 6 5 4
#
#   Above tree outputs 1 2 3 4 5 6 7
#
# Algorithm 1
#
#   Use a queue and a stack. We know that level order can be achieved by queue.
#   When reading one level, we push the next level into the queue.
#   The spiral order just need us to read next level in reverse order.
#   Something like "reverse input and output" can be done by stack.
#
#   1. Read one level from a queue
#   2. Print this level and push next level into stack
#   3. When the queue is empty (level clear), pop next level from stack and push into the queue
#   4. Repeat step 1
#
# Algorithm 2
#
#   Use two stacks. It has similar concept as algorithm 1 and is the original solution I've seen.
#   The keypoint is read one level from 1st stack and push next level to 2nd stack,
#   when the 1st stack is empty, swap to 2nd stack and do the same thing.

require './lib/node'

module BinaryTreeSpiralOrder
  # Use a queue and a stack
  def self.execute_1(root)
    ltf, queue, stack = false, [root], []

    while !queue.empty? || !stack.empty?
      while !queue.empty?
        node = queue.shift
        print "#{node.value} "

        children = ltf ? [node.left, node.right] : [node.right, node.left]
        children.each { |child| stack << child if child }
      end

      ltf = !ltf
      queue << stack.pop while !stack.empty?
    end

    puts
  end

  # Use two stack
  def self.execute_2(root)
    ltf = false

    s1, s2 = [], []
    s1 << root

    while !s1.empty? || !s2.empty?
      while !s1.empty?
        node = s1.pop
        print "#{node.value} "

        if ltf
          s2 << node.left if node.left
          s2 << node.right if node.right
        else
          s2 << node.right if node.right
          s2 << node.left if node.left
        end
      end

      ltf = !ltf

      while !s2.empty?
        node = s2.pop
        print "#{node.value} "

        if ltf
          s1 << node.left if node.left
          s1 << node.right if node.right
        else
          s1 << node.right if node.right
          s1 << node.left if node.left
        end
      end

      ltf = !ltf
    end

    puts
  end

end

node = Node.new(
  value: 1,
  left: Node.new(
    value: 2,
    left: Node.new(
      value: 7,
      left: Node.new(
        value: 8
      ),
      right: Node.new(
        value: 9
      )
    ),
    right: Node.new(
      value: 6
    )
  ),
  right: Node.new(
    value: 3,
    left: Node.new(
      value: 5
    ),
    right: Node.new(
      value: 4
    )
  )
)

BinaryTreeSpiralOrder.execute_1(node)
