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
@pairs_that_overlap = 0

def calculate_pairs_that_overlap
  @pairs.each do |pair|
    @pairs_that_overlap += 1 if overlap?(pair)
  end
end

def overlap?(pair)
  pair[:first][:end] >= pair[:second][:start] && pair[:second][:end] >= pair[:first][:start]
end


################ Showing the Answer ##########################
set_up_pairs
calculate_pairs_that_overlap
puts @pairs_that_overlap