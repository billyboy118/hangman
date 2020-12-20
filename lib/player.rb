# frozen_string_literal: false

require 'json'
require_relative 'game_methods'
require_relative 'text'
require_relative 'game_logic'

# this class will define the player and create an object to save
class Player
  attr_accessor :word_to_guess, :current_progress, :lives_lost, :incorrect_letters, :name

  include GameMethods
  include Text
  include GameLogic

  def initialize(name, word, arr)
    @name = name
    @lives_lost = 0
    @word_to_guess = word
    @guess_string = ''
    @letter_guesses = []
    @current_progress = arr
    @incorrect_letters = []
  end

  def letter_guess(letter)
    @letter_guesses.push(letter)
    calc_letters
    @lives_lost = 99 if @current_progress == @word_to_guess
  end

  def word_guess(word)
    @lives_lost = 99 if word.split('') == @word_to_guess
    @lives_lost += 1 if word.split('') != @word_to_guess
  end

  def to_json
    JSON.dump({
      name: @name,
      lives_lost: @lives_lost,
      word_to_guess: @word_to_guess,
      guess_string: @guess_string,
      letter_guesses: @letter_guesses,
      current_progress: @current_progress,
      incorrect_letters: @incorrect_letters
    })
  end

  def from_json(response)
    data = JSON.load response
    @name = data['name']
    @lives_lost = data['lives_lost']
    @word_to_guess = data['word_to_guess']
    @guess_string = data['guess_string']
    @letter_guesses = data['letter_guesses']
    @current_progress = data['current_progress']
    @incorrect_letters = data['incorrect_letters']
    introduction_load
  end
end
