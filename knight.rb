# frozen_string_literal: true

# I will do pseudo code describing the method for solving this first

# The Board object will be a 2-D array in which each value is a Square object, which has the attributes of its co-ordinates and the 'neighbours' instance variable, which is an array of references to its neighbour Squares. 
# The 2-D board array keeps the Squares in place while the connections between them are constructed using the Knight class's squares_possible method 

class Square
  def initialize(coordinates)
    @coordinates = coordinates
    @neighbours = []
  end
end

class Knight
  # squares_possible accepts a 2-D array as input and outputs an array of references to knight-neighbour squares
  def squares_possible(array)
  end
end

def make_board
  board = Array.new(8) {Array.new(8)}
  board.each_with_index do |row, row_index|
    row.each_with_index do |item, column_index|
      coordinates = [row_index, column_index]
      board[row_index][column_index] = Square.new(coordinates)
    end
  end
end

p make_board