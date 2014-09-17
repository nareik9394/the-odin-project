def getScenario
	puts "Which program do you want to run? (type the indices)"
	puts "1. English Number (up to thousand)"
	puts "2. English Number (up to million)"
	puts "3. Wedding Number"
	puts "4. bottles of beer... (in English Number)"

	input = gets.chomp.to_i
end

def runScenario input
	if input == 1
		puts englishNumber(-1, false, false)
	elsif input == 2
		puts englishNumber(-1, true, false)
	elsif input == 3
		weddingNumber
	elsif input == 4
		englishBottle
	else
		puts "You Cray"
	end
end

def englishNumber input, bool, needAnd
	number = [" one", " two", " three", " four", " five",
		" six", " seven", " eight", " nine"]
	number_tenth = [" ten", " twenty", " thirty", " forty", " fifty",
		" sixty", " seventy", " eighty", " ninety"]
	number_teen = [" eleven", " twelve", " thirteen", " fourteen", " fifteen",
		" sixteen", " seventeen", " eighteen", " nineteen"]

	result_str = ""

	if input == -1
		puts "Enter an integer:"
		input = gets.chomp.to_i	
	end

	if bool
		million = input / 1000000
		if million >= 10
			result_str = result_str + " " + englishNumber(million, bool, needAnd) + " million"
		elsif million != 0
			result_str = result_str + number[million - 1] + " million"
		end
		input = input % 1000000

		if needAnd and million > 0 and input != 0
			result_str = result_str + " and"
		end
	end

	thousand = input / 1000
	if thousand >= 10
		result_str = result_str + " " + englishNumber(thousand, bool, needAnd) + " thousand"
	elsif thousand != 0
		result_str = result_str + number[thousand - 1] + " thousand"
	end
	remainder = input % 1000

	if needAnd and thousand > 0 and remainder != 0
		result_str = result_str + " and"
	end

	hundred = remainder / 100
	if hundred != 0
		result_str = result_str + number[hundred - 1] + " hundred"
	end
	remainder = remainder % 100

	if needAnd and hundred > 0 and remainder > 10
		result_str = result_str + " and"
	end

	if remainder >= 11 and remainder <= 19
		ten = remainder % 10
		result_str = result_str + number_teen[ten - 1]
	else
		ten = remainder / 10
		if ten != 0
			result_str = result_str + number_tenth[ten - 1]
		end
		remainder = remainder % 10

		if remainder != 0 and !needAnd
			result_str = result_str + number[remainder - 1].sub(" ", "-")
		elsif remainder != 0
			result_str = result_str + " and" + number[remainder - 1]
		end
	end

	if result_str[0] == " " || result_str[0] == "-"
		result_str = result_str[1...result_str.length]
	end
	
	result_str
end

def weddingNumber
	puts "Enter an integer:"
	input = gets.chomp.to_i

	puts englishNumber(input, true, true)
end

def englishBottle
	puts "How many bottles are on the wall?"
	original = gets.chomp
	bottles_num = original.to_i

	bottle_singular = " bottle"
	bottle_plural = " bottles"
	bottle_string = bottle_plural

	bool = false
	if bottles_num > 1000000
		bool = true
	end

	while bottles_num != 0
		num_string = englishNumber(bottles_num, bool, false)
		puts num_string + bottle_string + " of beer on the wall, " + num_string + bottle_string + " of beer."

		bottles_num = bottles_num - 1

		num_string = englishNumber(bottles_num, bool, false)

		if bottles_num > 1
			bottle_string = bottle_plural
		else
			bottle_string = bottle_singular
		end

		if bottles_num == 0
			bottle_string = bottle_plural
			num_string = "no more"
		end

		puts "Take one down, pass it around, " + num_string + bottle_string + " of beer on the wall..."
	end

	puts "No more bottles of beer on the wall, no more bottles of beer"
	puts "Go to the store to buy some more, " + original + " bottles of beer on the wall..."
end

runScenario getScenario