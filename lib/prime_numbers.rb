# Find all prime numbers up to a specific integer n
#
# Algorithm
#
#   using Sieve of Eratosthenes, see http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
module PrimeNumbers
  def self.execute(max_num)
    # Record prime number to true. e.g. {2 => true, 3 => true, 4 => false, ...}
    hash = {}

    (2..max_num).each do |num|
      next if hash[num] == false

      hash[num] = true

      multi_count, non_prime_num = 2, nil
      loop do
        non_prime_num = num * multi_count
        break if non_prime_num > max_num
        hash[non_prime_num] = false
        multi_count += 1
      end
    end

    hash.each_pair.reduce([]) { |re, pair| pair[1] ? re << pair[0] : re }
  end
end

# p PrimeNumbers.execute(120)
