require './2-input.rb'

RED_LIMIT = 12
GREEN_LIMIT = 13
BLUE_LIMIT = 14

def invalid_sample(sample)
  sample_hash = process_sample(sample)

  sample_hash[:red] > RED_LIMIT || 
  sample_hash[:green] > GREEN_LIMIT || 
  sample_hash[:blue] > BLUE_LIMIT
end

def process_sample(sample)
  sample_hash = { red: 0, green: 0, blue: 0 }

  sample.split(',').each do |cube_color_count|
    count = cube_color_count.match(/\d+/)[0].to_i
    if cube_color_count.include?('red')
      sample_hash[:red] = count
    elsif cube_color_count.include?('green')
      sample_hash[:green] = count
    elsif cube_color_count.include?('blue')
      sample_hash[:blue] = count
    end
  end

  sample_hash
end

ids = []

INPUT.each_line do |line|
  valid = true
  id = line.match(/\d+/)[0].to_i
  samples = line.split(':')[1].split(';')

  samples.each do |sample|
    if invalid_sample(sample)
      valid = false
    end
  end

  ids << id if valid
end

puts ids.sum