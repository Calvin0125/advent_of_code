require './1-1-input.rb'

numbers = []
INPUT.each_line do |line|
  digits = line.scan(/\d/)
  digits = (digits[0] + digits[-1]).to_i
  numbers << digits
end

puts numbers.sum
