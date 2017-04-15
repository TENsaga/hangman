require_relative 'hangman.rb'

class Engine
  def initialize
    @hang = Hangman.new
  end

  def play
    while @hang.win? == false && @hang.incorrect != 8
      @hang.display_status
      set_choice(take_choice, @hang)
      @hang.set_letter(take_letter)
    end

    if @hang.win?
      print "\n\t*You Win!\n"
      print "\n\t\"#{@hang.word.join}\"\n"
    else
      print "\n\t*You Lose!\n"
      print "\n\tThe correct word was: \t\"#{@hang.word.join}\"\n"
    end

    @hang.display_status
  end

  def check_guess(letter)
    err_msg = "\t\nYour guess must contain a single letter between A and Z\n"
    raise err_msg unless letter =~ /^[A-Za-z]{1}$/
  end

  def check_choice(choice)
    err_msg = "\t\nYour guess must be option Enter, 1, or 2\n"
    raise err_msg unless choice =~ /^[1-2]{1}$/ || choice == ""
  end

  def take_choice
    begin
      print "(Enter) Guess : (1) Save : (2) Load\n> "
      choice = $stdin.gets.chomp
      check_choice(choice)
    rescue => e
      puts e
      retry
    end
    choice
  end

  def set_choice(choice, game)
    case choice
    when "" then return
    when "1"
      print "\nName of save file?\n> "
      game.save(game, $stdin.gets.chomp)
    when "2"
      puts Dir.entries(".").select { |f| f =~ /.json/ }
      print "\nChoose a save file:\n> "
      game.load($stdin.gets.chomp)
    end
    game.display_status
  end

  def take_letter
    begin
      print "\tYour guess?\n> "
      guess = $stdin.gets.chomp
      check_guess(guess)
    rescue => e
      puts e
      retry
    end
    guess
  end
end
