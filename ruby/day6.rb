File.readlines('../inputs/day6.txt').each do |line|
  part_a = 3
  while part_a <= line.length
    marker = line[part_a - 3..part_a]
    break if marker.chars.uniq.count == 4

    part_a += 1
  end

  part_b = 13
  while part_b <= line.length
    marker = line[part_b - 13..part_b]
    break if marker.chars.uniq.count == 14

    part_b += 1
  end

  puts part_a += 1
  puts part_b += 1
end
