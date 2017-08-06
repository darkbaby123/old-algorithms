class GraphNode
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = {}
  end
end


module CloneGraph
  # Given there is a graph
  # When passing a node to "clone"
  # Then it clones the graph and returns the cloned node
  def self.clone(node, visited_nodes = {})
    cloned_node = GraphNode.new(node.value)
    visited_nodes[node] = cloned_node

    node.neighbors.each_pair do |key, n|
      cloned_node.neighbors[key] = visited_nodes[n] || clone(n, visited_nodes)
    end

    cloned_node
  end

  # Clone the graph with loop and queue
  def self.clone_with_levelorder(node)
    visited_nodes = {}
    queue = [node]

    while !queue.empty?
      n = queue.shift
      cn = (visited_nodes[n] ||= GraphNode.new(n.value))

      n.neighbors.each_pair do |key, neighbor|
        cloned_neighbor = visited_nodes[neighbor]

        unless cloned_neighbor
          visited_nodes[neighbor] = cloned_neighbor = GraphNode.new(neighbor.value)
          queue.push neighbor
        end

        cn.neighbors[key] = cloned_neighbor
      end
    end

    visited_nodes[node]
  end
end


a = GraphNode.new('A')
b = GraphNode.new('B')
c = GraphNode.new('C')
d = GraphNode.new('D')

a.neighbors = {'B' => b, 'C' => c}
b.neighbors = {'A' => a, 'D' => d}
c.neighbors = {'A' => a, 'D' => d}
d.neighbors = {'B' => b, 'C' => c}

a1 = CloneGraph.clone_with_levelorder(a)
p a1.neighbors.keys
