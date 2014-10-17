require "yaml"

def generate_secret_word
  @dictionary = []
  File.open("5desk.txt").each do |line|
    @dictionary << line if line.length >= 5 and line.length <= 12
  end
  @dictionary.sample.chomp.downcase
end


def play_wrapper
  puts "Welcome to Hangman!"
  input = nil
  until input == "load" or input == "start"
    puts "Would you like to LOAD your game or START a new game?  (Type LOAD to load or START to start)"
    input = gets.chomp.downcase
    puts "That input was not valid." unless input == "load" or input == "start"
    load_game!() if input == "load"
    start_game() if input == "start"
  end
end


def start_game
  puts "Welcome to Hangman!"
  @secret_word = generate_secret_word()
  @display_word = "_ " * @secret_word.length
  @correct_guesses = []
  @wrong_guesses = []
  @lives = 6
  @won = false
  update_gamestate!
  turn()
end


def update_gamestate!
  @gamestate = {
    secret_word: @secret_word, 
    display_word: @display_word,
    correct_guesses: @correct_guesses,
    wrong_guesses: @wrong_guesses,
    lives: @lives,
    won: @won
  }
end


def propogate_gamestate!
  @secret_word = @gamestate[:secret_word]
  @display_word = @gamestate[:display_word]
  @correct_guesses = @gamestate[:correct_guesses]
  @wrong_guesses = @gamestate[:wrong_guesses]
  @lives = @gamestate[:lives]
  @won = @gamestate[:won]
end


def turn
  display(@lives)

  validated = false
  until validated == true
    puts "Guess a letter in the word..."
    puts "(or type AI to have the computer guess, or SAVE to save game)..."
    print "> "
    letter = gets.chomp.downcase
    if letter == "save" or letter == "ai" or (letter =~ /^[a-z]+$/i and letter.length == 1)
      validated = true
    else
      puts "That input wasn't a letter!"
    end
  end

  if letter == "save"
    save_game!()
  elsif letter == "ai"
    ai()
  else
    check_letter!(letter)
  end
end


def display lives
  puts ""
  puts " O " if @lives >= 1
  puts " |" if @lives == 2
  puts "-|" if @lives == 3
  puts "-|-" if @lives >= 4
  puts "/" if @lives == 5
  puts "/ \\" if @lives == 6
  puts "(#{@lives} fails left.)"

  guess_str = @wrong_guesses.join(", ")
  puts "Wrong guesses: #{guess_str}"

  puts ""
  puts @display_word
  puts ""
end


def check_letter! letter
  found = false
  @secret_word.split("").each_with_index do |sLetter, index|
    if sLetter == letter
      @display_word[index*2] = letter 
      found = true
    end
  end

  if found == true
    puts "Yay!  That letter was in the secret word!  You get to live... for now."
    @correct_guesses << letter
  else
    puts "That letter was not in the secret word.  Off with a body part..."
    @lives -= 1
    @wrong_guesses << letter
  end

  win! if !@display_word.split("").include? "_"
  if @lives == 0
    lose()
  elsif @won == false
    turn()
  end
end


def lose
  display(@lives)
  puts ""
  puts "You lose! :("
  puts "The secret word was #{@secret_word.upcase}."
  puts ""
  play_again()
end


def win!
  display(@lives)
  puts ""
  puts "You win!  The secret word was indeed #{@secret_word.upcase}!"
  puts ""
  @won = true
  play_again()
end


def play_again
  input = nil
  until input == "y" or input == "n"
    print "Play again? (Y for yes, N for no.) > "
    input = gets.chomp.downcase
    puts "That input was not valid." unless input == "y" or input == "n"
    start_game() if input == "y"
  end
end


def save_game!
  update_gamestate!
  yaml = YAML::dump(@gamestate)
  File.open("save.yaml", "w") do |f|
    f.puts yaml
  end
  puts "SAVE captured."
  puts "Open this file again to have the option to LOAD."
end


def load_game!
  if File.exist?("save.yaml")
    f = File.open("save.yaml")
    yaml = f.read()
    f.close
    @gamestate = YAML::load(yaml)
    propogate_gamestate!
    puts "LOAD captured.  File loaded."
    turn()
  else
    puts "Save file does not exist or is corrupted.  Could not load."
  end
end


def ai
  blanks = @display_word.split("").count { |letter| letter == "_" }
  puts blanks

  possible_words = []
  @dictionary.each do |word|
    word_r = word.downcase.chomp
    if word_r.length == @secret_word.length
      negatives = word_r.split("").count { |letter| @wrong_guesses.include? letter }
      
      positives = 0
      word_r.split("").each_with_index do |letter, index|
        positives += 1 if word_r[index] == @display_word[index*2]
      end

      possible_words << word_r if negatives == 0 and positives == @secret_word.length - blanks
    end
  end


  if possible_words.length > 50
    puts "I would display all the words I am thinking of, but there are #{possible_words.length.to_s} of them -- too many to display."
  else
    print "I am considering the following words: "
    print possible_words.join(", ")
    print "."
    puts ""
  end


  letter_count = Hash.new(0)
  possible_words.each do |word|
    word.split("").each do |letter|
      letter_count[letter] += 1
    end
  end

  sort_letter_count = letter_count.sort_by { |key, value| value }  
  found_guess = false
  i = 1
  until found_guess == true
    try = sort_letter_count[-i][0]
    if !@correct_guesses.include? try and !@wrong_guesses.include? try
      puts "I will guess #{try.upcase}"
      check_letter! try
      found_guess = true
    end
    i += 1
  end
end


play_wrapper()