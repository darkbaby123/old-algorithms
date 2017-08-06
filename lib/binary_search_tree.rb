module BinarySearchTree
  def self.is_bst?(node)
    _is_bst?(node, nil, nil)
  end

  def self._is_bst?(node, min, max)
    return true if !node

    return false if (min && node.value < min) || (max && node.value > max)

    _is_bst?(node.left, min, node.value) && _is_bst?(node.right, node.value, max)
  end

  def self.search_with_recursion(node, value)
    return false unless node

    if node.value == value
      true
    elsif node.value < value
      search_with_recursion(node.right, value)
    else
      search_with_recursion(node.left, value)
    end
  end

  def self.search_with_iteration(node, value)
    while node
      if node.value == value
        return true
      elsif node.value < value
        node = node.right
      else
        node = node.left
      end
    end

    false
  end

  # Insert a value to a tree, returns the new generated node
  def self.insert(node, value)
    return Node.new(value) unless node

    if value == node.value
      raise "The value '#{value}' exists in binary search tree!"
    elsif value < node.value
      if node.left
        insert(node.left, value)
      else
        return node.left = Node.new(value)
      end
    else
      if node.right
        insert(node.right, value)
      else
        return node.right = Node.new(value)
      end
    end
  end

  # Delete a value to a tree
  #
  # Algorithm:
  # 1. when deleting a leaf, simply delete it
  # 2. when deleting a node with one child, delete and replace it with it's child
  # 3. when deleting a node with two chidren
  #    1. find the in-order successor of the node, it's the right sub-tree's
  #       left-most child (with minimum value)
  #    2. replace node's value with successor's value
  #    3. delete the successor with same algorithm
  #
  # For detail see this link: http://en.wikipedia.org/wiki/Binary_search_tree#Deletion
  #
  def self.delete(node, value)
    _delete(node, nil, value)
  end

  def self._delete(node, parent, value)
    return false unless node

    if value < node.value
      _delete(node.left, node, value)
    elsif value > node.value
      _delete(node.right, node, value)
    else
      if node.left && node.right
        successor, successor_parent = _find_min_in_right_subtree(node)
        node.value = successor.value
        _delete(successor, successor_parent, successor.value)
      elsif node.left
        _replace_node_in_parent(node, parent, node.left)
        true
      elsif node.right
        _replace_node_in_parent(node, parent, node.right)
        true
      else
        _replace_node_in_parent(node, parent, nil)
        true
      end
    end
  end

  def self._replace_node_in_parent(node, parent, new_node)
    if parent
      if parent.left == node
        parent.left = new_node
      else
        parent.right = new_node
      end
    end

    node.left = nil
    node.right = nil
    node.value = nil
  end

  def self._find_min_in_right_subtree(node)
    sub_node = node.right
    parent = node

    if !sub_node.left && !sub_node.right
      return [sub_node, parent]
    end

    loop do
      if sub_node.left
        parent = sub_node
        sub_node = sub_node.left
      else
        break
      end
    end

    [sub_node, parent]
  end
end
