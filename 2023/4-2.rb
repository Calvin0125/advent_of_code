require './4-input.rb'
require 'byebug'

def add_to_copies(line, card_number, copies)
  if !copies[card_number]
    copies[card_number] = 1
  else
    copies[card_number] += 1
  end

  winning_numbers = line.split('|')[0].split(':')[1].scan(/\d+/).map(&:to_i)
  my_numbers = line.split('|')[1].scan(/\d+/).map(&:to_i)
  matching_numbers = 0
  winning_numbers.each do |n|
    if my_numbers.include?(n)
      matching_numbers += 1
    end
  end

  if matching_numbers > 0
    range = (card_number + 1)..(card_number + matching_numbers)
    range.each do |n|
      if !copies[n]
        copies[n] = copies[card_number]
      else
        copies[n] += copies[card_number]
      end
    end
  end
end

copies = []
INPUT.each_line.with_index do |line, index|
 add_to_copies(line, index, copies)
end

puts copies.sum