# frozen_string_literal: false

require_relative 'game_methods'
require 'tty-prompt'

# text methods
module Text
  def self.welcome
    GameMethods.clear
    prompt = TTY::Prompt.new
    greeting = 'Hello and welcome to hangman, would you like to load a previous game?'
    choices = %w[Yes No]
    prompt.select(greeting, choices)
  end

  def self.introduction_msg
    GameMethods.clear
    puts 'Okay then lets play some hangman, a quick brief before you start.'
    puts "\u2022 On your sixth incorrect guess the game will be over"
    puts "\u2022 At any point during the game you can guess the word"
    puts ''
    puts 'The computer has picked their word, lets play.'
    puts ''
    sleep 3
  end

  def introduction_load
    GameMethods.clear
    puts 'Progress of loaded game:'
    puts ''
    puts "Word progress: #{@current_progress.join(' ')}"
    puts ''
    puts "Lives lost: #{@lives_lost}"
    puts ''
    puts "Misses: #{@incorrect_letters.join(',')}"
    puts ''
  end

  def self.choice 
    prompt = TTY::Prompt.new
    greeting = 'Whats would you like to do?'
    choices = ['Guess a letter', 'Guess a word', 'Save the game']
    case prompt.select(greeting, choices)
    when 'Guess a letter' then 'letter'
    when 'Guess a word' then 'word'
    end
  end

  def self.letter_guess
    puts 'Please type the letter you would like to guess? Case does not matter!'
    while (position = gets.chomp).downcase
      return position if position.length == 1

      puts 'please select 1 letter '
    end
  end

  def self.word_guess(player)
    puts 'Please type the word would you like to guess? Case does not matter.'
    puts "The word should be #{player.word_to_guess.length} characters."
    while (position = gets.chomp.downcase)
      return position if position.length == player.word_to_guess.length

      puts "The word should be #{player.word_to_guess.length} characters. Please try again"
    end
  end

  def self.results(player)
    GameMethods.clear
    puts "Your results after that guess are: #{player.current_progress.join(' ')}"
    puts ''
    puts "Lives lost: #{player.lives_lost}"
    puts ''
    puts "Misses: #{player.incorrect_letters.join(',')}"
  end

  def self.win_msg(player)
    GameMethods.clear
    puts 'Well done you have won and not been hung!'
    puts "The  word was: #{player.word_to_guess.join('')}."
  end

  def self.loose_msg(player)
    GameMethods.clear
    puts 'You have been hung, you are no more!'
    puts "The word was: #{player.word_to_guess.join('')}."
  end

  def self.post_game
    prompt = TTY::Prompt.new
    greeting = 'Whats would you like to do now?'
    choices = ['Load a game', 'Play again', 'Exit']
    case prompt.select(greeting, choices)
    when 'Play again' then GameMethods.new_game
    when 'Load a game' then load_sreen
    when 'Exit' then exit
    end
  end

  def self.save_decision
    GameMethods.clear
    prompt = TTY::Prompt.new
    greeting = 'Game has been saved, what would you like to do now?'
    choices = ['Carry on playing', 'Load a previous game', 'Exit']
    case prompt.select(greeting, choices)
    when 'Carry on playing' then 'carry'
    when 'Load a previous game' then load_screen
    when 'Exit' then exit
    end
  end

  def self.load_screen
    return puts 'No games to load' if Dir.glob('*.txt').length.zero?

    prompt = TTY::Prompt.new
    greeting = 'Which game would you like to load?'
    choices = Dir.glob('*.txt')
    response = prompt.select(greeting, choices)
    GameMethods.load_game(response)
  end
end
