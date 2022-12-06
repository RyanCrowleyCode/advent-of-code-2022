require 'pry'

################ Getting the data ##########################
@file = File.read('data.csv').split("\n")

@data = @file.first.split("")
@end_of_data = @file.size - 1
@when_first_marker_is_known

################ Solving the problem ##########################

def find_when_first_marker_is_known
  @starting_character = 0
  @data.each_with_index do |letter, index|
    next if index < 3

    sequence = @data[@starting_character..index]
    if sequence_is_unique?(sequence)
      @when_first_marker_is_known = index + 1
      break
    end

    @starting_character += 1
  end
end

def sequence_is_unique?(sequence)
  sequence.uniq.size == sequence.size
end


################ Showing the Answer ##########################

find_when_first_marker_is_known
puts @when_first_marker_is_known

