def event(name,&block)
	@events[name] = block	
end

def setup(&block)
	@setups << block	
end

event "the sky is falling" do
 @sky_height < 300
end

event "it's getting closer" do
 @sky_height < @mountains_height
end

setup do
 puts "Setting up sky"
 @sky_height = 100
end

setup do
 puts "Setting up mountains"
 @mountains_height = 200
end

Dir.glob('*events.rb').each do |file|
	@events = {}
	@setups = []
	load file	
	@events.each_pair do |name,event|
		env = Object.new
		@setups.each do |setup|
			env.instance_eval &setup	
		end
		puts "ALERT: #{name}" if env.instance_eval &event
	end
end

lambda {
	setups = []
	events = {}
	Kernel.send :define_method, :event do |name,&block|
		events[name]=block	
	end
	
	Kernel.send :define_method, :setup do |&block|
		setups << block
	end
	
	Kernel.send :define_method, :each_event do |&block|
		events.each_pair do |name,event|
			block.call name, event	
		end
	end

	Kernel.send :define_method, :each_setup do |&block|
		setups.each do |setup|
			block.call setup	
		end
	end
	
}.call


Dir.glob('*events.rb').each do |file|
	load file	
	each_event do |name,event|
		env = Object.new
		each_setup do |setup|
			env.instance_eval &setup	
		end
		puts "ALERT: #{name}" if env.instance_eval &event
	end
end


