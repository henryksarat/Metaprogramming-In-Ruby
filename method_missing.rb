class Lawyer
 def method_missing(method, *args)
  puts "you called: #{method} (#{args.join(', ')})"
  puts "(You also passed it a block)" if block_given?
 end	
end

bob = Lawyer.new
bob.talk_simple('a','b') do
	#a block
end

class Doctor
 def method_missing(method, *args)
  return operate($1.to_sym => args[0], $2.to_sym => args[1]) if method.to_s =~ /^operate_(.*)_and_(.*)/
  super
 end
 
 def operate(something)
  puts "we are operating on #{something.keys[0]} with doc #{something[something.keys[0]]} and then #{something.keys[1]} with doc #{something[something.keys[1]]}"	 
 end
end

d = Doctor.new
d.operate_nose_and_hand "dr. nosejob", "dr handzzzz"


class MyOpenStruct
 def initialize
  @attributes = {}		
 end
	
 def method_missing(method, *args) 
  attribute = method.to_s
  if attribute =~ /=$/
   @attributes[attribute.chop] = args[0]
  else
   @attributes[attribute]  
  end
 end
end

my = MyOpenStruct.new
my.flavor = "green"

#Using delegates

require 'delegate'

class Assistant
 def initialize(name)
  @name = name	 
 end
 
 def read_email
  "(#{@name} It's mostly spam."	 
 end
 
 def check_schedule
  "(#{@name}) You have a meeting today." 
 end
end

class Manager < DelegateClass(Assistant)
 def initialize(assistant)
  super(assistant)	
 end
 
 def attend_meeting
  "Please hold my calls"	 
 end
end

frank = Assistant.new("Frank")
anne = Manager.new(frank)
anne.attend_meeting
anne.read_email
anne.check_schedule


#Computer class with method missing

class DS
 def get_cpu_info
  "Dual Core"
 end
 
 def get_cpu_price
  100
 end
 
 def get_mouse_info
  "Optical"
 end
 
 def get_mouse_price
  200
 end
 def get_keyboard_info
  "Zing"
 end
 
 def get_keyboard_price
  890
 end
end

class Computer
	
 def initialize(computer_id, data_source)
  @id = computer_id
  @data_source = data_source
 end
 
 def method_missing(name, *args)
  super if !@data_source.respond_to?("get_#{name}_info")
  info = @data_source.send("get_#{name}_info")
  price = @data_source.send("get_#{name}_price")
  result = "#{name.to_s.capitalize}: #{info} ($#{price})"
  return "* #{result}" if price >= 100
  result
 end
 
 def respond_to?(method)
  @data_source.respond_to?("get_#{method}_info") || super	 
 end
end

myDs = DS.new
myComp = Computer.new(32, myDs)
myComp.mouse

#This will fail because display is already defined in Object
#myComp.display => nil
#Object.instance_methods.grep /^d/ #=> [:dup, :display, :define_singleton_method]


def Object.const_missing(name)
	name.to_s.downcase.gsub(/_/, '')	
end



#####Fixed computer with BlankSlate

class DS
 def get_cpu_info
  "Dual Core"
 end
 
 def get_cpu_price
  100
 end
 
 def get_mouse_info
  "Optical"
 end
 
 def get_mouse_price
  200
 end
 def get_keyboard_info
  "Zing"
 end
 
 def get_keyboard_price
  890
 end
end
#if a class inherits directly from BasicObject its already a blank slate
class Computer
 instance_methods.each do |m|
  undef_method m unless m.to_s =~ /^__|method_missing|respond_to?/
 end
 
 def initialize(computer_id, data_source)
  @id = computer_id
  @data_source = data_source
 end
 
 def method_missing(name, *args)
  super if !@data_source.respond_to?("get_#{name}_info")
  info = @data_source.send("get_#{name}_info")
  price = @data_source.send("get_#{name}_price")
  result = "#{name.to_s.capitalize}: #{info} ($#{price})"
  return "* #{result}" if price >= 100
  result
 end
 
 def respond_to?(method)
  @data_source.respond_to?("get_#{method}_info") || super	 
 end
end

myDs = DS.new
myComp = Computer.new(32, myDs)
myComp.mouse

