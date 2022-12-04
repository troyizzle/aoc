count_a = 0
count_b = 0

def split_to_array(split)
  (split[0]..split[1]).to_a
end

File.foreach('../inputs/day4.txt').each do |line|
  counted_this_round_part_a = false
  counted_this_round_part_b = false

  first_elf_sections, second_elf_sections = line.strip.split(',')
  first_elf_sections_split = first_elf_sections.split('-')
  second_elf_sections_split = second_elf_sections.split('-')
  first_elf_section_array = split_to_array(first_elf_sections_split)
  second_elf_section_array = split_to_array(second_elf_sections_split)

  counted_this_round_part_a = true if first_elf_sections_split.all? do |section|
    second_elf_section_array.include?(section)
  end

  count_a += 1 if counted_this_round_part_a
  if !counted_this_round_part_a
    count_a += 1 if second_elf_sections_split.all? do |section|
      first_elf_section_array.include?(section)
    end
  end

  counted_this_round_part_b = true if first_elf_sections_split.any? do |section|
    second_elf_section_array.include?(section)
  end

  count_b += 1 if counted_this_round_part_b
  if !counted_this_round_part_b
    count_b += 1 if second_elf_sections_split.any? do |section|
      first_elf_section_array.include?(section)
    end
  end

end

puts count_a
puts count_b
