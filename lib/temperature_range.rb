# Given a low temperature, a high temperature, and a step,
# print all of the temperatures between the range.
module TemperatureRange
  def self.execute(low_tmp, high_tmp, step = 1)
    result = []

    tmp = low_tmp
    begin
      result << tmp
      tmp += step
    end while tmp <= high_tmp

    result
  end
end


# [
#   [10, 20, 4],    # [10, 14, 18]
#   [10, 20, 5],    # [10, 15, 20]
#   [10, 11, 3],    # [10]
#   [10, 15, 1],    # [10, 11, 12, 13, 14, 15]
# ].each do |args|
#   p TemperatureRange.execute(*args)
# end


# [-1, -2, 1, 2, -3, -4] => [1, 2]
# [-1, -2, -3] => [-1]
