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

class Numeric
  @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}

  def in(currency)
    singular_currency = currency.to_s.gsub( /s$/, '')
    myTimesBy = 1
    myDividedBy = 1
    mylastOne = @@lastOne.to_s.gsub( /s$/, '')

    if mylastOne != "dollar" && singular_currency == "dollar"
     if @@currencies.has_key?(singular_currency)
        myTimesBy = @@currencies[mylastOne]
        myDividedBy = 1        
     end
    elsif mylastOne != "dollar" && singular_currency != "dollar"
     myDividedBy = @@currencies[singular_currency]
     myTimesBy = @@currencies[mylastOne]
    end

    self * myTimesBy / myDividedBy
  end

  def method_missing(method_id)
    @@lastOne = "#{method_id}"
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self 
    else
     super
    end
  end
end

class String
 def palindrome?()
  self.gsub(/\W/, '').downcase == self.gsub(/\W/, '').downcase.reverse
 end
end