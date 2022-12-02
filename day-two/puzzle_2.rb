require 'pry'

################ Getting the data ##########################
@file = File.read('data.csv').split("\n")

# Example @strategy_guide
# [
#   {:opponent=>"rock", :outcome=>"paper"},
#   {:opponent=>"paper", :outcome=>"rock"},
#   {:opponent=>"scissors", :outcome=>"scissors"}
# ]

@strategy_guide = []

@outcome_points = {
  "win": 6,
  "draw": 3,
  "lose": 0
}

@choices_points = {
  "rock": 1,
  "paper": 2,
  "scissors": 3
}

def populate_strategy_guide
  @file.each do |row|
    choices = row.split(' ')
    round = convert_choices_to_round(choices)
    @strategy_guide << round
  end
end

def convert_choices_to_round(choices)
  {
    opponent: convert_to_words(choices[0]),
    outcome: convert_to_words(choices[1])
  }
end

def convert_to_words(letter)
  if %w[A].include?(letter)
    'rock'
  elsif %w[B].include?(letter)
    'paper'
  elsif %w[C].include?(letter)
    'scissors'
  elsif %w[X].include?(letter)
    'lose'
  elsif %w[Y].include?(letter)
    'draw'
  else
    'win'
  end
end

################ Solving the problem ##########################
@total_score = 0

def play
  @strategy_guide.each do |round|
    opponent = round[:opponent]
    outcome = round[:outcome]
    me = rock_paper_scissors(opponent, outcome)

    @total_score += @outcome_points[:"#{outcome}"] + @choices_points[:"#{me}"]
  end
end

def rock_paper_scissors(opponent, outcome)
  case outcome
  when 'draw'
    opponent
  when 'win'
    return 'scissors' if opponent == 'paper'
    return 'paper' if opponent == 'rock'

    'rock'
  else
    return 'rock' if opponent == 'paper'
    return 'scissors' if opponent == 'rock'

    'paper'
  end
end

################ Showing the Answer ##########################

populate_strategy_guide
play
puts @total_score