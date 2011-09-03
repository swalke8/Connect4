require 'game_observer'

describe GameObserver do

  before(:each) do
    @my_board = Board.new
    @observer = GameObserver.new(@my_board)
    @place_holder = 2
    @player_one = 1
  end

  def iterate_four_columns
    (1..4).each do |column|
      yield(column)
    end
  end

  it "should detect a horizontal win" do
    iterate_four_columns { |column|  @my_board.move(column, @player_one) }
    @observer.has_winner?.should be_true
  end

  it "should detect a horizontal win" do
    (1..3).each do |space|
      @my_board.move(space, @player_one)
    end
    @my_board.move(5, @player_one)
    @observer.has_winner?.should be_false
  end

  it "should detect a horizontal win on different rows" do
    iterate_four_columns do |column|
      @my_board.move(column, @place_holder)
      @my_board.move(column)
      @my_board.move(column, @place_holder)
    end
    @observer.has_winner?.should be_true
  end

  it "should detect a vertical win" do
    iterate_four_columns { @my_board.move(3, @player_one) }
    @observer.has_winner?.should be_true
  end

  def right_diagonal_loop(row_shift = 0, column_shift = 0)
    iterate_four_columns { |column| (column + row_shift - 1).times { @my_board.move(column+column_shift, @place_holder) } }
    iterate_four_columns { |column| @my_board.move(column + column_shift, @player_one) }
  end

  def left_diagonal_loop(row_shift = 0, column_shift = 0)
    iterate_four_columns { |column| (4 - column + row_shift).times { @my_board.move(column + column_shift, @place_holder) } }
    iterate_four_columns { |column| @my_board.move(column + column_shift, @player_one) }
  end

  it "detects a right diagonal win" do
    right_diagonal_loop
    @observer.has_winner?.should be_true
  end

  it "detects a right diagonal win in any vertical position" do
    right_diagonal_loop(2)
    @observer.has_winner?.should be_true
  end

  it "detects a right diagonal win in any horizontal position" do
    right_diagonal_loop(1,1)
    @observer.has_winner?.should be_true
  end

  it "detects a left diagonal win" do
    left_diagonal_loop
    @observer.has_winner?.should be_true
  end

  it "checks a shifted left diagonal win" do
    left_diagonal_loop(2,3)
    @observer.has_winner?.should be_true
  end

  it "can detect if a game is over with a winner" do
    left_diagonal_loop
    @observer.game_over?.should be_true
  end

  it "can detect a game over with full board (no winner)" do
    (1..7).each do |column|
      6.times {@my_board.move(column, @place_holder)}
    end
    @observer.game_over?.should be_true
    @observer.has_winner?.should be_false
  end

  it "returns the winner" do
    player = 1
    (1..3).each do |row|
      (1..2).each do |column|
        @my_board.move(column, player)
        player = -player
      end
    end
    @my_board.move(player)
    @observer.get_winner.should == @player_one
  end

  it "does not have a winner with a connect 3" do
    player = 1
    (1..3).each do |row|
      (1..2).each do |column|
        @my_board.move(column, player)
        player = -player
      end
    end
    @observer.has_winner?.should be_false
  end

  it "should not win with 3 in a row in a back diagonal" do
    (1..3).each do |column|
      (column-1).times { @my_board.move(column, @place_holder) }
      @my_board.move(column, @player_one)
    end
  end

  it "should not win with 3 in a row in a forward diagonal" do
    (1..3).each do |column|
      (3-column).times { @my_board.move(column, @place_holder) }
      @my_board.move(column, @player_one)
    end
  end
end
