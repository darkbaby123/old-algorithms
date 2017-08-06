module Sort
  module Quicksort
    def self.execute(array)
      quicksort(array)
    end

    private

    def self.quicksort(array)
      return array.dup if !array || array.empty? || array.length == 1

      pivot_idx = array.length / 2
      pivot = array[pivot_idx]

      left, right = [], []
      array.each_with_index do |el, idx|
        (el <= pivot ? left : right) << el unless idx == pivot_idx
      end

      quicksort(left).concat([pivot]).concat(quicksort(right))
    end
  end
end


p Sort::Quicksort.execute([3, 7, 8, 5, 2, 1, 9, 5, 4])
