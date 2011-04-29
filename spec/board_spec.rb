require 'board'

describe Board do

  before(:each) do
    @my_board = Board.new
  end

  it "has a board" do
    @my_board.board.nil?.should be_false
  end

  it "should take in a board dimension" do
    @my_board = Board.new(3,3)
    @my_board.board.size.should == 3
    @my_board.board[0].size.should == 3
  end

  it "has a dimension" do
    @my_board.row_dimension.should == 5
    @my_board.column_dimension.should == 6
  end

  it "can make a move" do
    @my_board.move(5)
    @my_board.board[@my_board.row_dimension][5].should == 1
  end

  it "stacks pieces" do
    @my_board.move(3)
    @my_board.move(3)
    @my_board.board[@my_board.row_dimension-1][3].should == 1
  end

  it "checks for a full column" do
    (0..@my_board.row_dimension).each { @my_board.move(3)}
    @my_board.move(3).should == false
  end

  it "detects an occupied position" do
    @my_board.move(3)
    @my_board.occupied?(@my_board.row_dimension, 3).should be_true
  end

  it "move takes player value" do
    @my_board.move(3,-1)
    @my_board.board[@my_board.row_dimension][3].should == -1
  end
end
