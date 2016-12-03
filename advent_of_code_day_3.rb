class Triangle
  def initialize(string)
    sides = string.split.map(&:to_i)
    @hypotenuse = sides.max
    sides.delete_at(sides.index(@hypotenuse))
    @side_a = sides.min
    sides.delete_at(sides.index(@side_a))
    @side_b = sides.first
  end

  def possible?
    @hypotenuse < @side_a + @side_b
  end
end

input = File.read('input_day_3.txt')

@triangles = input.split("\n").map {|i| Triangle.new(i)}

@vertical_triangles = []

input.split("\n").each_slice(3).to_a.each do |group|
  first = ''
  second = ''
  third = ''
  group.map do |row|
    first << row.split[0] + ' '
    second << row.split[1] + ' '
    third << row.split[2] + ' '
  end
  [first, second, third].each do |tri|
    @vertical_triangles << Triangle.new(tri)
  end
end

@possible_triangles = @triangles.select(&:possible?)
@possible_vertical_triangles = @vertical_triangles.select(&:possible?)


puts "There are #{@possible_triangles.count} possible horizontal triangles"
puts "There are #{@possible_vertical_triangles.count} possible vertical triangles"
