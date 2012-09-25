class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
	raise WrongNumberOfPlayersError unless game.length == 2

	game.each { |item, item2| raise NoSuchStrategyError unless (item2.downcase =~ /^[rps]$/) != nil}

	myFirstMove = game[0][1].downcase
	mySecondMove = game[1][1].downcase
	if ((myFirstMove =~ /^[p]$/) != nil && (mySecondMove =~ /^[s]$/) != nil)
		game[1]
	elsif ((myFirstMove =~ /^[p]$/) != nil && (mySecondMove =~ /^[r]$/) != nil)
		game[0]
	elsif ((myFirstMove =~ /^[s]$/) != nil && (mySecondMove =~ /^[r]$/) != nil)
		game[1]
	elsif ((myFirstMove =~ /^[s]$/) != nil && (mySecondMove =~ /^[p]$/) != nil)
		game[0]
	elsif ((myFirstMove =~ /^[r]$/) != nil && (mySecondMove =~ /^[p]$/) != nil)
		game[1]
	elsif ((myFirstMove =~ /^[r]$/) != nil && (mySecondMove =~ /^[s]$/) != nil)
		game[0]
	else
		game[0]
	end

end

def rps_tournament_winner(game) 
	isAnyNil = false
	game.each { |item, item2| isAnyNil = item2 == nil  }
	if isAnyNil == true
		game
	else
		newList = []
		newList.push(rps_tournament_winner(game[0]))
		newList.push(rps_tournament_winner(game[1]))
		myWinner = rps_game_winner(newList)
	end
end