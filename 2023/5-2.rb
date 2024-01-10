require './5-input.rb'
require 'byebug'

lines = INPUT.split("\n")
seeds = lines.first.scan(/\d+/).map(&:to_i)
seed_ranges = []
seeds.each.with_index do |seed, index|
  if index % 2 == 0
    seed_ranges.push(seed..(seed + seeds[index + 1] - 1))
  end
end

maps = {}
current_map = nil

# Build map hash
lines.each do |line|
  if line.include?('seed-to-soil')
    maps['seed_to_soil'] = []
    current_map = maps['seed_to_soil']
  elsif line.include?('soil-to-fertilizer')
    maps['soil_to_fertilizer'] = []
    current_map = maps['soil_to_fertilizer']
  elsif line.include?('fertilizer-to-water')
    maps['fertilizer_to_water'] = []
    current_map = maps['fertilizer_to_water']
  elsif line.include?('water-to-light')
    maps['water_to_light'] = []
    current_map = maps['water_to_light']
  elsif line.include?('light-to-temperature')
    maps['light_to_temperature'] = []
    current_map = maps['light_to_temperature']
  elsif line.include?('temperature-to-humidity')
    maps['temperature_to_humidity'] = []
    current_map = maps['temperature_to_humidity']
  elsif line.include?('humidity-to-location')
    maps['humidity_to_location'] = []
    current_map = maps['humidity_to_location']
  elsif current_map && line.match(/\d+/)
    # numbers = [destination_range_start, source_range_start, range_length]
    # Switching around range and offset so I can run backwards from location to seed
    numbers = line.scan(/\d+/).map(&:to_i)
    range = numbers[0]..(numbers[0] + numbers[2] - 1)
    offset = numbers[1] - numbers[0]
    current_map.push({ range: range, offset: offset })
  end
end


location = 0
location_found = false
while true do

  humidity = nil
  maps['humidity_to_location'].each do |map|
    if map[:range].include?(location)
      humidity = location + map[:offset]
    end
  end

  if humidity == nil
    humidity = location
  end

  temperature = nil
  maps['temperature_to_humidity'].each do |map|
    if map[:range].include?(humidity)
      temperature = humidity + map[:offset]
    end
  end

  if temperature == nil
    temperature = humidity
  end

  light = nil
  maps['light_to_temperature'].each do |map|
    if map[:range].include?(temperature)
      light = temperature + map[:offset]
    end
  end

  if light == nil
    light = temperature
  end


  water = nil
  maps['water_to_light'].each do |map|
    if map[:range].include?(light)
      water = light + map[:offset]
    end
  end

  if water == nil
    water = light
  end

  fertilizer = nil
  maps['fertilizer_to_water'].each do |map|
    if map[:range].include?(water)
      fertilizer = water + map[:offset]
    end
  end

  if fertilizer == nil
    fertilizer = water
  end

  soil = nil
  maps['soil_to_fertilizer'].each do |map|
    if map[:range].include?(fertilizer)
      soil = fertilizer + map[:offset]
    end
  end

  if soil == nil
    soil = fertilizer
  end

  seed = nil
  maps['seed_to_soil'].each do |map|
    if map[:range].include?(soil)
      seed = soil + map[:offset]
    end
  end

  if seed == nil
    seed = soil
  end

  if location % 100_000 == 0
    puts "Checking location #{location}"
  end

  seed_ranges.each do |range|
    if range.include?(seed)
      puts "The location is #{location}"
      location_found = true
    end
  end

  break if location_found
  location += 1
end