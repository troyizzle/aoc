NEARBY = [-1, 1, 0]

def update_tail_head(tail, head)
  y_distance, x_distance = calculate_distance(head, tail)
  if nearby?(x_distance, y_distance)
    return tail
  end

  same_row = x_distance == 0
  same_column = y_distance == 0

  if same_row
    tail[:y] += movement(y_distance)
  elsif same_column
    tail[:x] += movement(x_distance)
  else
    tail[:y] += movement(y_distance)
    tail[:x] += movement(x_distance)
  end

  tail
end

def movement(distance)
  distance.positive? ? 1 : -1
end

def nearby?(x_distance, y_distance)
  return true if y_distance.zero? && NEARBY.include?(x_distance)

  return true if x_distance.zero? && NEARBY.include?(y_distance)

  return true if NEARBY.include?(x_distance) && NEARBY.include?(y_distance)

  false
end

def update_following_tails(following_tails, head)
  following_tails.each_with_index do |following_tail, index|
    new_tail = following_tail.dup
    previous_knot = index == 0 ? head : following_tails[index - 1]
    new_tail = update_tail_head(new_tail, previous_knot)

    following_tails[index] = new_tail
  end

  following_tails
end

def calculate_distance(head, tail)
  [head[:y] - tail[:y], head[:x] - tail[:x]]
end

tail = { x: 0, y: 0 }
head = { x: 0, y: 0 }
visited_positions = []
visited_9_positions = []
following_tails = (1..9).map { |_num| { x: 0, y: 0 } }

File.foreach('../inputs/day9.txt', chomp: true) do |line|
  position, count = line.split(' ')
  count = count.to_i
  i = 1

  while i <= count
    direction = %w[R L].include?(position) ? :x : :y
    move = %w[L D].include?(position) ? -1 : 1
    head[direction] += move
    tail = update_tail_head(tail, head)
    following_tails = update_following_tails(following_tails, head)
    visited_9_positions << following_tails[-1].dup unless visited_9_positions.include? following_tails[-1]
    visited_positions << tail.dup unless visited_positions.include? tail

    i += 1
  end
end

puts "part1: #{visited_positions.count}"
puts "part2: #{visited_9_positions.count}"
