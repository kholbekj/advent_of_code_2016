input = "L2, L3, L3, L4, R1, R2, L3, R3, R3, L1, L3, R2, R3, L3, R4, R3, R3, L1, L4, R4, L2, R5, R1, L5, R1, R3, L5, R2, L2, R2, R1, L1, L3, L3, R4, R5, R4, L1, L189, L2, R2, L5, R5, R45, L3, R4, R77, L1, R1, R194, R2, L5, L3, L2, L1, R5, L3, L3, L5, L5, L5, R2, L1, L2, L3, R2, R5, R4, L2, R3, R5, L2, L2, R3, L3, L2, L1, L3, R5, R4, R3, R2, L1, R2, L5, R4, L5, L4, R4, L2, R5, L3, L2, R4, L1, L2, R2, R3, L2, L5, R1, R1, R3, R4, R1, R2, R4, R5, L3, L5, L3, L3, R5, R4, R1, L3, R1, L3, R3, R3, R3, L1, R3, R4, L5, L3, L1, L5, L4, R4, R1, L4, R3, R3, R5, R4, R3, R3, L1, L2, R1, L4, L4, L3, L4, L3, L5, R2, R4, L2"

@direction = 0
@directions = [:north, :east, :south, :west]
@map = { north: 0, east: 0, south: 0, west: 0 }
@first_point_distance = nil

@old_points = []

def direction_for(number)
  @directions[number % 4]
end

def turn_right
  @direction += 1
end

def turn_left
 @direction += 3
end

def move(n)
  n.times do
    @map[direction_for(@direction)] += 1
    check_old_points
    record_point
  end
end

def record_point
  @old_points << map_to_point
end

def calculate_blocks
  horizontal = (@map[:east] - @map[:west]).abs
  vertical = (@map[:north] - @map[:south]).abs
  horizontal + vertical
end

def check_old_points
  if @old_points.include? map_to_point
    @first_point_distance ||= calculate_blocks
  end
end

def map_to_point
  [@map[:east] - @map[:west], @map[:north] - @map[:south]]
end

def parse_input(input)
  instructions = input.split(", ")
  instructions.each do |instruction|
    dir = instruction[0]
    amount = instruction[1..-1]
    if dir == 'R'
      turn_right
    else
      turn_left
    end
    move(amount.to_i)
  end
end

parse_input(input)

puts "Ended up #{calculate_blocks} blocks away from start"

if @first_point_distance
  puts "First point visited twice had distance: #{@first_point_distance}"
else
  puts "No point was visited twice"
end
