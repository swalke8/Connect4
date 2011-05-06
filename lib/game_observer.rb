class GameObserver
  def initialize(board)
    @game_board = board
    @sum = [0,0]
  end

  def has_winner?
    horizontal_winner? || vertical_winner? || diagonal_winner?
  end

  def horizontal_winner?
    for_each_cell_by_row do |row, column|
      check_for_connect_four(row, column)
      return true if connect_four?
      @sum.clear if column==@game_board.column_dimension
    end
    false
  end

  def vertical_winner?
    for_each_cell_by_column do |row, column|
      check_for_connect_four(row, column)
      return true if connect_four?
      @sum.clear if column==@game_board.column_dimension
    end
    false
  end

  def diagonal_winner?
    @sum.clear
    (0..3).each do |row|
      check_for_connect_four(@game_board.row_dimension - row, row)
      return true if connect_four?
    end
    false
  end

  def check_for_connect_four(row, column)
    if is_same_player?(@game_board.board[row][column])
      @sum[1] += 1
    else
      reset_sums(row, column)
    end
  end

  def connect_four?
    @sum[1] == 4
  end

  def is_same_player?(cell_value)
    cell_value == @sum[0] && @sum[0] != 0
  end

  def reset_sums(row, column)
     @sum = [@game_board.board[row][column], 1]
  end

  def for_each_cell_by_row
    (0..@game_board.row_dimension).each do |row|
      (0..@game_board.column_dimension).each { |column| yield(row, column) }
    end
  end

  def for_each_cell_by_column
    (0..@game_board.column_dimension).each do |column|
      (0..@game_board.row_dimension).each { |row| yield(row, column) }
    end
  end
end
