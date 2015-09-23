require "pry"

replay = "yes"
until replay == "no"

puts "Input your own word? yes or no"
input = gets.chomp
unless input == "no"
puts "Input your word: "
word_list = gets.chomp.downcase
answer = word_list
else
word_list = [
  "chicken", "duck", "dog", "cat", "clown",
  "brick", "bananas", "totalitarianism",
  "coffee", "metacircular", "interpreter",
  "wednesday", "ruby", "evaluation", "consternation",
  "chicanery"
] 
answer = word_list.sample
end

turn_count = 6


def greeting
  puts "\nWelcome to the game of Hangman!\n\n"
  puts "I'm not even gonna explain it."
  puts "Just guess letters dummy."
end

def game_over?(turn_count, answer, guesses)
  turn_count == 0 or win?(answer, guesses)
end

def show_progress(turn_count, partial_word)
  puts
  puts "The current word is: #{partial_word}"
  puts "You have #{turn_count} guesses left."
end

def prompt_player(guesses)
  puts
  puts "Please guess a letter: "
  guess = gets.chomp
  while guesses.include?(guess) || !('a'..'z').to_a.include?(guess)
    puts "#{guess} is not a letter or already guessed. Please guess again: "
    guess = gets.chomp
  end
  guess
end

def make_partial(guesses, answer)
  # blank a letter in the answer if it isn't in the guesses
  answer.chars.map do |letter|
    if guesses.include?(letter)
      letter
    else
      "-"
    end
  end
end

def take_turn(turn_count, guesses, answer)
  partial_word = make_partial(guesses, answer).join
  show_progress(turn_count, partial_word)
  prompt_player(guesses)
end

def win?(answer, guesses)
  answer.chars.all? do |character|
    guesses.include?(character)
  end

  # winner = true
  # answer.chars.each do |letter|
  #   winner = false unless guesses.include?(letter)
  # end
  # winner
end

def postmortem(answer, guesses)
  if win?(answer, guesses)
    puts "\nNice work! You win."
  else
    puts "\nThe word was #{answer}. Better luck next time."
  end
end

def hangman(answer, turn_count)
  guesses = []
  greeting
  until game_over?(turn_count, answer, guesses)
    guess = take_turn(turn_count, guesses, answer)
    guesses.push(guess)
    turn_count -= 1 unless answer.include?(guess)
  end
  postmortem(answer, guesses)
end


hangman(answer, turn_count)

puts "\nWould you like to play again? yes or no"

replay = gets.chomp.downcase

end

