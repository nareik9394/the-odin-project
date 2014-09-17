def getScenario
	puts "Which program do you want to run? (type the indices)"
	puts "1. 99 bottles of beer on the wall"
	puts "2. Deaf Grandma"
	puts "3. Deaf Grandma, extended"
	puts "4. Leap Year Producer"

	input = gets.chomp.to_i
end

def runScenario input
	if input == 1
		lyricsPrinter
	elsif input == 2
		deafGrandma false
	elsif input == 3
		deafGrandma true
	elsif input == 4
		leapYear
	else
		puts "You Cray"
	end
end

def lyricsPrinter
	bottles_num = 99
	bottle_singular = " bottle"
	bottle_plural = " bottles"
	bottle_string = bottle_plural

	while bottles_num != 0
		num_string = bottles_num.to_s
		puts num_string + bottle_string + " of beer on the wall, " + num_string + bottle_string + " of beer."

		bottles_num = bottles_num - 1

		num_string = bottles_num.to_s

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
	puts "Go to the store to buy some more, 99 bottles of beer on the wall..."
end

def manageMemory array, sentence
	if array.length < 3
		array << sentence
	else
		array[0] = array[1]
		array[1] = array[2]
		array[2] = sentence
	end

	array
end

def deafGrandma extended
	memory = ["", "", ""]
	memory_extend = ["BYE", "BYE", "BYE"]

	sentence = ""
	flag = false

	if extended
		quit_condition = memory_extend
		compare_condition = [sentence]
	else
		quit_condition = "BYE"
		compare_condition = sentence
	end

	puts "You can talk to grandma now, what would you like to say to her?"
	sentence = gets.chomp

	while compare_condition != quit_condition
		if flag
			sentence = gets.chomp
		else
			flag = true
		end

		if extended
			compare_condition = manageMemory(compare_condition, sentence)
		else
			compare_condition = sentence
		end

		while sentence != sentence.upcase
			puts "Grandma: HUH?! SPEAK UP, SONNY!"
			sentence = gets.chomp

			if extended
				compare_condition = manageMemory(compare_condition, sentence)
			else
				compare_condition = sentence
			end
		end

		year = rand(21) + 1930
		if compare_condition != quit_condition
			puts "Grandma: NO, NOT SINCE " + year.to_s + "!"
		end
	end

	puts "Grandma: BYE SONNY! GREAT TALK!"
end

def leapYear
	puts "Input a start year:"
	start_year = gets.chomp.to_i
	puts "Input an end year:"
	end_year = gets.chomp.to_i

	while start_year <= end_year
		if start_year % 400 == 0
			puts start_year
		elsif start_year % 100 == 0
		elsif start_year % 4 == 0
			puts start_year
		end

		start_year = start_year + 1
	end
end

runScenario getScenario