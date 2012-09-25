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

 def mouse
  info = @data_source.get_mouse_info
  price = @data_source.get_mouse_price
  result = "Mouse: #{info} ($#{price})"
  return "*#{result}" if price >= 100
  result
 end
 
 def cpu
  info = @data_source.get_cpu_info
  price = @data_source.get_cpu_price
  result = "Mouse: #{info} ($#{price})"
  return "*#{result}" if price >= 100
  result
 end
end

#instead use dynamic methods

class Computer
 def initialize(computer_id, data_source)
  @id = computer_id
  @data_source = data_source
 end
 
 def mouse
  component :mouse
 end
 
 def cpu
  component :cpu
 end
 
 def component(name)
  info = @data_source.send "get_#{name}_info"
  price = @data_source.send "get_#{name}_price"
  result = "#{name.to_s.capitalize}: #{info} ($#{price})"
  return "*#{result}" if price >= 100
  result
 end
end


#do even better

class Computer
 def initialize(computer_id, data_source)
  @id = computer_id
  @data_source = data_source
 end
 
 def self.define_component(name)
  define_method(name) do
   info = @data_source.send "get_#{name}_info"
   price = @data_source.send "get_#{name}_price"
   result = "#{name.to_s.capitalize}: #{info} ($#{price})"
   return "*#{result}" if price >= 100
   result
  end
 end
 
 define_component :mouse
 define_component :cpu
end

#doing EVEN BETTER by using introspection and removing the define components
#to dynamically grab new computer parts

class Computer
 def initialize(computer_id, data_source)
  @id = computer_id
  @data_source = data_source
  data_source.methods.grep(/^get_(.*)_info/) { Computer.define_component $1 }
 end
 
  def self.define_component(name)
  define_method(name) do
   info = @data_source.send "get_#{name}_info"
   price = @data_source.send "get_#{name}_price"
   result = "#{name.capitalize}: #{info} ($#{price})"
   return "*#{result}" if price >= 100
   result
  end
 end
end
