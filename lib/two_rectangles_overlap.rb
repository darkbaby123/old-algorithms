# Given two rectangles with their x axis and y axis
# Check if they have overlap
#
#   +-----------+
#   |           |
#   |    +-------------+
#   |    |      |      |
#   +----|------+      |
#        |             |
#        +-------------+
#
module TwoRectanglesOverlap
  def self.execute(a, b)
    # Think in opposite way, how can 2 rectangles NOT overlap? then reverse the condition
    a.x2 >= b.x1 && a.x1 <= b.x2 && a.y2 >= b.y1 && a.y1 <= b.y2
  end
end

class Rect
  attr_accessor :x1, :x2, :y1, :y2
end
