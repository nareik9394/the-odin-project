require './Game'

puts "The default size is set to 3. Do you want to change the size? (Y/N)"
input = gets.chomp.downcase == 'y' ? true : false

game = Game.new(input)
game.run