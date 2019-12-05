def vertical?(wire)
  wire[0][0] == wire[1][0]
end

def intersects?(vertical, horizontal)
  min_h, max_h = [horizontal[0][0], horizontal[1][0]].sort
  min_v, max_v = [vertical[0][1], vertical[1][1]].sort
  (min_h..max_h).include?(vertical[0][0]) && (min_v..max_v).include?(horizontal[0][1])
end

def intersection(wire1, wire2)
  return nil if (vertical?(wire1) == vertical?(wire2))
  vertical, horizontal = [wire1, wire2].sort { |w| vertical?(w) ? 0 : 1 }

  return [vertical[0][0], horizontal[0][1]] if intersects?(vertical, horizontal)
end

# Parser les fils dans une liste de coordonnées
paths = []
input = File.open('input.txt', 'r').each do |line|
  paths.push([])
  cursor = [0,0]

  line.split(',').each do |wire|
    direction = wire.slice!(0)
    distance = wire.to_i

    case direction
    when 'U'
      new_cursor = [cursor[0], cursor[1] + distance]
    when 'R'
      new_cursor = [cursor[0] + distance, cursor[1]]
    when 'D'
      new_cursor = [cursor[0], cursor[1] - distance]
    when 'L'
      new_cursor = [cursor[0] - distance, cursor[1]]
    end

    paths.last.push([cursor.clone, new_cursor])

    cursor = new_cursor
  end
end

# Vérifier les intersections

intersections = []

paths.each_with_index do |path, index|
  compair_list = paths.clone
  compair_list.slice!(index)
  compair_list.each do |compared_path|
    path.each do |wire|
      compared_path.each do |compaired_wire|
        intersections << intersection(wire, compaired_wire)
      end
    end
  end
end

intersections.delete([0,0])

puts "Partie 1:"
puts intersections.compact.uniq.map { |x, y| x.abs + y.abs }.min