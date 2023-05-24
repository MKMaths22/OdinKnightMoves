# frozen_string_literal: true

# I will do pseudo code describing the method for solving this first

# The board will be a 2-D array in which each value is a Square object, which has the attributes of its co-ordinates and the 'neighbours' instance variable, which is an array of references to its neighbour Squares. 
# The 2-D board array keeps the Squares in place while the connections between them are constructed using the Knight class's squares_possible method 

class Knight
    KNIGHT_VECTORS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    # find_poss_squares accepts a 2-D array as input and outputs a 2-D array of coordinates of accessible squares using a single knight move
    def find_poss_squares(array)
        output = []
        KNIGHT_VECTORS.each { |vector| output.push([vector[0] + array[0], vector[1] + array[1]]) }
        output.select { |coords| coords[0].between?(0, 7) && coords[1].between?(0, 7) }
    end
end

class Square
  
  @@squares = []

  attr_reader :coordinates
  attr_accessor :neighbours, :distance

  def initialize(coordinates)
    @coordinates = coordinates
    @neighbours = []
    @distance = nil
    @@squares.push(self)
  end

  def find_neighbours(board, knight)
    poss_array = knight.find_poss_squares(coordinates)
    poss_array.each do |item|
        @neighbours.push(board[item[0]][item[1]])
        # the Square object now references its neighbours directly
    end
  end

  def self.find_all_neighbours(board, knight)
    @@squares.each { |square| square.find_neighbours(board, knight) }
  end

  def self.reset_all_distances
    @@squares.each { |square| square.distance = nil }
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
Square.find_all_neighbours(board, knight)

def knight_moves(start, finish)
  # start and finish are coordinate arrays
  counter = 0
  found_squares = [board[start[0]][start[1]]]


  # at end of program run Square.reset_all_distances
end