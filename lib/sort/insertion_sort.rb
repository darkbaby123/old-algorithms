module Sort
  module InsertionSort
    def self.execute(array)
      result = []

      array.each do |el|
        if result.empty?
          result << el
          next
        end

        (result.length-1).downto 0 do |idx|
          if el >= result[idx]
            result.insert(idx + 1, el)
            break
          elsif idx == 0
            result.insert(0, el)
          end
        end
      end

      result
    end
  end
end

p Sort::InsertionSort.execute([])
