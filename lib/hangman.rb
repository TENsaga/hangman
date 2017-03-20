#    ____
#   |    |
#   |  (x_x)
#   |   ~~~
#   |   /|\
#   |    |
#   |   / \
#  _|_
# |   |______
# |          |
# |__________|

class Hangman
  attr_accessor :guesses, :misses, :incorrect, :word

  def initialize(word = "", options = {})
    @guesses = options[:guesses] || []
    @misses = options[:misses] || []
    @word = select_word(word).split("")
    @word.length.times { @guesses << "_" } if @guesses.empty?
    @incorrect = 0
  end

  def select_word(word)
    while word == ""
      word = File.readlines("/Users/cswanson/Dropbox/coding/ruby/hangman/5desk.txt").sample.strip.downcase
    end
    word.length < 7 || word.length > 14 ? select_word("") : word
  end

  def letter_correct?(letter)
    @word.include?(letter) ? true : false
  end

  def win?
    @guesses == @word ? true : false
  end

  def update_guesses(letter)
    print "\n\t\"#{letter}\" is in the word!\n"
    @word.each_with_index.select { |l, i| @guesses[i] = l if l == letter }
  end

  def update_misses(letter)
    print "\n\t\"#{letter}\" is incorrect..\n"
    @misses << letter
    @incorrect += 1
  end

  def save(game, filename)
      puts "\nSaving Game..."
      File.open(filename, 'w') do |f|
          f.print Marshal.dump(game)
      end
      puts "\n\t*Game Saved\n"
  end

  def load(filename)
      puts "\noading Game..."
      game = Marshal.load(File.open(filename, 'r'))
      @word = game.word
      @guesses = game.guesses
      @misses = game.misses
      @incorrect = game.incorrect
      puts "\n\t*Game Loaded\n"
  end

  def set_letter(letter)
    letter_correct?(letter) ? update_guesses(letter) : update_misses(letter)
  end

  def display_status
    print "\nCorrect Guesses = #{@guesses}\n"
    print "Incorrect Guess = #{@misses} (Total: #{@incorrect})\n\n"
  end

end
