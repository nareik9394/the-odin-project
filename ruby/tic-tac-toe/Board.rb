require './Cell'

class Board
	attr_reader :size, :cells, :lines

	def initialize(size=3)
		#create an empty board, using 1-d arrays
		@size = size
		#@cells = Array.new(size*size)
		@cells = Array.new(size*size) { |i| i = Cell.new }
		@lines = {}
		generate_lines
	end

	def get(loc)
		@cells[loc].status
	end

	def occupied?(loc)
		@cells[loc].empty? ? false : true
	end

	#mark the cell, return the sets of lines for the game logic to check
	#loc's range is [0, @size*@size)
	#return nil if the location has been marked
	def mark_cell(side, loc)
		#if @cells[loc]
		#	return nil
		#else
		#	@cells[loc] = side
		#	get_sets(loc)
		#end

		if @cells[loc].empty?
			@cells[loc].set_status(side)
			get_sets(loc)
		else
			return nil
		end
	end	

	def empty?
		for i in @cells
			return false unless i.empty?
		end
		return true
	end

	def full?
		for i in @cells
			return false if i.empty?
		end
		true
	end

	#output function
	def print_board(style=false)
		piece = "|---"
		piece += "--" if @size > 3

		border = piece * @size + "|\n"
		result =  "Current Board:\n"
		result += border

		counter = 0
		while counter < @cells.length
			item = @cells[counter].status
			if style
				item ||= "#{counter+1}"
			else
				item ||= " "
			end

			if @size == 3
				result += "| #{item} "
			elsif counter+1 < 10 || item == 'X' || item == 'O'
				result += "|  #{item}  "
			elsif item != " "
				result += "|  #{item} "
			else counter+1 > 9
				result += "|  #{item}  "
			end

			if (counter + 1) % @size == 0
				result += "|\n" + border
			end

			counter += 1
		end

		puts result
	end

	private
	def generate_lines
		horizontals = []
		verticals = []
		for i in 0...@size
			horizontals[i] = Array.new(@size) { |j| i * @size + j }
			verticals[i] = Array.new(@size) { |j| i + j * @size }
		end

		forward_slash = Array.new(@size) { |i| i + i * @size }
		backward_slash = Array.new(@size) { |i| @size + i * (@size - 1) - 1 }

		@lines[:horizontal] = horizontals
		@lines[:vertical] = verticals
		@lines[:diagonal] = [forward_slash, backward_slash]
	end

	#@lines is a hash, keywords are horizontal, vertical, and diagonal
	#each consists of according lines
	#loc's range is [0, @size*@size)
	def get_sets(loc)
		sets = []
		sets << sets_helper(:horizontal, loc)
		sets << sets_helper(:vertical, loc)

		for i in @lines[:diagonal]
			if i.include?(loc)
				sets << i
			end
		end

		sets
	end

	def sets_helper(sym, loc)
		for i in @lines[sym]
			if i.include?(loc)
				return i
			end
		end
	end
end