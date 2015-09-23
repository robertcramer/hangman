require 'pry'

playagain = "yes"
until playagain == "no"
	v = rand(100)

	puts "Pick a number between 0 and 100:"
	guess = gets.chomp.to_i

	attempts = 1

	until guess == v
		if guess > v
			puts "Too high, guess again."
		elsif guess < v
			puts "Too low, guess again."
		end
		guess = gets.chomp.to_i
		attempts += 1
	end

	puts "You got it right in #{attempts} tries! congrats!"
	puts "Do you want to play again? yes or no"

	playagain = gets.chomp.downcase
end
binding.pry

=begin

=end

=begin

ask the user to guess a number between 1 and 100
get user user_input

if user input is equal to the random number
	put Congrats You Got it
if user input is greater than random number
	put number too high, guess Again
if user input is lower than random number
	put number too low, guess Again

	repeat until user guesses the right number

=end