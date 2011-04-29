class GameObserver
  def initialize(board)
    @game_board = board
  end

  def has_winner?
    score = (0..@game_board.column_dimension).inject(0) { |acc, space| acc + @game_board.board[@game_board.row_dimension][space] }
    score == 4
  end
end
