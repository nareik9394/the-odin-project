class Cell
	attr_reader :status

	def initialize
		@status = nil
	end

	#Three methods of input
	#  1. numerial input (0 - O, 1 - X)
	#  2. string input ("x/X", "o/O")
	#  3. boolean input (false - O, true - X)
	#return nil if wrong input type
	def set_status(input)
		if input.is_a?(Integer)
			@status = input == 0 ? 'O' : 'X'
		elsif input.is_a?(String)
			@status = input.downcase == "o" ? 'O' : 'X'
		elsif input.is_a?(TrueClass) || input.is_a?(FalseClass)
			@status = input ? 'O' : 'X'
		else
			return nil
		end
	end

	def empty?
		return @status ? false : true
	end
end