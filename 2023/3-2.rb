require './3-input.rb'
require 'byebug'

def get_full_number_and_add_to_visited(line, index, place, visited_places)
  # Find the start of the number
  digits = []
  start_index = index
  while start_index > 0 && line[start_index - 1].match(/\d/)
    start_index -= 1
  end

  current_index = start_index

  # Get all digits of number
  while current_index <= line.length - 1 && line[current_index].match(/\d/)
    digits << line[current_index]
    current_index += 1
  end

  end_index = current_index
  # Add to visited_places
  if [1, 2, 3].include?(place)
    range = (place - (index - start_index))..(place + (end_index - index))
    range.each { |n| visited_places << n if [1, 2, 3].include?(n) }
  elsif [4, 5].include?(place)
    visited_places << place
  elsif [6, 7, 8].include?(place)
    range = (place - (index - start_index))..(place + (end_index - index))
    range.each { |n| visited_places << n if [6, 7, 8].include?(n) } 
  end

  digits.join('').to_i
end

def gear_ratio(gear_index, line_index, input)
  adjacent_numbers = []
  visited_places = []
  # Go in a circle around the potential gear
  # Need to skip edges
  # If the char is a digit, find the rest of the digits and push to adjacent numbers array
  # Need to also mark the digits as visited so I don't double count
  # Places around gear numbered 1-8
  # 1 2 3
  # 4 * 5
  # 6 7 8

  # 1
  if line_index > 0 && 
     gear_index > 0 && 
     input[line_index - 1][gear_index - 1].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index - 1], gear_index - 1, 1, visited_places)
  end

  # 2
  if !visited_places.include?(2) &&
     line_index > 0 &&
     input[line_index - 1][gear_index].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index - 1], gear_index, 2, visited_places)
  end

  # 3
  if !visited_places.include?(3) &&
     line_index > 0 &&
     gear_index < input[0].length &&
     input[line_index - 1][gear_index + 1].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index - 1], gear_index + 1, 3, visited_places)
  end

  # 4
  if gear_index > 0 &&
     input[line_index][gear_index - 1].match(/\d/)
    
    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index], gear_index - 1, 4, visited_places)
  end

  # 5
  if gear_index < input[0].length &&
     input[line_index][gear_index + 1].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index], gear_index + 1, 5, visited_places)
  end

  # 6
  if gear_index > 0 &&
     line_index < input.length &&
     input[line_index + 1][gear_index - 1].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index + 1], gear_index - 1, 6, visited_places)
  end

  # 7
  if !visited_places.include?(7) &&
     line_index < input.length &&
     input[line_index + 1][gear_index].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index + 1], gear_index, 7, visited_places)
  end

  # 8
  if !visited_places.include?(8) &&
     line_index < input.length &&
     gear_index < input[0].length &&
     input[line_index + 1][gear_index + 1].match(/\d/)

    adjacent_numbers << get_full_number_and_add_to_visited(input[line_index + 1], gear_index + 1, 8, visited_places) 
  end

  if adjacent_numbers.length == 2
    adjacent_numbers.reduce(&:*)
  else
    false
  end
end

gear_ratios = []

input = INPUT.split("\n")
input.each_with_index do |line, line_index|
  line.split('').each_with_index do |char, char_index|
    if char == '*'
      gear_ratio = gear_ratio(char_index, line_index, input)
      gear_ratios << gear_ratio if gear_ratio
    end
  end
end

puts gear_ratios
puts gear_ratios.sum