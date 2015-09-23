require "pry"
require "set"

word_list = [
  "chicken", "duck", "dog", "cat", "clown",
  "brick", "bananas", "totalitarianism",
  "coffee", "metacircular", "interpreter",
  "wednesday", "ruby", "evaluation", "consternation",
  "chicanery"
]

MAX_TURNS = 6
answer = word_list.sample


def greeting
  puts "Welcome to the game of Hangman!\n\n"
  puts "I'm not even gonna explain it."
  puts "Just guess letters dummy."
end

def game_over?(answer, current_guess)
  turns_left(current_guess, answer).zero? || win?(answer, current_guess)
end

def show_progress(partial_word, answer, current_guess)
  turns_remaining = turns_left(current_guess, answer)
  puts
  puts "The current word is: #{partial_word}"
  puts "You have #{turns_remaining} guesses left."
end

def prompt_player
  puts
  puts "Please guess a letter: "
  letter = gets.chomp

  until ('a'..'z').to_a.include?(letter)
    puts "#{letter} is not a single lowercase letter. Please guess again: "
    letter = gets.chomp
  end
  letter
end

def make_partial(current_guess, answer)
  # blank a letter in the answer if it isn't in the guesses
  answer.chars.map do |letter|
    if current_guess.include?(letter)
      letter
    else
      "-"
    end
  end
end

def take_turn(current_guess, answer)
  partial_word = make_partial(current_guess, answer).join
  show_progress(partial_word, answer, current_guess)
  prompt_player
end

def win?(answer, current_guess)
  answer_set = answer.chars.to_set
  # guesses.superset?(answer_set)
  current_guess >= answer_set
end

def postmortem(answer, current_guess)
  if win?(answer, current_guess)
    puts "Nice work! You win."
  else
    puts "The word was #{answer}. Better luck next time."
  end
end

def turns_left(current_guess, answer)
  answer_set = answer.chars.to_set
  wrong_guesses = current_guess.difference(answer_set).count
  # wrong_guesses = guesses.difference(answer_set).count
  MAX_TURNS - wrong_guesses
end
  def get_player_name(player)
    puts  player + " please enter your name: "
    gets.chomp
  end

def hangman(answer)
  player_1 = get_player_name("Player 1")
  player_2 = get_player_name("Player 2")
  guesses_1 = Set.new
  guesses_2 = Set.new

  current_player = player_1
  current_guess = guesses_1
  greeting
  until game_over?(answer, current_guess)
    guess = take_turn(current_guess, answer)
    current_guess.add(guess)
    if current_player == player_1
      puts "\n\n#{player_2}'s turn." 
      current_player = player_2
      current_guess = guesses_2
    else current_player = player_1
      puts "#\n\n#{player_1}'s turn."
      current_guess = guesses_1
    end
  end
  postmortem(answer, current_guess)
end

def play_again?
  puts "Would you like to play again? (y/n)"
  gets.chomp
end

def play_hangman(words)
  answer = words.sample
  hangman(answer)
end

def play(words)
  play_hangman(words)
  choice = play_again?
  until choice == "n"
    play_hangman(words)
    choice = play_again?
  end
end

play(word_list)