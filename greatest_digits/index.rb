module GreatestDigits
  def self.execute(str, n = 5)
    max_possible = '9' * n

    expected_start_idx, expected_start_char, expected = set_expected(str, 0, n, max_possible)

    idx = 1
    while idx <= str.size - n
      case expected_start_char <=> str[idx]
      when -1
        expected_start_idx, expected_start_char, expected = set_expected(str, idx, n, max_possible)
      when 0
        if expected < str[idx, n]
          expected_start_idx, expected_start_char, expected = set_expected(str, idx, n, max_possible)
        end
      end
      idx += 1
    end

    expected.to_i
  rescue IsMaxDigitsError
    max_possible.to_i
  end

  def self.set_expected(str, idx, n, max_possible)
    expected = str[idx, n]
    raise IsMaxDigitsError if expected == max_possible
    [idx, str[idx], expected]
  end

  class IsMaxDigitsError < StandardError; end
end
