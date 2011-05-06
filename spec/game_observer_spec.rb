require 'game_observer'

describe GameObserver do

  before(:each) do
    @my_board = Board.new
    @observer = GameObserver.new(@my_board)
  end

  it "should detect a horizontal win" do
    (0..3).each do |column|
      @my_board.move(column, 1)
    end
    @observer.has_winner?.should be_true
  end

  it "should detect a horizontal win" do
    (0..2).each do |space|
      @my_board.move(space, 1)
    end
    @my_board.move(4, 1)
    @observer.has_winner?.should be_false
  end

  it "should detect a horizontal win on different rows" do
    (1..4).each do |column|
      @my_board.move(column, column)
      @my_board.move(column, 1)
      @my_board.move(column, column)
    end
    @observer.has_winner?.should be_true
  end

  it "should detect a vertical win" do
    (0..3).each { @my_board.move(3) }
    @observer.has_winner?.should be_true
  end

  it "detects a diagonal win" do
    (0..3).each do |column|
      column.times { @my_board.move(column, -1) }
      @my_board.move(column, 1)
    end
    puts ""
    (0..@my_board.row_dimension).each do |row|
      (0..@my_board.column_dimension).each do |column|
        putc "["
        putc "O" if @my_board.board[row][column] == 1
        putc "@" if @my_board.board[row][column] == -1
        putc " " if @my_board.board[row][column].zero?
        putc "]"
      end
      puts ""
    end
    @observer.has_winner?.should be_true
  end
end
