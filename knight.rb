# frozen_string_literal: true

# The 2-D constant array BOARD keeps the Square instances 'squares' in place while the connections between them are constructed using the Knight class's find_poss_squares method. However, once the starting and finishing square objects are found, the knight_moves method then uses the instance variables of the squares only to do the calculations, without referring back to the BOARD at all.

# Knight class details how the knight moves. If this is changed in future versions based on other pieces, that will be fine UNLESS the piece cannot access the entire board. In that case, extra methods would be necessary to detect this and prevent infinite loops.
class Knight
  def initialize
    @all_routes = []
    @vectors = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
  end
    
  # find_poss_squares accepts a 2-D array as input and outputs a 2-D array of coordinates of accessible squares using a single knight move
  
  def find_poss_squares(array)
    output = []
    @vectors.each { |vector| output.push([vector[0] + array[0], vector[1] + array[1]]) }
    # output includes all squares reachable on an infinite board. Now filter for the allowable ranges of row and column on actualy finite board.
    output.select { |coords| coords[0].between?(0, 7) && coords[1].between?(0, 7) }
  end

  def reset_routes
    @all_routes = []
  end

  def add_route(route)
    @all_routes.push(route)
  end

  def step_or_steps(number)
    return 'no steps at all!' if number.zero?

    return 'just 1 step.' if number == 1

    "#{number} steps."
  end

  def path_or_paths(number)
    return 'one other optimal path. Would you like to see it?' if number == 1
    
    "#{number} other optimal paths. Would you like to see them?"
  end
    
  # output_one_route outputs route as in  the project instructions, as a column.
  def output_one_route(route)
    puts "We have found a route using #{KNIGHT.step_or_steps(route.size - 1)}"
    puts "Here's your path:"
    route.each { |point| puts "\[#{point[0]},#{point[1]}\]" }
  end
    
  def output_routes
    output_one_route(@all_routes.shift)
    how_many_other = @all_routes.size
    return puts "This is the unique shortest possible path." if how_many_other.zero?

    puts "I have also found #{path_or_paths(how_many_other)}"
    puts 'Press any key for the remaining output.'
    @all_routes.each { |route| puts as_string(route) } if gets 
  end

  # the remaining routes are displayed as rows
  def as_string(route)
    output = ''
    route.each { |point| output += "\[#{point[0]},#{point[1]}\], " }
    output[0..-3]
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
    row.each_with_index do |_, column_index|
      coordinates = [row_index, column_index]
      board[row_index][column_index] = Square.new(coordinates)
    end
  end
  board
end

BOARD = make_board
KNIGHT = Knight.new
INPUT_ERROR = 'Input not accepted. We require knight_moves([w, x], [y, z]) where w,x,y and z are numbers between 0 and 7.'
Square.find_all_neighbours(BOARD, KNIGHT)
# if we call knight_moves many times, the board is set up already, so only happens once

def generate_neighbours_and_distances(squares_array, target_square)
  current_square = squares_array.shift
  squares_to_add = current_square.neighbours.select { |neighbour| !neighbour.distance }
  squares_to_add.each do |square|
      square.distance = current_square.distance + 1
      squares_array.push(square)
      return if square == target_square

    end
    generate_neighbours_and_distances(squares_array, target_square)
end

def knight_moves(start, finish)
  first_square = BOARD.dig(start[0], start[1])
  final_square = BOARD.dig(finish[0], finish[1])
  return puts INPUT_ERROR unless first_square && final_square
      
  first_square.distance = 0
  generate_neighbours_and_distances([first_square], final_square) unless first_square == final_square
  find_all_routes(first_square, final_square)
  Square.reset_all_distances
  KNIGHT.output_routes
  KNIGHT.reset_routes
end
 
def complete_route(first_square, route, current_distance)
    if current_distance > 1
      neighbours_to_use = route[0].neighbours.select { |neighbour| neighbour.distance == current_distance - 1}
      neighbours_to_use.each { |neighbour| complete_route(first_square, [neighbour].concat(route), current_distance - 1) }
      return
    end
    # otherwise, current_distance = 1, so only first_square remains to add to route
    KNIGHT.add_route([first_square.coordinates].concat(route.map { |square| square.coordinates }))
end

def find_all_routes(first_square, final_square, current_distance = final_square.distance)
  if final_square == first_square
    KNIGHT.add_route([first_square.coordinates])
    return
  end

  # route is partially completed, ends with final square. We extend it from the start
  complete_route(first_square, [final_square], current_distance)
end

knight_moves([5,5], [3,3])

