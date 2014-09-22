require './Board'
require './Player'
require './HumanPlayer'
require './AI'

class Game
	attr_accessor :player, :other_player, :end_condition

	def initialize(can_change=false, board_size=3)
		board_size = start_screen(can_change)
		@board = Board.new(board_size)

		#to-do: AI
		#if board_size == 3
		allow_ai = ai_screen
		#else
		#	allow_ai = false
		#end

		init_players(allow_ai)

		@end_condition = nil
	end

	def run
		play = true
		#start the game by showing an empty board with numbers
		#show whose turn it is
		#show input choices
		#get the input on the board
		#update the board and check winning condition
		# => if win, output board and win message
		# => else, change sides and continue
		begin
			begin
				#print_header
				input = @player.select!(@board)
				check_input = process_input(input)
				@end_condition = end?(check_input)
				@end_condition ? break : switch_sides
			end while true

			process_end
			play = gets.chomp.downcase == 'y' ? true : false
			restart if play
		end while play

		puts "Good bye!! Hope you had fun!!"
	end

	private
	def init_players(allow_ai)
		if allow_ai
			odds = rand()
			if odds <= 0.5
				@player = AI.new('X', "Computer")
				@other_player = HumanPlayer.new('O', "Player")
			else
				@player = HumanPlayer.new('X', "Player")
				@other_player = AI.new('O', "Computer")
			end
		else
			@player = HumanPlayer.new('X', "Player X")
			@other_player = HumanPlayer.new('O', "Player O")
		end
	end

	def start_screen(change)
		puts "Welcome to Tic-Tac-Toe!!"

		return 3 unless change

		puts "What is the size of the board? (at least 3 for 3x3, range 3 to 10)"
		input = gets.chomp.to_i

		while input < 3 && input > 10
			puts "Invalid input, please enter again: (3 to 10)"
			input = gets.chomp.to_i
		end

		input
	end

	def ai_screen
		puts "Do you want an AI? (Y/N)"
		input = gets.chomp.downcase == 'y' ? true : false
	end

	#def print_header
	#	@board.print_board(true)
	#	puts "#{@player.name}'s Turn..."
	#end

	def process_input(input)
		begin
			result = @board.mark_cell(@player.side, input-1)
			unless result
				puts "Invalid input! Please enter again!" 
				#print_header
				input = @player.select!(@board)
			end
		end until result

		result
	end

	def process_end
		puts "Error: End Condition Not Set!" unless @end_condition

		case @end_condition
		when 0
			puts "It is a tie!!!"
		when 1
			puts "#{@player.name} won!!"
			@board.print_board
		else
			puts "Error: process_end method case #{a}"
		end

		puts "Do you want another game? (Y/N)"
	end

	def end?(array)
		for i in array
			return 1 if can_win?(i)
		end

		#when no win and full board => tie game
		if @board.full?
			return 0
		end

		nil
	end

	def can_win?(line)
		if line_full?(line)
			model = @board.get(line[0])
			counter = 1
			while counter < line.length
				return false if model != @board.get(line[counter])

				counter += 1
			end

			return true
		end

		false
	end

	def line_full?(line)
		for i in line
			return false unless @board.get(i)
		end

		true
	end

	def switch_sides
		@player, @other_player = @other_player, @player
	end

	def restart(board_size=3)
		initialize(board_size)
	end
end