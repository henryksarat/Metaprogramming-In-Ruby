def event(name,&block)
	@events[name] = block	
end

def setup(&block)
	@setups << block	
end
