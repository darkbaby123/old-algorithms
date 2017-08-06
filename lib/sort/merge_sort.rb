# Use "Merge Sort" to sort an array
# See http://en.wikipedia.org/wiki/Merge_sort
#
# Example
#
#   Sort::MergeSort.merge_sort(array)
#   Sort::MergeSort.natural_merge_sort(array)
#
# Algorithm
#
#   The main point is spliting a list to smaller sorted sublists. Then merge them
#   Back to a sorted list. There're 2 ways to split sublists.
#   The 1st way is spliting to 1 element sublists (a list of element is considered sorted).
#   The 2nd way is find the natural sorted sequences.
#
#   Merge Sort:
#
#   1. Recursively split the list to sublists until the sublist length is 1
#   2. A sublist which length is 1 is considered a sorted list
#   3. Recursively Merge sorted sublists to a sorted list
#
#   Natural Merge Sort:
#
#   1. Recursively split the list to naturally sorted lists
#   2. Recursively merge naturally sorted lists to a sorted list

module Sort
  module MergeSort
    def self.merge_sort(array)
      return array if array.length <= 1
      pivot = array.length / 2
      left, right = array[0...pivot], array[pivot..-1]
      merge(merge_sort(left), merge_sort(right))
    end

    def self.natural_merge_sort(array)
      return array if array.length <= 1
      natural_run, unsorted_array = split_natural_run(array)
      merge(natural_run, natural_merge_sort(unsorted_array))
    end

    private

    def self.merge(array_1, array_2)
      result = []
      while !array_1.empty? && !array_2.empty?
        result << (array_1.first <= array_2.first ? array_1.shift : array_2.shift)
      end
      result.concat(array_1).concat(array_2)
    end

    def self.split_natural_run(array)
      return array, [] if array.length <= 1

      result, array = [], array.dup
      begin
        result << array.shift
      end while !array.empty? && result.last <= array.first

      [result, array]
    end
  end
end


array = [3, 6, 5, 1, 7, 9, 8, 4, 2]
p Sort::MergeSort.merge_sort(array)
# p Sort::MergeSort.natural_merge_sort(array)
