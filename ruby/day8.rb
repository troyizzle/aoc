data = File.readlines('../inputs/day8.txt', chomp: true)
data = data.map { |d| d.split('').map(&:to_i) }

def visible_tree?(tree, blocking_trees)
  blocking_trees.each do |trees_between|
    return true if trees_between.all? { |t| tree > t }
  end

  false
end

def calculcate_scenic_score(tree, blocking_trees)
  trees_seen = []
  blocking_trees.each do |trees|
    count = 0
    trees.each do |t|
      if tree <= t
        count += 1
        break
      elsif tree > t
        count += 1
      end
    end
    trees_seen << count
  end

  trees_seen.inject(&:*)
end

visible_trees_positions = 0
highest_scenic_score = 0

data.each_with_index do |rows, row_index|
  scenic_score = 0
  if row_index.zero?
    visible_trees_positions += rows.length
    next
  end

  rows.each_with_index do |tree, index|
    if index.zero? || index == rows.length - 1
      visible_trees_positions += 1
      next
    end

    top = (0..row_index - 1).map { |d| data[d][index] }
    down = (row_index + 1..rows.length - 1).map { |d| data[d][index] }
    left = rows[0..index - 1]
    right = rows[index + 1..]

    visible_tree = visible_tree?(tree, [top, left, down, right])
    visible_trees_positions += 1 if visible_tree
    scenic_score = calculcate_scenic_score(tree, [top.reverse, left.reverse, down, right])
    highest_scenic_score = scenic_score if scenic_score > highest_scenic_score
  end
end

puts visible_trees_positions
puts highest_scenic_score
