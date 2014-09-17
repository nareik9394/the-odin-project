def inRange?(num)
	upcase_range = ('A'.ord..'Z'.ord)
	downcase_range = ('a'.ord..'z'.ord)

	result = upcase_range.include?(num) || downcase_range.include?(num)

	return result
end


def caesar_cipher(input="What a string!", key=5)
	break_down = input.split("")
	key %= 26
	result_array = []

	break_down.each do |char|
		char = char.ord

		if inRange?(char)
			if inRange? (char+key)
				char += key
			else
				char -= (26-key)
			end
		end

		result_array << char.chr
	end

	puts result_array.join
end

caesar_cipher
caesar_cipher("Lorem Ipsums", 13)