require 'benchmark'
require './greatest_digits/index'

num_str = "6446244596324843229078078305533238148243457595610064097959970315835394620044646516409032620454667308766070112535955555160680229989500286252226622539872100872302416105709434110191128704346724013992760418612378439673074054716467417303133833479989324088538347664472552686112344808481731868927372215083229647317219996118748397409846299116871832905980576751331154031067675467258052414249268786515658539784087797283254430225516738559744857839790346593677228107810250920532340599028702461521661265848139123620956668142115302563262203131058100229270243443972546177235771575901922165361396698218117762196544134632798344019281433195806240278753690956068334534221301801209699526184573081952418828691913065992595327825797361953847717570643189642012635449388378992525367348027268165242192622365685480779764783099094867745739784700078839985408192532718515628112701900401712514793903958659409788191075200221271750422613550156973413051306931226442159480989353803152189988847966942635373863348225364240926708982725484"
# num_str = '99999' + 995.times.map { rand(10) }.join

def s_1(num_str)
  digits = num_str.split('').uniq.sort.reverse
  digits.each { |digit|
    max_seq = num_str.scan(/#{digit}\d{4}/).max
    return max_seq if max_seq
  }
end

def s_27_1(digits)
  digits.split('').each_cons(5).max.join.to_i
end

def s_27_3(digits)
  digits.each_char.with_index.inject([]) { |arr, (str, index)| arr << digits[index, 5].length }.max
end

def s_31_1(str)
  max = "00000"
  0.upto(str.length-5) do |i|
    num = str[i..i+4]
    max = num if num > max
  end
  return max.to_i
end
def next_biggest_digit(str, offset, max_offset)
  digit = str[offset]
  while offset <= max_offset && digit > str[offset+1]
    offset += 1
  end
  return offset + 1
end
def s_31_2(str)
  i = 0
  max = str[0..4]
  while i < str.length - 5
    i = next_biggest_digit(str, i, str.length - 5)
    max = str[i..i+4] if str[i..i+4] > max
  end
  return max.to_i
end

def s_38(str)
  (0..(str.size % 5)).map { |i| str[i, str.size].scan(/\d{5}/).max }.max.to_i
end


def s_6_get_digits(array, key, offset, res=[])
  index = array.index(key)
  if index && index + offset <= array.length
    res << array[index...index+offset]
    s_6_get_digits(array[index+1..-1], key, offset, res)
  else
    return res
  end
end
def s_6(str, offset)
  9.downto(1).each do |key|
    series = s_6_get_digits(str, key.to_s, offset)
    if series
      return series.map{ |x| x.to_i }.max
    end
  end
  nil
end


def s_17(digits, length = 5, prefix = '')
  return prefix.to_i if length == 0

  9.downto(0) do |i|
    n = prefix + i.to_s
    position = digits.index(n)
    if position && (position + length + 1) <= digits.length
      return s_17(digits, length-1, n)
    end
  end
end


def s_22_get_digits(array, key, offset, res=[])
  index = array.index(key)
  if index && index + offset <= array.length
    res << array[index...index+offset]
    s_22_get_digits(array[index+1..-1], key, offset, res)
  else
    return res
  end
end

def s_22(str, offset)
  (1..9).to_a.reverse.each do |key|
    series = s_22_get_digits(str, key.to_s, offset)
    if series
      return series.map{ |x| x.to_i }.max
    end
  end
  nil
end

def mine_2(str)
  (0..4).reduce([]) { |re, i|
    substr = str[i..-1]
    re << substr.scan(/\d{5}/).max if substr.size >= 5
    re
  }.max.to_i
end

def tom(str)
  (0..4).map { |i| str[i, str.size].scan(/\d{5}/).concat(['10000']).max }.max.to_i
end

Benchmark.bm do |bm|
  bm.report("mine".ljust(10))   { 10000.times { GreatestDigits.execute(num_str) } }

  # bm.report("s_27_1".ljust(10)) { 10000.times { s_27_1(num_str) } }
  # bm.report("s_27_3".ljust(10)) { 10000.times { s_27_3(num_str) } }
  # bm.report("s_31_1".ljust(10)) { 10000.times { s_31_1(num_str) } }
  # bm.report("s_31_2".ljust(10)) { 10000.times { s_31_2(num_str) } }

  # bm.report("s_1".ljust(10)) { 10000.times { s_1(num_str) } }
  # bm.report("s_38".ljust(10)) { 10000.times { s_38(num_str) } }

  bm.report("mine_2".ljust(10)) { 10000.times { mine_2(num_str) } }
  bm.report("tom".ljust(10)) { 10000.times { tom(num_str) } }

  # wrong
  # bm.report("s_6".ljust(10)) { 10000.times { s_6(num_str, 5) } }

  # wrong
  # bm.report("s_17".ljust(10)) { 10000.times { s_17(num_str, 5) } }

  # wrong
  # bm.report("s_22".ljust(10)) { 10000.times { s_22(num_str, 5) } }
end
