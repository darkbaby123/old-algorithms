# Longest substring without repeating characters
#
# Tests
#
#   ""         => ""
#   "a"        => "a"
#   "abcdcefg" => "dcefg"
#   "abcabcbb" => "abc"
#   "bbbbb"    => "b"
#
module LongestSubstring
  def self.longest_substring(str)
    substrs = _find_non_repeated_substrings(str)

    if substrs
      substrs.max { |i, j| i.length <=> j.length }
    else
      nil
    end
  end

  def self._find_non_repeated_substrings(str)
    return nil if !str
    return [str] if str.length <= 1

    substring = ""
    repeated_start_idx = nil

    str.each_char do |char|
      repeated_start_idx = substring.index(char)

      if repeated_start_idx
        break
      else
        substring << char
      end
    end

    if repeated_start_idx
      [substring].concat _find_non_repeated_substrings(str[(repeated_start_idx+1)..-1])
    else
      [substring]
    end
  end
end
