count = 0
partb_count = 0
alphabet = [*('a'..'z'), *('A'..'Z')].to_a
indexed_alphabet = alphabet.map.with_index(1) do |letter, index|
  [letter, index]
end.to_h

line_data = {}
File.foreach('../inputs/day3.txt').each_with_index do |line, index|
  first = line.slice(0, line.length / 2)
  second = line.slice(line.length / 2, line.length)
  letter_in_both = nil
  first.chars.each do |char|
    if second.include? char
      letter_in_both = char
      break
    end
  end
  line_data[index] = line.strip
  letter_in_3 = nil
  if line_data.keys.length == 3
    keys = line_data.keys
    line_data[keys[0]].chars.each do |char|
      if line_data[keys[1]].include?(char) && line_data[keys[2]].include?(char)
        letter_in_3 = char
        break
      end
    end
  end
  if letter_in_3
    partb_count += indexed_alphabet[letter_in_3]
    letter_in_3 = nil
    line_data = {}
  end
  count += indexed_alphabet[letter_in_both]
end

puts count
puts partb_count
