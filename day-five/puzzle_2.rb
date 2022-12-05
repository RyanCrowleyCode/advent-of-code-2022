require 'pry'
require 'active_support/all'

################ Getting the data ##########################
@file ||= File.read('data.csv').split("\n")

@position_index
@instructions_index
@stack_indices = {}
@crates = {}
@instructions = []

def find_position_index
  @file.each_with_index do |row, index|
    if row.exclude?('[')
      @position_index = index
      @instructions_index = index + 2

      instructions = row.split('')
      instructions.each_with_index do |character, i|
        @stack_indices["#{character}"] = i.to_s if character != ' '
      end
      break
    end
  end
end

def establish_crates
  @file.each_with_index do |row, index|
    break if index == @position_index

    row.split('').each_with_index do |item, index|
      initialize_position_if_empty(index)
      @crates["#{index}"].concat(["#{item}"]) if valid_item?(item)
    end
  end
end

def initialize_position_if_empty(index)
  @crates["#{index}"] = [] if @crates["#{index}"].nil?
end

def valid_item?(item)
  item != ' ' && item != '[' && item != ']'
end

def establish_instructions
  @file[@instructions_index..].each do |row|
    @instructions << instruction_hash(row)
  end
end

def instruction_hash(row)
  split_row = row.split
  {
    'amount': split_row[1],
    'start': split_row[3],
    'end': split_row[5]
  }
end

def setup_data
  find_position_index
  establish_crates
  establish_instructions
end
################ Solving the problem ##########################
def move_crates
  @instructions.each do |instruction|
    amount = instruction[:amount].to_i
    start = @crates[@stack_indices[instruction[:start]]]


    shifted = start.shift(amount)
    original = @crates[@stack_indices[instruction[:end]]]
    @crates[@stack_indices[instruction[:end]]] = shifted.concat(original)
  end
end

def get_top_boxes
  message = ""
  @stack_indices.each do|key, value|
    message.concat(@crates[value][0])
  end

  message
end

################ Showing the Answer ##########################
setup_data
move_crates
puts get_top_boxes