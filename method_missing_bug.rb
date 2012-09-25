class Roulette
 def method_missing(name, *args)
  person = name.to_s.capitalize
  3.times do
   number = rand(10)+1
   puts "#{number}.."
  end
  "#{person} got a #{number}"
 end
end

number_of = Roulette.new
puts number_of.bob
puts number_of.frank


#fixed bug - ("number" fell out of scope before and tuby assumed "number" was self.number")

class Roulette
 def method_missing(name, *args)
  person = name.to_s.capitalize
  super unless %w[Bob Frank Bill].include? person
  number = 0
  3.times do
   number = rand(10)+1
   puts "#{number}.."
  end
  "#{person} got a #{number}"
 end
end

number_of = Roulette.new
puts number_of.bob
puts number_of.frank


