class Board
  attr_reader :number_of_rows, :number_of_columns
  def initialize(row = 6, column = 7)
    @board = Array.new(row) { Array.new(column) {0}}
    @number_of_rows, @number_of_columns = row, column
  end

  def move(column, player_value = 1)
    if open_slot?(1, column)
      set_piece(column, player_value)
    end
  end

  def value_at(row, column)
    @board[row-1][column-1]
  end

  def print
    puts ""
    (0...@number_of_rows).each do |row|
      (0...@number_of_columns).each do |column|
        putc "["
        putc "O" if @board[row][column] == 1
        putc "@" if @board[row][column] == -1
        putc "E" if @board[row][column] > 1
        putc " " if @board[row][column].zero?
        putc "]"
      end
      puts ""
    end
  end

  def open_slot?(row, column)
    @board[row-1][column-1].zero?
  end

  private

  def get_first_open_slot(column)
    (0...@number_of_rows).each { |row| return @number_of_rows-row if open_slot?(@number_of_rows-row,column) }
  end

  def set_piece(column, player_value)
    row = get_first_open_slot(column)
    @board[row-1][column-1] = player_value
  end
end
