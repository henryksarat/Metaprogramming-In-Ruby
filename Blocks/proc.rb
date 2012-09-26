def math(a,b)
 yield(a,b)
end

def teach_math(a,b,&operation)
 puts "Let's do the math:"
 puts math(a,b,&operation)
end

teach_math(2,3) {|x,y|x*y}

def sayHello(a) 
 yield(a)
end

def saySomething(a,&operation) 
 puts "Let's do this"
 sayHello(a,&operation)
end

saySomething("word") {|x| puts "this is called with: #{x}"}




