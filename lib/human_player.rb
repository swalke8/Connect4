class HumanPlayer

  def initialize(board, console, player_value)
    @console = console
    @board = board
    @column = nil
    @player_value = player_value
  end

  def get_column
    @column = @console.gets.to_i
  end

  def prompt_for_column
    @console.print "Enter a column: "
  end

  def get_move
    prompt_for_column
    get_column
    validate_move
  end

private

  def validate_move
    if invalid_move?
      @console.puts "Invalid move!"
      get_move
    else
      @board.move(@column, @player_value)
    end
  end

  def invalid_move?
    @column < 1 || @column > 7 || !@board.open_slot?(1,@column)
  end
end
