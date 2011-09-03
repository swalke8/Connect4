class GameObserver
  def initialize(board)
    @game_board = board
    @connect_4_counter = 0
    @last_piece_value = nil
  end

  def game_over?
    has_winner? || full_board?
  end

  def has_winner?
    horizontal_winner? || vertical_winner? || diagonal_winner?
  end

  def get_winner
    return get_last_player if has_winner?
    return 0
  end

private

  def full_board?
    for_each_row do |row|
      for_each_column do |column|
        return false if @game_board.value_at(row, column) == 0
      end
    end
  end

  def horizontal_winner?
    for_each_row do |row|
      for_each_column do |column|
        update_counter(row, column)
        return true if connect_four?
      end
      reset_counter(0)
    end
    return false
  end

  def vertical_winner?
    for_each_column do |column|
      for_each_row do |row|
        update_counter(row, column)
        return true if connect_four?
      end
      reset_counter(0)
    end
    return false
  end

  def diagonal_winner?
    (0..2).each do |row_shift|
      (0..3).each do |column_shift|
        reset_counter(0)
        return true if back_diagonal_win?(row_shift, column_shift)
        reset_counter(0)
        return true if forward_diagonal_win?(row_shift, column_shift)
      end
    end
    return false
  end

  def back_diagonal_win?(row_shift, column_shift)
    (1..4).each do |cell|
      row = @game_board.number_of_rows - cell - row_shift + 1
      column = cell + column_shift
      update_counter(row, column)
      return true if connect_four?
    end
    return false
  end

  def forward_diagonal_win?(row_shift, column_shift)
    (1..4).each do |cell|
      row = cell + row_shift
      column = cell + column_shift
      update_counter(row, column)
      return true if connect_four?
    end
    return false
  end

  def update_counter(row, column)
    if is_repeating_piece?(row, column)
     increment_counter
    else
      reset_counter(@game_board.value_at(row, column))
    end
  end

  def is_repeating_piece?(row, column)
    current_piece = @game_board.value_at(row, column)
    @last_piece_value == current_piece && ( current_piece.abs == 1 )
  end

  def increment_counter
    @connect_4_counter += 1
  end

  def reset_counter(value)
    @last_piece_value = value
    @connect_4_counter = 1
  end

  def connect_four?
    @connect_4_counter== 4
  end

  def get_last_player
    player = -1
    for_each_row do |row|
      for_each_column do |column|
        player = -player if @game_board.value_at(row,column) != 0
      end
    end
    return player
  end

  def for_each_row
    (1..@game_board.number_of_rows).each { |row| yield(row) }
  end

  def for_each_column
    (1..@game_board.number_of_columns).each { |column| yield(column) }
  end
end
