#show guesses left. 
#update display to reflect correct on incorrect guess if out of gueeses the player should lose
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
    dictionary = File.open('desk.txt', 'r')
    words = []
    
    dictionary.each_line do |word|
        words << word.chomp.downcase if word.length <= 12 && word.length >= 5
    end
    @secret_word << words.sample
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
      subbed = letter.gsub(/[^#{array_of_letters}]/, '_ ')
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
end

hangman = Hangman.new
hangman.random_word
hangman.display_word
loop do
hangman.guess_letter
end


