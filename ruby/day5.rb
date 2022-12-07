crate_position = {}
# TODO: This is terrible

File.foreach('../inputs/day5.txt', chomp: false).each do |line|
  if line.start_with?('move')
    crate_position.each_key do |key|
      crate_position[key] = crate_position[key].reject { |v| v.strip.empty? }
    end

    crate, from, to = line.scan(/move (\d+) from (\d+) to (\d+)/).flatten.map(&:to_i)
    crate_position[to].insert(0, crate_position[from][(0..crate - 1)])
    crate_position.each_key do |key|
      crate_position[key] = crate_position[key].flatten
    end
    i = 1
    while i <= crate
      puts i
      puts crate_position[from]
      crate_position[from].delete_at(0)
      i += 1
    end
    # for _i in (1..crate) do
     # crate_position[to].insert(0, crate_position[from][0])
     # crate_position[from].delete_at(0)
    # end
  elsif line.start_with?(' 1')
    next
  else
    i = 0
    parsed = {}
    while i < line.length
      parsed[i] = line[i..i+4]
      i += 4
    end
    puts parsed
    parsed.keys.each_with_index do |key, index|
      index = index + 1
      char = parsed[key].scan(/\w/)
      char = char.empty? ? " " : char[0]
      if crate_position[index]
        crate_position[index] << char[0]
      else
        crate_position[index] = [char[0]]
      end
    end
  end
end

puts crate_position.keys.map { |key| crate_position[key][0] }.join('')
