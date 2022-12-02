elf_calorie_counts = {}
current_elf_index = 0

File.foreach('../inputs/day1.txt').each do |line|
  current_elf_index += 1 if line.strip.empty?
  elf_calorie_counts[current_elf_index] ||= 0
  elf_calorie_counts[current_elf_index] += line.to_i
end

results = elf_calorie_counts.sort_by(&:last).reverse
puts "day1_a: #{results[0][1]}"
puts "day1_b: #{(0..2).sum { |num| results[num][1] }}"
