# frozen_string_literal: false

# method for player class to call on when checking letters/words
module GameLogic
  def calc_letters
    life = false
    @word_to_guess.each_with_index do |letter, index|
      (@current_progress[index] = letter) && (life = true) if letter == @letter_guesses[@letter_guesses.length - 1]
    end
    @lives_lost += 1 if life == false
    @incorrect_letters.push(@letter_guesses[@letter_guesses.length - 1]) if life == false
  end
end
