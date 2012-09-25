def combine_anagrams(words)
	res = {}
	words.each do |item|
		mySorted = item.downcase.chars.sort.join
		if !res.has_key?(mySorted)
			res[mySorted] = []
		end

		res[mySorted] = res[mySorted].push(item)

	end
	myFinal = []
	res.each {|key, value| myFinal.push(value)}
	myFinal
end