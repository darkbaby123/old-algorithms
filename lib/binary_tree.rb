module BinaryTree
  def self.data_to_tree(data, parent = nil)
    node = nil

    if data.is_a?(Hash)
      node = Node.new(data.keys.first)
      node.parent = parent

      children = data[data.keys.first]
      if children
        node.left = data_to_tree(children.first, node) if children.first
        node.right = data_to_tree(children.last, node) if children.last
      end
    else
      node = Node.new(data)
      node.parent = parent
    end

    node
  end

  def self.find_node(node, value)
    return nil unless node

    if node.value == value
      node
    else
      find_node(node.left, value) || find_node(node.right, value)
    end
  end

  def self.draw_path(node)
    return [] unless node

    array = []
    array << node.value
    node.parent

    array.concat draw_path(node.parent) if node.parent

    array
  end

  def self.lowest_common_ancestor(node, value_1, value_2)
    result = draw_path(find_node(node, value_1)) & draw_path(find_node(node, value_2))
    result.empty? ? nil : result.first
  end

  def self.level_order(node)
    return [] unless node

    array = []
    queue = []

    queue << node

    loop do
      break if queue.empty?

      n = queue.shift
      if n
        array << n.value
        queue << n.left if n.left
        queue << n.right if n.right
      end
    end

    array
  end

  def self.prefix_traversal(node)
    return [] unless node

    array = []

    array << node.value
    array.concat prefix_traversal(node.left)
    array.concat prefix_traversal(node.right)

    array
  end

  def self.infix_traversal(node)
    return [] unless node

    array = []

    array.concat infix_traversal(node.left)
    array << node.value
    array.concat infix_traversal(node.right)

    array
  end

  def self.postfix_traversal(node)
    return [] unless node

    array = []

    array.concat postfix_traversal(node.left)
    array.concat postfix_traversal(node.right)
    array << node.value

    array
  end

  def self.postfix_notation_to_tree(expression_tokens)
    expression_tokens = expression_tokens.dup
    stack = []

    loop do
      break if expression_tokens.empty?

      token = expression_tokens.shift
      node = Node.new(token)

      case token
      when *%w[+ - * /]
        node.right = stack.pop
        node.left = stack.pop
      end

      stack.push node
    end

    unless stack.size == 1
      raise "wrong postfix expression"
    end

    stack.first
  end

  # Identify if the tree is a binary search tree
end



# Preorder: ["A", "B", "D", "E", "C", "F", "G"]
# In order: ["D", "B", "E", "A", "F", "C", "G"]

def build_tree(preorder, inorder)
  return nil if preorder.empty? && inorder.empty?

  array = []

  node = Node.new(preorder.first)

  array << preorder.first

  idx = inorder.index(preorder.first)

  left_inorder = inorder[0...idx]
  right_inorder = inorder[(idx+1)..-1]

  left_preorder = preorder & left_inorder
  right_preorder = preorder & right_inorder

  node.left = build_tree(left_preorder, left_inorder)
  node.right = build_tree(right_preorder, right_inorder)

  node
end


# data = {'+' => [{'*' => [{'+' => ['a', 'b']}, 'c']}, '7']}
# node = BinaryTree.data_to_tree(data)


# "(a + b) * (c - d)" to tree
# node = BinaryTree.postfix_notation_to_tree(%w[a b + c d - *])
# p BinaryTree.postfix_traversal(node)


# node = build_tree ["A", "B", "D", "E", "C", "F", "G"], ["D", "B", "E", "A", "F", "C", "G"]

# node = find_node(node, 'F')

# draw_path(node)
