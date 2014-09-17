class OrangeTree
	attr_accessor :alive, :age, :height, :growth_rate, :fruit_num, :total_fruit_picked, :total_fruit_grew,
				:adult_start, :adult_end, :avg_life, :death_rate, :min_fruit, :max_fruit

	def initialize
		@alive = true
		@age = 0
		@height = 0
		@growth_rate = 1
		@fruit_num = 0
		@total_fruit_picked = 0
		@total_fruit_grew = 0

		@adult_start = 3
		@adult_end = 25
		@avg_life = 32
		@death_rate = 0.3
		@min_fruit = 10
		@max_fruit = 20
	end

	def isAlive
		return @alive
	end

	def getHeight
		return @height
	end

	def printHeight
		puts "The height of the orange tree is " + getHeight.to_s + " feet tall"
	end

	def getAge
		return @age
	end

	def printAge
		puts "The orange tree is " + getAge.to_s + "-year-old"
	end

	def oneYearPasses
		@age += 1

		if @age >= @adult_start and @age <= @adult_end
			@growth_rate += 0.3
			@min_fruit *= 1.08
			@max_fruit *= 1.05

			if @min_fruit > @max_fruit
				@max_fruit = @min_fruit + 15
			end
		elsif @age >= @adult_end
			@growth_rate = 0
			@min_fruit *= 0.4
			@max_fruit *= 0.6

			if @max_fruit < 1
				@max_fruit = 2
			end
		end

		if @alive and @age >= @avg_life
			survive_rate = (Random.new).rand
			if survive_rate < @death_rate
				@alive = false
				height = 0
			else
				@death_rate *= 1.1
			end
		end

		if @alive
			@height += @growth_rate
			@fruit_num = 0

			puts "A year passes... "

			if @age >= @adult_start and @age <= @adult_end

				@fruit_num = (Random.new).rand(@min_fruit...@max_fruit).round
				@total_fruit_grew += @fruit_num
				puts @fruit_num.to_s + " oranges grew on the tree this year!!!"
			end
		else
			puts "The orange tree is dead. In its lifetime, it produced " + @total_fruit_grew.to_s + " oranges."
			puts @total_fruit_picked.to_s + " was picked during its lifetime."
		end
	end

	def countTheOranges
		puts "There are " + @fruit_num.to_s + " oranges on the tree"
	end

	def pickAnOrange
		if @fruit_num == 0
			puts "There are no more oranges to be picked! Wait for next year"
			return @fruit_num
		end

		@fruit_num -= 1
		@total_fruit_picked += 1
		puts "The orange you picked is delicious!"
		return @fruit_num
	end
end

def getScenario
	puts "What is your next action? (type the indices)"
	puts "\t1. Check the age of the orange tree"
	puts "\t2. Check the height of the orange tree"
	puts "\t3. Count the oranges"
	puts "\t4. Pick an orange"
	puts "\t5. Wait for next year"

	input = gets.chomp.to_i
end

def runScenario object, input
	if input == 1
		object.printAge
	elsif input == 2
		object.printHeight
	elsif input == 3
		object.countTheOranges
	elsif input == 4
		object.pickAnOrange
	elsif input == 5
		object.oneYearPasses
	else
		puts "Enter your choices again:"
		input = gets.chomp.to_i
		runScenario(object, input)
	end
end

tree = OrangeTree.new

while tree.isAlive
	runScenario(tree, getScenario)
end