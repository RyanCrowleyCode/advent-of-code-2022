require 'pry'

################ Getting the data ##########################
@file ||= File.read('data.csv').split("\n")

# @groups = [
#   {
#     "elf_1"=>["v", "J", "r", "w", "p", "W", "t", "g", "h", "c", "s", "F", "M", "f"],
#     "elf_2"=>["j", "q", "H", "R", "N", "z", "G", "D", "L", "r", "s", "F", "M", "f", "Z", "S"],
#     "elf_3"=>["P", "m", "d", "z", "q", "r", "V", "v", "w", "T", "W", "B", "g"]
#   },
#   {
#     "elf_1"=>["w", "M", "q", "v", "L", "Z", "H", "h", "j", "b", "c", "n", "S", "B", "T", "Q", "F"],
#     "elf_2"=>["t", "g", "J", "R", "G", "Q", "c", "T", "Z"],
#     "elf_3"=>["C", "r", "Z", "s", "J", "P", "G", "z", "w", "L", "m", "p", "M", "D"]
#   }
# ]
@groups = []

def set_up_compartments
  elf_count = 1
  @elves = {}

  @file.each do |row|
    @elves["elf_#{elf_count}"] = row.split('').uniq

    elf_count += 1

    next unless elf_count == 4

    elf_count = 1
    @groups << @elves
    @elves = {}
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
  @groups.each do |group|
    group['elf_1'].each do |item|
      @priority_sum += @priority[item] if all_elves_contain_item?(item, group['elf_2'], group['elf_3'])
      # @priority_sum += @priority[item] if compartment_contains_item?(rucksack['compartment_two'], item)
    end
  end
end

def all_elves_contain_item?(item, elf_two, elf_three)
  elf_two.include?(item) && elf_three.include?(item)
end

################ Showing the Answer ##########################
set_up_compartments
calculate_priority_sum
puts @priority_sum
