require 'pry'

################ Getting the data ##########################
@file ||= File.read('data.csv').split("\n")

# @pairs = [
#   {
#     :first=>{:start=>2, :end=>4},
#     :second=>{:start=>6, :end=>8}
#   },
#   {
#     :first=>{:start=>2, :end=>4},
#     :second=>{:start=>6, :end=>8}
#   }
# ]
@pairs = []

def set_up_pairs
  @file.each do |row|
    @pair = {}

    pairs = row.split(",")
    first = elf_range(pairs[0])
    second = elf_range(pairs[1])

    @pair[:first] = first
    @pair[:second] = second

    @pairs << @pair
  end
end

def elf_range(range)
  range = range.split("-")
  {
    'start': range[0].to_i,
    'end': range[1].to_i
  }
end


################ Solving the problem ##########################
@pairs_that_fully_overlap = 0

def calculate_pairs_that_fully_overlap
  @pairs.each do |pair|
    @pairs_that_fully_overlap += 1 if full_overlap?(pair)
  end
end

def full_overlap?(pair)
  first_range_contains_all?(pair) || second_range_contains_all?(pair)
end

def first_range_contains_all?(pair)
  pair[:first][:start] <= pair[:second][:start] && pair[:first][:end] >= pair[:second][:end]
end

def second_range_contains_all?(pair)
  pair[:second][:start] <= pair[:first][:start] && pair[:second][:end] >= pair[:first][:end]
end

################ Showing the Answer ##########################
set_up_pairs
calculate_pairs_that_fully_overlap
puts @pairs_that_fully_overlap