require 'yaml'
class Hangman
  attr_reader :correct_letters, :incorrect_letters, :secret_word
  attr_accessor :guesses
  def initialize
    @correct_letters = []
    @incorrect_letters = []
    @secret_word = ''
    @guesses = 10
  end
  
  def random_word
    dictionary = File.open('desk.txt', 'r') {|file| file.read }
    random_words = dictionary.split.select { |word| word.length.between?(5,12) }
    @secret_word << random_words.sample.downcase
  end
  
  def display_word
    word = @secret_word
    blank_word = word.gsub(/[a-z]/, ' _')
    
    puts "The word is #{word.length} characters in length."
    puts "#{blank_word}"
  end
  
  def display_updated_word(word, array_of_letters)
    subbed_word = []
    word.split('').each do |letter|
      #change
      if array_of_letters.empty?
      subbed = letter.gsub(/[a-z]/, '_ ')
      else
      subbed = letter.gsub(/[^#{array_of_letters}]/, '_ ')
      end
      subbed_word << subbed
    end
    puts subbed_word.join(' ')
    subbed_word
  end
  
  def guess_letter
    list_incorrect_letters
    puts "Guess a letter: "
    letter = gets.chomp.downcase
    correct_letter?(letter)
    display_updated_word(@secret_word, @correct_letters)
    no_guesses?
    won?
  end
  
  def correct_letter?(letter)
    if secret_word.include? letter
      puts "Nice"
      correct_letters << letter
    elsif !secret_word.include? letter
      puts "Unlucky"
      incorrect_letters << letter
      reduce_guesses
    end
  end
  
  def list_incorrect_letters
    puts "The incorrect letters you have guessed are: "
    puts @incorrect_letters.join(' ')
  end
  
  def reduce_guesses
    @guesses = @guesses - 1
    puts "You have #{@guesses} guesses left."
  end
  
  def won?
    secret_word_array = @secret_word.split('')
    if (secret_word_array - @correct_letters).empty?
      puts "Winner!"
      puts "You guessed #{@secret_word}"
      exit(0)
    end
  end
  
  def no_guesses?
    if @guesses == 0
      puts "Unlucky friend, better luck next time!"
      puts "You ran out of guesses!"
      puts "The word was actually: #{@secret_word}"
      exit(0)
    end
  end
end

class Saved
  def save_game(hangman_game)
    yaml = YAML::dump(hangman_game)
    saved_file = File.open('saved_game.yaml', 'w')
    saved_file.write(yaml)
  end
  
  def load_game
    game = File.open('saved_game.yaml', 'r')
    yaml = game.read
    YAML::load(yaml)
  end
end

hangman = Hangman.new
hangman.random_word
hangman.display_word
loop do
  puts "What do you want to do?"
  puts "1. save the game, 2.load a game 3.guess a letter 4. Exit"
  action = gets.chomp
  case action
  when "1"
    saved = Saved.new
    saved.save_game(hangman)
  when "2"
    saved = Saved.new
    hangman = saved.load_game
  when "3"
    hangman.guess_letter
  when "4" 
    exit(0)
  end
end


