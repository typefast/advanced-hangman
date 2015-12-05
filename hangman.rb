#Show guessed letters in the word
#show list of incorrect letters
#show guesses left. 
#each turn allow the guess of a letter guess_letter
#update display to reflect correct on incorrect guess if out of gueeses the player should lose
class Hangman
  attr_reader :correct_letters, :incorrect_letters, :secret_word
  def initialize
    @correct_letters = []
    @incorrect_letters = []
    @secret_word = ''
  end
  
  def random_word
    dictionary = File.open('desk.txt', 'r')
    words = []
    
    dictionary.each_line do |word|
        words << word.chomp.downcase if word.length <= 12 && word.length >= 5
    end
    @secret_word << words.sample
  end
  
  def guess_letter
    puts "Guess a letter: "
    letter = gets.chomp.downcase
    correct_letter?(letter)
  end
  
  def correct_letter?(letter)
    if secret_word.include? letter
      puts "Nice"
    elsif !secret_word.include? letter
      puts "Unlucky"
    end
  end
end

hangman = Hangman.new
hangman.random_word
hangman.guess_letter



