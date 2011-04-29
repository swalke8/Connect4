class Board
  attr_reader :board, :row_dimension, :column_dimension
  def initialize(row = 6, column = 7)
    @board = Array.new(row) { Array.new(column) {0}}
    @row_dimension, @column_dimension = row-1, column-1
  end

  def move(column, player_value = 1)
    (0..@row_dimension).each do |space|
      if @board[@row_dimension - space][column].zero?
        @board[@row_dimension - space][column] = player_value
        return true
      end
    end
    return false
  end

  def occupied?(row, column)
    !@board[row][column].zero?
  end
end
