# Input a number (integer or float) and output the english words
# This is the 2nd version, it just use recursion.
module NumberToEnglish2
  NUMBER_MAPPING = {
    0 => 'zero',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'fourty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety',
    100 => 'hundred',
    1_000 => 'thousand',
    1_000_000 => 'million',
    1_000_000_000 => 'billion',
  }

  def self.execute(value)
    _translate_number(value)
  end

  private

  def self._translate_number(num, cu = 1)
    result = []

    if num < 1000
      case num
      when 0..20
        result << NUMBER_MAPPING[num]
      when 21..99
        quotient, modulu = num.divmod(10)
        result << NUMBER_MAPPING[quotient * 10]
        result << _translate_number(modulu) unless modulu.zero?
      else
        quotient, modulu = num.divmod(100)
        result << "#{NUMBER_MAPPING[quotient]} #{NUMBER_MAPPING[100]}"
        result << _translate_number(modulu) unless modulu.zero?
      end
      result << NUMBER_MAPPING[cu] if num > 0 && cu > 1
    else
      quotient, modulu = num.divmod(1000)
      result << _translate_number(quotient, cu * 1000) unless quotient.zero?
      result << _translate_number(modulu, cu) unless modulu.zero?
    end

    result.compact.join(' ')
  end
end


[
  0,
  1,
  7,
  9,
  10,
  11,
  14,
  19,
  20,
  23,
  30,
  58,
  99,
  100,
  101,
  123,
  999,
  1_000,
  1_001,
  9_999,
  11_222,
  1_000_000,
  1_002_001,
  2_000_001,
  111_222_333,
].each do |num|
  p "#{num.to_s.ljust(10)} #{NumberToEnglish2.execute(num)}"
end
