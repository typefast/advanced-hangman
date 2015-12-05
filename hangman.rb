#load in the dictionary and randomly select a word between 5 and 12 characters long (secret_word)
#Show guessed letters in the word
#show list of incorrect letters
#show guesses left. 
#each turn allow the guess of a letter guess_letter
#update display to reflect correct on incorrect guess if out of gueeses the player should lose
class Hangman
  
  def random_word
    dictionary = File.open('desk.txt', 'r')
    words = []
    
    dictionary.each_line do |word|
        words << word.chomp.downcase if word.length <= 12 && word.length >= 5
    end
    words.sample
  end
  
  def guess_letter
  end
end

hangman = Hangman.new
secret_word = hangman.random_word
puts secret_word