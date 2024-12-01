file_name = ARGV[0]

left_list = []
right_list = []

File.foreach(file_name) do |line|
  left, right = line.split.map(&:to_i)
  left_list << left
  right_list << right
end

left_list.sort!
right_list.sort!

total_distance = left_list.each.with_index.reduce(0) do |sum, (left, index)|
  sum + (left - right_list[index]).abs
end

puts "part 1: #{total_distance}"

tally = right_list.tally

similarity_score = left_list.sum { |left| (tally[left] || 0) * left }

puts "part 2: #{similarity_score}"
