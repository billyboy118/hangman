# frozen_string_literal: false

require_relative 'player'

# module used for saving and loading games
module SaveLoad
  def self.save_game(player)
    puts 'What would you like to save your game as?'
    save_name = gets.chomp
    File.open("#{save_name}.txt", 'w') do |file|
      file.write player.to_json
    end
  end

end
