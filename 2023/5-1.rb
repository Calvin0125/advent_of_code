require './5-input.rb'
require 'byebug'

lines = INPUT.split("\n")
seeds = lines.first.scan(/\d+/).map(&:to_i)
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
    numbers = line.scan(/\d+/).map(&:to_i)
    range = numbers[1]..(numbers[1] + numbers[2] - 1)
    offset = numbers[0] - numbers[1]
    current_map.push({ range: range, offset: offset })
  end
end

locations = []

seeds.each do |seed|
  soil = nil
  maps['seed_to_soil'].each do |map|
    if map[:range].include?(seed)
      soil = seed + map[:offset]
    end
  end

  if soil == nil
    soil = seed
  end

  fertilizer = nil
  maps['soil_to_fertilizer'].each do |map|
    if map[:range].include?(soil)
      fertilizer = soil + map[:offset]
    end
  end

  if fertilizer == nil
    fertilizer = soil
  end

  water = nil
  maps['fertilizer_to_water'].each do |map|
    if map[:range].include?(fertilizer)
      water = fertilizer + map[:offset]
    end
  end

  if water == nil
    water = fertilizer
  end

  light = nil
  maps['water_to_light'].each do |map|
    if map[:range].include?(water)
      light = water + map[:offset]
    end
  end

  if light == nil
    light = water
  end

  temperature = nil
  maps['light_to_temperature'].each do |map|
    if map[:range].include?(light)
      temperature = light + map[:offset]
    end
  end

  if temperature == nil
    temperature = light
  end

  humidity = nil
  maps['temperature_to_humidity'].each do |map|
    if map[:range].include?(temperature)
      humidity = temperature + map[:offset]
    end
  end

  if humidity == nil
    humidity = temperature
  end

  location = nil
  maps['humidity_to_location'].each do |map|
    if map[:range].include?(humidity)
      location = humidity + map[:offset]
    end
  end

  if location == nil
    location = humidity
  end

  locations << location
end

puts locations.min