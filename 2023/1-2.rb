require './1-1-input.rb'

def word_to_num(word)
  num_words = %w(zero one two three four five six seven eight nine)
  digit = num_words.index(word) || word
  digit.to_s
end

# This method inspired by ChatGPT
def find_overlapping_matches(string, regex)
  matches = []
  offset = 0

  while match = string[offset..-1].match(regex)
    matches << match[0]
    offset += match.begin(0) + 1
  end

  matches
end

numbers = []

INPUT.each_line do |line|
  digits = find_overlapping_matches(line, /zero|one|two|three|four|five|six|seven|eight|nine|\d/)
  digits.map! { |word| word_to_num(word) }
  digits = (digits[0] + digits[-1]).to_i
  numbers << digits
end

puts numbers.sum