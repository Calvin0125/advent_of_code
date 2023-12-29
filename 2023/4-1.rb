require './4-input.rb'
require 'byebug'

def calculate_points(line)
  winning_numbers = line.split('|')[0].split(':')[1].scan(/\d+/).map(&:to_i)
  my_numbers = line.split('|')[1].scan(/\d+/).map(&:to_i)
  points = 0

  winning_numbers.each do |n|
    if my_numbers.include?(n)
      if points == 0
        points = 1
      else
        points *= 2
      end
    end
  end

  points
end

points = []

INPUT.each_line do |line|
  points.push(calculate_points(line))
end

puts points.sum