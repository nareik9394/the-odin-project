def getScenario
	puts "Which program do you want to run? (type the indices)"
	puts "1. Grandfather Clock"
	puts "2. Program Logger"
	puts "3. Better Program Logger"

	input = gets.chomp.to_i
end

def runScenario input
	if input == 1
		puts "What does the grandfather clock sound like?"
		phrase = gets.chomp

		playSound = Proc.new do
			puts phrase
		end

		grandFatherClock playSound
	elsif input == 2
		programLogger
	elsif input == 3
		betterLogger
	else
		puts "You Cray"
	end
end

def grandFatherClock procs
	current_hour = Time.new.hour
	current_hour = current_hour.to_i

	if current_hour == 0
		current_hour = 12
	elsif current_hour > 12
		current_hour -= 12
	end

	current_hour.times do
		procs.call
	end
end

def log description, &block
	puts 'Beginning "' + description + '" . . .' 
	value_returned = block.call

	puts '. . . "' + description + '" finished, returning: ' + value_returned.to_s
end

$nesting_depth = 0
$tab = "\t"
def betterLog description, &block
	puts $tab * $nesting_depth + 'Beginning "' + description + '" ...'
	$nesting_depth = $nesting_depth + 1

	value_returned = block.call
	$nesting_depth = $nesting_depth - 1 

	puts $tab * $nesting_depth + '... "' + description + '" finished, returning: ' + value_returned.to_s
end

def programLogger
	log 'outer block' do
		log 'some little block' do
			log 'teeny-tiny block' do
				'lots of love'
			end
			42
		end
		log 'yet another block' do
			'I love Indian food!'
		end
		true
	end
end

def betterLogger
	betterLog 'outer block' do
		betterLog 'some little block' do
			betterLog 'teeny-tiny block' do
				'lots of love'
			end
			42
		end
		betterLog 'yet another block' do
			'I love Indian food!'
		end
		true
	end
end

runScenario getScenario