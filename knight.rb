# frozen_string_literal: true

# I will do pseudo code describing the method for solving this first

# The board will be a 2-D array in which each value is a Square object, which has the attributes of its co-ordinates and the 'neighbours' instance variable, which is an array of references to its neighbour Squares. 
# The 2-D board array keeps the Squares in place while the connections between them are constructed using the Knight class's squares_possible method 

class Knight
    # squares_possible accepts a 2-D array as input and outputs a 2-D array of coordinates of accessible squares using a single knight move
    def squares_possible(array)
        [[1,2], [2,1]]
    end
end

class Square
  
  attr_reader :coordinates
  attr_accessor :neighbours

  def initialize(coordinates)
    @coordinates = coordinates
    @neighbours = []
  end

  def find_neighbours(board, knight)
    poss_array = knight.squares_possible(coordinates)
    poss_array.each do |item|
        @neighbours.push(board[item[0]][item[1]])
        # the Square object now references its neighbours directly
    end
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
  board
end

board = make_board
knight = Knight.new
board.dig(0,0).find_neighbours(board, knight)
p board.dig(0,0)