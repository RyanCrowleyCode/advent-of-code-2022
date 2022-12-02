require 'pry'

################ Getting the data ##########################
@file = File.read('data.csv').split("\n")

# Example @strategy_guide
# [
#   {:opponent=>"rock", :me=>"paper"},
#   {:opponent=>"paper", :me=>"rock"},
#   {:opponent=>"scissors", :me=>"scissors"}
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
    me: convert_to_words(choices[1])
  }
end

def convert_to_words(letter)
  if %w[A X].include?(letter)
    'rock'
  elsif %w[B Y].include?(letter)
    'paper'
  else
    'scissors'
  end
end

################ Solving the problem ##########################
@total_score = 0

def play
  @strategy_guide.each do |round|
    opponent = round[:opponent]
    me = round[:me]

    outcome = rock_paper_scissors(opponent, me)
    @total_score += @outcome_points[:"#{outcome}"] + @choices_points[:"#{me}"]
  end
end

def rock_paper_scissors(opponent, me)
  if opponent == me
    'draw'
  elsif opponent == 'rock'
    return 'win' if me == 'paper'

    'lose'
  elsif opponent == 'paper'
    return 'win' if me == 'scissors'

    'lose'
  else
    return 'win' if me == 'rock'

    'lose'
  end
end

################ Showing the Answer ##########################

populate_strategy_guide
play
puts @total_score