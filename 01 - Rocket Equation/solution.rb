modules = File.open('input.txt', 'r').map
fuel = modules.map { |mass| (mass.to_i / 3) - 2 }

puts "Partie 1:"
puts fuel.sum


total = fuel.map do |mass|
  fuel_fuel = mass
  additional_fuel = mass
  while fuel_fuel > 0 
    fuel_fuel = (fuel_fuel / 3) - 2
    additional_fuel += fuel_fuel if fuel_fuel > 0
  end
  additional_fuel
end

puts "Partie 2:"
puts total.sum