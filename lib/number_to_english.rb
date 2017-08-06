# Input a number (integer or float) and output the english words
#
# Example
#
#   0         zero
#   123       one hundred twenty three
#   123456    one hundred twenty three thousand four hundred fifty six
#   1.56      one point five six
#
# Algorithm
#
#   1. Split whole numbers to integer (before dot) and points (after dot)
#   2. For integer
#      1. Split integers into groups with 3 chars (thousands), i.e. 1,312,100,200
#      2. Translate thousands, hundreds and join them
#   3. For points, translate each char to english word
#   4. Join integer and points

module NumberToEnglish
  NUMBER_MAPPING = [
    'zero',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen',
  ]

  TENTH_MAPPING = [
    nil,
    nil,
    'twenty',
    'thirty',
    'fourty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety',
  ]

  THOUSAND_MAPPING = [
    nil,
    'thousand',
    'million',
    'billion',
  ]

  def self.execute(number)
    integer, points = number.to_s.split('.')

    [
      _translate_integer(integer),
      _translate_points(points),
    ].compact.join(' point ')
  end

  def self._translate_integer(integer)
    integer = integer.to_i
    result = []

    return NUMBER_MAPPING[integer] if integer == 0

    thousand_idx = 0
    begin
      hundred = _translate_hundred(integer % 1000)
      hundred &&= [hundred, THOUSAND_MAPPING[thousand_idx]].compact.join(' ')

      result.unshift(hundred)

      integer = integer / 1000
      thousand_idx += 1
    end while integer > 0

    result.compact.join(' ')
  end

  def self._translate_hundred(number)
    return nil if number == 0

    hundred = number / 100
    hundred = hundred > 0 ? "#{NUMBER_MAPPING[hundred]} hundred" : nil

    [hundred, _translate_ten(number % 100)].compact.join(' ')
  end

  def self._translate_ten(number)
    if number == 0
      nil
    elsif number < 20
      NUMBER_MAPPING[number]
    else
      [
        TENTH_MAPPING[number / 10],
        (number % 10 == 0 ? nil : NUMBER_MAPPING[number % 10]),
      ].compact.join(' ')
    end
  end

  def self._translate_points(points)
    return nil if !points
    points.split('').map { |num| NUMBER_MAPPING[num.to_i] }.join(' ')
  end
end


# [
#   0,          # zero
#   1,          # one
#   8,          # eight
#   12,         # twelve
#   23,         # twenty three
#   100,        # one hundred
#   123,        # one hundred twenty three
#   1_000,      # one thousand
#   32_045,     # thirty two thousand fourty five
#   1_234_509,  # one million two hundred thirty four thousand five hundred nine
#   0.12,       # zero point one two
#   12.345,     # twelve point three four five
# ].each do |num|
#   puts "#{num.to_s.ljust(10)} #{NumberToEnglish.execute(num)}"
# end
