# frozen_string_literal: false
require 'json'
require_relative 'player'
require_relative 'text'
require_relative 'save_load'

# general game methods
module GameMethods
  def self.clear
    print "\e[2J\e[f"
  end

  def self.word_generator
    while
      word = File.open('lib/5desk.txt').each_line.take(rand(61_406)).last.chomp
      if word.length < 3 || word.length > 10
        ''
      else
        return word.downcase.split('')
      end
    end
  end

  def self.new_game
    puts 'New game it is then!'
    sleep 2
    word = word_generator
    arr = fill_array(word)
    player = Player.new('player1457', word, arr)
    Text.introduction_msg
    play_loop(player)
  end

  def self.load_game(response)
    puts 'Game loaded!'
    sleep 2
    response = File.open(response, 'r')
    player = Player.new('player1457', '', '')
    player.from_json(response)
    play_loop(player)
  end

  def self.play_loop(player) # rubocop:disable Metrics/MethodLength
    while player.lives_lost < 6
      selections(player)
      case player.lives_lost
      when 6
        looser(player)
      when 99
        winner(player)
      else
        Text.results(player)
      end
    end
  end

  def self.selections(player)
    case Text.choice
    when 'letter'
      player.letter_guess(Text.letter_guess)
    when 'word'
      player.word_guess(Text.word_guess(player))
    else
      SaveLoad.save_game(player)
      Text.save_decision
    end
  end

  def self.fill_array(word)
    arr = []
    count = word.length
    count.times do
      arr.push('_')
    end
    arr
  end

  def self.winner(player)
    Text.win_msg(player)
    Text.post_game
  end

  def self.looser(player)
    Text.loose_msg(player)
    Text.post_game
  end
end
