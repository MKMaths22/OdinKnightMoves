def find_one_route(first_square, final_square)
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
    route.uniq!
    output_route(route)
  end