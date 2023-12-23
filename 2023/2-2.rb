require './2-input.rb'
require 'byebug'

def process_game(game)
  game_hash = { red: 0, green: 0, blue: 0 }

  game.split(';').each do |sample|
    sample.split(',').each do |cube_color_count|
      count = cube_color_count.match(/\d+/)[0].to_i
      if cube_color_count.include?('red')
        game_hash[:red] = [game_hash[:red], count].max
      elsif cube_color_count.include?('green')
        game_hash[:green] = [game_hash[:green], count].max
      elsif cube_color_count.include?('blue')
        game_hash[:blue] = [game_hash[:blue], count].max
      end
    end
  end

  game_hash
end

powers = []

INPUT.each_line do |line|
  game = line.split(':')[1]

  game_hash = process_game(game)
  power = game_hash.values.reduce(&:*)
  powers << power
end
byebug
puts powers.sum