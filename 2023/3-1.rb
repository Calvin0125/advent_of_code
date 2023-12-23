require './3-input.rb'
require 'byebug'

current_digit = ''
current_digit_indices = []
adjacent_digits = []

def is_adjacent?(current_digit_indices, line_index, input)
  current_digit_indices.each do |index|
    if (index > 0 && is_symbol?(input[line_index][index - 1])) || # left
      (index < input[line_index].length - 1 && is_symbol?(input[line_index][index + 1])) || # right
      (line_index > 0 && is_symbol?(input[line_index - 1][index])) || # up
      (line_index > 0 && is_symbol?(input[line_index - 1][index - 1])) || # up left
      (line_index > 0 && is_symbol?(input[line_index - 1][index + 1])) || # up right
      (line_index < input.length - 1 && is_symbol?(input[line_index + 1][index])) || # down
      (line_index < input.length - 1 && is_symbol?(input[line_index + 1][index - 1])) || # down left
      (line_index < input.length - 1 && is_symbol?(input[line_index + 1][index + 1])) # down right
      return true
    end
  end
  false
end

def is_symbol?(char)
  char && char != '.' && !char.match(/\d/)
end

input = INPUT.split("\n")
input.each_with_index do |line, line_index|
  line.split('').each_with_index do |char, char_index|
    if char.match(/\d/)
      current_digit += char
      current_digit_indices << char_index
    end

    if current_digit != '' && (!char.match(/\d/) || char_index == line.length - 1)
      adjacent_digits << current_digit.to_i if is_adjacent?(current_digit_indices, line_index, input)
      current_digit = ''
      current_digit_indices = []
    end
  end
end

puts adjacent_digits.sum