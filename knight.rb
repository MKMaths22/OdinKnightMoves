# frozen_string_literal: true

# The 2-D constant array BOARD keeps the Square instances 'squares' in place while the connections between them are constructed using the Knight class's find_poss_squares method. However, once the starting and finishing square objects are found, the knight_moves method then uses the instance variables of the squares only to do the calculations, without referring back to the BOARD at all.

# Knight class details how the knight moves. If this is changed in future versions based on other pieces, that will is fine UNLESS the piece cannot access the entire board. In that case, extra methods would be necessary to detect this and prevent infinite loops.
class Knight
    KNIGHT_VECTORS = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    # find_poss_squares accepts a 2-D array as input and outputs a 2-D array of coordinates of accessible squares using a single knight move
    def find_poss_squares(array)
        output = []
        KNIGHT_VECTORS.each { |vector| output.push([vector[0] + array[0], vector[1] + array[1]]) }
        # output includes all squares reachable on an infinite board. Now filter for the allowable ranges of row and column on actualy finite board.
        output.select { |coords| coords[0].between?(0, 7) && coords[1].between?(0, 7) }
    end
end

# Square class contains instance variables for coordinates and references to neighbour squares, i.e. squares a knight move away from self
class Square
  
  @@squares = []
  # Square class keeps an array of all squares

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
  # board is 2-D array of squares, so that we can access a square with coordinates
  board.each_with_index do |row, row_index|
    row.each_with_index do |item, column_index|
      coordinates = [row_index, column_index]
      board[row_index][column_index] = Square.new(coordinates)
    end
  end
  board
end

BOARD = make_board
KNIGHT = Knight.new
Square.find_all_neighbours(BOARD, KNIGHT)
# if we call knight_moves many times, the board is set up already, so only happens once

def knight_moves(start, finish)
  first_square = BOARD.dig(start[0], start[1])
  final_square = BOARD.dig(finish[0], finish[1])
  unless first_square && final_square
    puts 'Input not accepted. We require knight_moves([w, x], [y, z]) where w,x,y and z are whole numbers between 0 and 7.'
    return
  end
  first_square.distance = 0
  found_squares = [first_square]
  finish_found = false
  finish_found = true if first_square == final_square
    until finish_found do
      current_square = found_squares.shift
      current_distance = current_square.distance
      # current_distance is definitely not nil and is distance from first_square
      current_square.neighbours.each do |neighbour|
        unless neighbour.distance
          neighbour.distance = current_distance + 1
          found_squares.push(neighbour)
          if neighbour == final_square
            finish_found = true
            break
          end
        end
        break if finish_found
      end
    end 
    output_route(construct_route(first_square, final_square))
    Square.reset_all_distances
end

def step_or_steps(number)
  return "no steps at all!" if number.zero?
  return "just 1 step." if number == 1
   "#{number} steps."
end

def construct_route(first_square, final_square)
  current_distance = final_square.distance
  current_target = final_square
  route = [final_square.coordinates]
  while current_distance > 1
    current_distance -= 1
    current_target = current_target.neighbours.find { |neighbour| neighbour.distance == current_distance }
    # current_target is one step closer to first_square and a neighbour of previous target, so is definitely on a shortest possible route
    route.unshift(current_target.coordinates)
  end
  route.unshift(first_square.coordinates)
  route
end
  
def output_route(route) 
  puts "We have found a route using #{step_or_steps(route.size - 1)}"
  puts "Here's your path:"
  route.each { |point| puts "\[#{point[0]},#{point[1]}\]" }
end

knight_moves([0,0], [1,1])

