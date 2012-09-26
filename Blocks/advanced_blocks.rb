lambda {
 calculations = {}
 firstAdds = []
 
 Kernel.send :define_method, :add_to_queue do |number,&block|
  calculations[number] = block
 end
 
 Kernel.send :define_method, :add_to_setup do |&block|
  firstAdds << block
 end

 Kernel.send :define_method, :each_event do |&block|
  calculations.each_pair do |number,execBlock|
   block.call number, execBlock
  end
 end
 
 Kernel.send :define_method, :each_setup do |&block|
  firstAdds.each do |first|
   block.call first
  end
 end
}.call

p = Proc.new { |x| x * 3 }
q = Proc.new { |x| x * 9 }
add_to_queue 3, &p
add_to_queue 4, &q

g = Proc.new { |x| x + 1 }
add_to_setup &g
add_to_setup &g

each_event do |number, execBlock|
 myTotal = 0
 each_setup do |first|
  myTotal += first.call(number)
  puts myTotal
 end
 
 myTotal += execBlock.call(myTotal)
 puts myTotal
 puts "cut off"
end


