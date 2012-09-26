module MyMixin
 def self.included(base)
  base.extend(ClassMethods)
 end

 module ClassMethods
  def x 
   "x()"
  end
 end
end

class Something
 include MyMixin
end
