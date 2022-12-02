GAME_OPTIONS = {
  'rock' => {
    beats: 'scissors', points: 1, values: %w[A X]
  },
  'paper' => {
    beats: 'rock', points: 2, values: %w[B Y]
  },
  'scissors' => {
    beats: 'paper', points: 3, values: %w[C Z]
  }
}

def find_player_choice(choice)
  GAME_OPTIONS.keys.find do |key|
    key if GAME_OPTIONS[key][:values].include? choice
  end
end

def game_results(my_choice, opponent_choice)
  return 'draw' if my_choice == opponent_choice
  return 'win' if GAME_OPTIONS[my_choice][:beats] == opponent_choice

  'lost'
end

def add_points(results, player_points)
  return player_points if results == 'lost'

  points = { 'win' => 6, 'draw' => 3 }
  player_points += points[results]
  player_points
end

def find_chosen_outcome(value)
  outcomes = { 'X' => 'lost', 'Y' => 'draw', 'Z' => 'win' }

  outcomes[value]
end

def find_move_that_would_equal_chosen_outcome(chosen_outcome, opponent_choice)
  GAME_OPTIONS.keys.find do |key|
    key if game_results(key, opponent_choice) == chosen_outcome
  end
end

player_points = 0
chosen_outcome_points = 0

File.foreach('../inputs/day2.txt').each do |line|
  opponent_choice = find_player_choice(line[0])
  chosen_outcome = find_chosen_outcome(line[2])
  my_choice = find_player_choice(line[2])
  chosen_choice = find_move_that_would_equal_chosen_outcome(chosen_outcome, opponent_choice)
  player_points += GAME_OPTIONS[my_choice][:points]
  chosen_outcome_points += GAME_OPTIONS[chosen_choice][:points]
  chosen_outcome_points = add_points(chosen_outcome, chosen_outcome_points)
  game_result = game_results(my_choice, opponent_choice)
  player_points = add_points(game_result, player_points)
end

puts "part1: #{player_points}"
puts "part2: #{chosen_outcome_points}"
