require './Player'

class AI < Player
	def select!(board)
		board.print_board(true)
		puts "#{self.name}'s Turn..."
		size = board.size

		begin
			input = 1 + rand(size * size - 1)
		end while board.occupied?(input-1)

		puts "Computer selects location #{input}"
		input
	end
end