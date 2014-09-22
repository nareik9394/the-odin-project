class Player
	attr_reader :side, :name

	def initialize(side, name)
		@side = side
		@name = name
	end
end