require './greatest_digits/index'

def get_digits(array, key, offset, res=[])
  index = array.index(key)
  if index && index + offset <= array.length
    res << array[index...index+offset]
    get_digits(array[index+1..-1], key, offset, res)
  else
    return res
  end
end

def find_max_seq(str, offset)
  9.downto(1).each do |key|
    series = get_digits(str, key.to_s, offset)
    if series
      return series.map{ |x| x.to_i }.max
    end
  end
  nil
end

def max_five_sequence(num_str)
  digits = num_str.split('').uniq.sort.reverse
  digits.each {|digit|
    max_seq = num_str.scan(/#{digit}\d{4}/).max
    return max_seq if max_seq
  }
end

{
  '6446244596324843229078078305533238148243457595610064097959970315835394620044646516409032620454667308766070112535955555160680229989500286252226622539872100872302416105709434110191128704346724013992760418612378439673074054716467417303133833479989324088538347664472552686112344808481731868927372215083229647317219996118748397409846299116871832905980576751331154031067675467258052414249268786515658539784087797283254430225516738559744857839790346593677228107810250920532340599028702461521661265848139123620956668142115302563262203131058100229270243443972546177235771575901922165361396698218117762196544134632798344019281433195806240278753690956068334534221301801209699526184573081952418828691913065992595327825797361953847717570643189642012635449388378992525367348027268165242192622365685480779764783099094867745739784700078839985408192532718515628112701900401712514793903958659409788191075200221271750422613550156973413051306931226442159480989353803152189988847966942635373863348225364240926708982725484' => 99961,
  '6446244596324843229078078305533238148243457595610064097959970315835394620044646516409032620454667308766070112535955555160680229989500286252226622539872100872302416105709434110191128704346724013992760418612378439673074054716467417303133833479989324088538347664472552686112344808481731868927372215083229647317919996118748397409846299116871832905980576751331154031067675467258052414249268786515658539784087797283254430225516738559744857839790346593677228107810250920532340599028702461521661265848139123620956668142115302563262203131058100229270243443972546177235771575901922165361396698218117762196544134632798344019281433195806240278753690956068334534221301801209699526184573081952418828691913065992595327825797361953847717570643189642012635449388378992525367348027268165242192622365685480779764783099094867745739784700078839985408192532718515628112701900401712514793903958659409788191075200221271750422613550156973413051306931226442159480989353803152189988847966942635373863348225364240926708982725484' => 99961,
  '23490349857398265065498673583204589834275923759437529' => 98673,
  '999993287' => 99999,
  '10000'     => 10000,
  '3614582'   => 61458,
  '80109020'  => 80109,
  '1234567'   => 34567,
}.each_pair do |str, expected|
  # actual = GreatestDigits.execute(*args)

  actual = (0..4).reduce([]) do |re, i|
    substr = str[i..-1]
    if substr.size >= 5
      re << substr.scan(/\d{5}/).max
    end
    re
  end.max.to_i

  # actual = (0..(str.size % 5)).map { |i| str[i..-1].scan(/\d{5}/).max }.max.to_i

  # actual = max_five_sequence(str).to_i
  # actual = GreatestDigits.execute(str)

  raise "#{str}: expect #{expected} but get #{actual}" unless actual == expected
end
puts "all passed!"
