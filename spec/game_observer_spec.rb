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
end
