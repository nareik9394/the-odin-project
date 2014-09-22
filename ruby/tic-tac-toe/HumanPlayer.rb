require './Player'

class HumanPlayer < Player
	def select!(board)
		board.print_board(true)
		puts "#{self.name}'s Turn..."
		puts "Input the square's number: "
		input = gets.chomp.to_i
	end
end