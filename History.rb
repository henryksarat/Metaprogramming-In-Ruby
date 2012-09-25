class Class
 attr_reader :boom
 def attr_accessor_with_history(attr_name)
  attr_name = attr_name.to_s
  attr_reader attr_name
  attr_reader attr_name+"_history"
  define_method "#{attr_name}=" do |val|
   myHistory = instance_variable_get "@#{attr_name}_history"
   if myHistory == nil
    myHistory  = []
    myHistory.push(nil)
   end

   myHistory.push(val)

   instance_variable_set "@#{attr_name}_history", myHistory
   instance_variable_set "@#{attr_name}", val
  end
 end
end

class Foo
 attr_accessor_with_history :bar
end

OR


class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s
    
    attr_reader attr_name
    attr_reader attr_name + "_history"
    class_eval %Q{
      def #{attr_name}=(val)
        @#{attr_name}=val
        @#{attr_name}_history ||=  [nil]
        @#{attr_name}_history << val
      end
    }
  end
end

class Foo
  attr_accessor_with_history :bar
end