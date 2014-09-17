def substrings(words, subs)
	result_hash = Hash.new
	words = words.downcase.split

	subs.each do |sub|
		words.each do |word|
			if word.include?sub
				if result_hash[sub] == nil
					result_hash[sub] = 1
				else
					result_hash[sub] += 1
				end
			end
		end
	end

	return result_hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)