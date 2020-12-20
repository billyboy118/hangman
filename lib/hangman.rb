# frozen_string_literal: false

require_relative 'player'
require_relative 'text'
require_relative 'game_methods'

Text.welcome == 'Yes' ? Text.load_screen : GameMethods.new_game





