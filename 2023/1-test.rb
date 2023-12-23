require './1-1-input.rb'
NUMBERS_IN_WORDS = %w[zero one two three four five six seven eight nine]
NUMBER_AND_WORD_RGX = /(?=(#{NUMBERS_IN_WORDS.join("|")}|\d))/

def calculate_calibration_sum(input)
  sum = 0

  input.each_line do |line|
    numbers_and_words = line.scan(NUMBER_AND_WORD_RGX).flatten
    numbers = numbers_and_words.map do |word|
      word.match?(/\d/) ? word.to_i : NUMBERS_IN_WORDS.find_index(word)
    end
    
    calibration = numbers.empty? ? 0 : (numbers.first * 10 + numbers.last)
    sum += calibration
  end

  return sum
end

sum = calculate_calibration_sum(INPUT)
print("Result:\t#{sum}\n")