require 'pry'

################ Getting the data ##########################
@file ||= File.read('data.csv').split("\n")

# @rucsacks = [
#   {
#     'compartment_one': ['a', 'b', 'c'],
#     'compartment_two': ['d', 'e', 'f']
#   }
# ]
@rucksacks = []

def set_up_compartments
  @file.each do |row|
    last_index = row.size
    half = last_index / 2
    rucksack = {}

    rucksack['compartment_one'] = row[0, half].split('').uniq # unique to prevent scoring twice for the same item
    rucksack['compartment_two'] = row[half, last_index].split('').uniq

    @rucksacks << rucksack
  end
end

@priority ||= {
  'a' => 1,
  'b' => 2,
  'c' => 3,
  'd' => 4,
  'e' => 5,
  'f' => 6,
  'g' => 7,
  'h' => 8,
  'i' => 9,
  'j' => 10,
  'k' => 11,
  'l' => 12,
  'm' => 13,
  'n' => 14,
  'o' => 15,
  'p' => 16,
  'q' => 17,
  'r' => 18,
  's' => 19,
  't' => 20,
  'u' => 21,
  'v' => 22,
  'w' => 23,
  'x' => 24,
  'y' => 25,
  'z' => 26,
  'A' => 27,
  'B' => 28,
  'C' => 29,
  'D' => 30,
  'E' => 31,
  'F' => 32,
  'G' => 33,
  'H' => 34,
  'I' => 35,
  'J' => 36,
  'K' => 37,
  'L' => 38,
  'M' => 39,
  'N' => 40,
  'O' => 41,
  'P' => 42,
  'Q' => 43,
  'R' => 44,
  'S' => 45,
  'T' => 46,
  'U' => 47,
  'V' => 48,
  'W' => 49,
  'X' => 50,
  'Y' => 51,
  'Z' => 52
}


################ Solving the problem ##########################
@priority_sum = 0

def calculate_priority_sum
  @rucksacks.each do |rucksack|
    rucksack['compartment_one'].each do |item|
      @priority_sum += @priority[item] if compartment_contains_item?(rucksack['compartment_two'], item)
    end
  end
end

def compartment_contains_item?(compartment, item)
  compartment.include?(item)
end


################ Showing the Answer ##########################
set_up_compartments
calculate_priority_sum
puts @priority_sum