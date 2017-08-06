# Given an array, print each element with spiral order
# Note each element should be a single character. It's for simplify space calculation.
# Call this function in console to see the effect.
module SpiralNumber
  def self.execute(ary, row_length = 10)
    l_space_count, r_space_count, side = 0, nil, :left_to_right

    ary.each do |el|
      r_space_count = row_length - 1 - l_space_count

      puts "#{' ' * l_space_count}#{el}#{' ' * r_space_count}"

      if l_space_count == 0
        side = :left_to_right
      elsif l_space_count == row_length - 1
        side = :right_to_left
      end

      l_space_count += (side == :left_to_right) ? 1 : -1
    end
  end
end

# SpiralNumber.execute(('a'..'z').to_a * 3)
