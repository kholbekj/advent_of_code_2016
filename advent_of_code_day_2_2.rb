input = File.read('input_text_2_2.txt')

@map = [
  [nil, nil, '5', nil, nil],
  [nil, '2', '6', 'A', nil],
  ['1', '3', '7', 'B', 'D'],
  [nil, '4', '8', 'C', nil],
  [nil, nil, '9', nil, nil]
]

# point to current button on keypad
@pointer = [0,3]

@code = ""

def point_to_value(point)
  return if @map[point[0]].nil?
  @map[point[0]][point[1]]
end

def up
  @pointer[1] -= 1 unless (@pointer[1] - 1 < 0) || point_to_value([@pointer[0], @pointer[1] - 1]).nil?
end

def down
  @pointer[1] += 1 unless (@pointer[1] + 1 < 0) || point_to_value([@pointer[0], @pointer[1] + 1]).nil?
end

def right
  @pointer[0] += 1 unless (@pointer[0] + 1 < 0) || point_to_value([@pointer[0] + 1, @pointer[1]]).nil?
end

def left
  @pointer[0] -= 1 unless (@pointer[0] - 1 < 0) || point_to_value([@pointer[0] - 1, @pointer[1]]).nil?
end

digit_instructions = input.split("\n")
digit_instructions.each do |instruction|
  buttons = instruction.split('')
  buttons.each do |button|
    case button
    when 'U'
      up
    when 'D'
      down
    when 'R'
      right
    when 'L'
      left
    end
  end
  @code << point_to_value(@pointer)
end

puts @code
