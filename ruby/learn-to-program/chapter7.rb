def getScenario
	puts "Which program do you want to run? (type the indices)"
	puts "1. Word array (with sort)"
	puts "2. Word array (without sort)"
	puts "3. Table of Contents"

	input = gets.chomp.to_i
end

def runScenario input
	if input == 1
		sortedArray true
	elsif input == 2
		sortedArray false
	elsif input == 3
		tableContents
	else
		puts "You Cray"
	end
end

def sortedInput array, word
	size = array.length

	if size == 0
		array.push word
	elsif size == 1
		if array[0] < word
			array.push word
		else
			temp = array[0]
			array[0] = word
			array.push temp
		end
	else
		i = 0
		added = false
		while i < size
			if array[i] >= word
				while size > i
					array[size] = array[size-1]
					size = size - 1
				end
				array[i] = word
				added = true
			end
			i = i + 1
		end

		if !added
			array.push word
		end
	end

	array
end

def sortedArray useSort
	array = []
	word = "word"

	puts "Please type as many words per line then press the Enter Key."
	puts "When you are finished press the Enter Key without typing anything."

	while word != ""
		word = gets.chomp
		if useSort
			array.push(word)
		else
			sortedInput(array, word)
		end
	end

	if useSort
		puts array.sort
	else
		puts array
	end
end

def tableContents
	toc = ["Table of Contents","Chapter 1: Getting Started", "page 1", 
	"Chapter 2: Numbers", "page 9", "Chapter 3: Letters", "page 13"]

	line_width = 60

	i = 0
	puts(toc[0].center(line_width))
	puts ""
	# loop to define when to stop putting lines for the contents.
	until i == 6
		puts(toc[i += 1].ljust(line_width/2) + toc[i += 1].rjust(line_width/2))
	end
end

runScenario getScenario