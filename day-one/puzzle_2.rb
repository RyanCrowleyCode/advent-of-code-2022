require "pry"

################ Getting the data ##########################
@file = File.read("data.csv").split("\n")

################ Solving the problem ########################## 

@elves = []

def add_calories
    this_elves_calories = 0

    calories.each_with_index do |calories, index|
        this_elves_calories += calories.to_i

        if calories == "" || index == last_one
            @elves.push(this_elves_calories)
            this_elves_calories = 0
        end
    end
end

def calories
    @calories ||= @file.dup
end

def last_one
    @last_one ||= calories.length - 1
end

################ Showing the Answer ##########################

add_calories
puts @elves.max(3).sum