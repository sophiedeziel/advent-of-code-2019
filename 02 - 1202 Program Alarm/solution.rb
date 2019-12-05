@program = File.open('input.txt', 'r').map(&:to_s).join('').split(',').map(&:to_i)

def calculate(noun, verb)
  bytes = @program.clone
  bytes[1] = noun
  bytes[2] = verb

  bytes.each_slice(4) do |opcode, posa, posb, posc|
    case opcode
    when 1
      bytes[posc] = bytes[posa] + bytes[posb]
    when 2
      bytes[posc] = bytes[posa] * bytes[posb]
    else
      break
    end
  end

  bytes[0]
end

puts "Partie 1:"
puts calculate(12, 2)

noun = nil
verb = nil 

noun = (0..99).find do |noun_candidate|
  verb = (0..99).find do |verb_candidate|
    calculate(noun_candidate, verb_candidate) == 19690720
  end
  !verb.nil?
end

puts "Partie 2:"
puts 100 * noun + verb