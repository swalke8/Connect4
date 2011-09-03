require 'board'
require 'game_observer'
require 'real_console'
require 'human_player'

@board = Board.new
@game_observer = GameObserver.new(@board)
@console = RealConsole.new
@player_one = HumanPlayer.new(@board, @console, 1)
@player_two = HumanPlayer.new(@board, @console, -1)

@board.print

until @game_observer.game_over?
  @player_one.get_move
  @board.print
  @player_two.get_move if !@game_observer.game_over?
  @board.print if !@game_observer.game_over?
end

if @game_observer.get_winner == 1
  win_message = "Player one wins!"
elsif @game_observer.get_winner == -1
  win_message = "Player two wins!"
else
   win_message = "Tie game!"
end

@board.print
puts "has winner: #{@game_observer.has_winner?}"
puts win_message
