require 'pry'

################ Getting the data ##########################
@file ||= File.read('data.csv').split("\n")

@rows = {}
@columns = {}
@last_index = @file.size - 1
@visible_trees = 0

def set_rows_and_columns
  @file.each_with_index do |row, row_index|
    row = row.split("")
    @rows[row_index] = row

    row.each_with_index do |number, column_index|
      set_key_if_not_there(column_index)
      @columns[column_index] << number
    end
  end
end

def set_key_if_not_there(key)
  return if @columns.key?(key)

  @columns[key] = []
end


################ Solving the problem ##########################
def count_visible_trees
  @file.each_with_index do |row, row_index|
    row = row.split("")

    row.each_with_index do |number, column_index|
      if edge_tree?(row_index, column_index)
        @visible_trees += 1
      elsif visible_in_row?(number, row, column_index)
        @visible_trees += 1
        elsif visible_in_column?(number, row_index, column_index)
          @visible_trees += 1
      end
    end
  end
end

def edge_tree?(row_index, column_index)
  row_edge?(row_index) || column_edge?(column_index)
end

def row_edge?(row_index)
  [0, @last_index].include?(row_index)
end

def column_edge?(column_index)
  [0, @last_index].include?(column_index)
end

def visible_in_row?(number, row, column_index)
  return true if visible_left?(number, row, column_index)

  visible_right?(number, row, column_index)
end

def visible_left?(number, row, column_index)
  stop = column_index - 1
  row[0..stop].each do |tree|
    return false if tree >= number
  end

  true
end

def visible_right?(number, row, column_index)
  start = column_index + 1
  row[start..@last_index].each do |tree|
    return false if tree >= number
  end

  true
end

def visible_in_column?(number, row_index, column_index)
  return true if visible_up?(number, row_index, column_index)

  visible_down?(number, row_index, column_index)
end

def visible_up?(number, row_index, column_index)
  stop = row_index - 1

  @columns[column_index][0..stop].each do |tree|
    return false if tree >= number
  end

  true
end

def visible_down?(number, row_index, column_index)
  start = row_index + 1

  @columns[column_index][start..@last_index].each do |tree|
    return false if tree >= number
  end

  true
end


################ Showing the Answer ##########################
set_rows_and_columns
count_visible_trees

puts @visible_trees
