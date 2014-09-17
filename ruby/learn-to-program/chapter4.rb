def getName
	puts "What is your first name?"
	first_name = gets.chomp
	puts "What is your middle name?"
	middle_name = gets.chomp
	puts "What is your last name?"
	last_name = gets.chomp

	result = ["Hi", first_name, middle_name, last_name]
end

def getNumber
	puts "What is your favorite number?"
	fav_num = gets.chomp.to_i
end

def printNumber input
	puts "Your favorite number " + input.to_s + " is nice, however " + (input + 1).to_s + " is bigger and better."
end

puts getName.join(" ")

printNumber getNumber
