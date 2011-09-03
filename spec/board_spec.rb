require 'board'

describe Board do

  before(:each) do
    @my_board = Board.new
  end

  it "has a dimension" do
    @my_board.number_of_rows.should == 6
    @my_board.number_of_columns.should == 7
  end

  it "can make a move" do
    @my_board.move(5)
    @my_board.value_at(6,5).should == 1
  end

  it "stacks pieces" do
    @my_board.move(3)
    @my_board.move(3)
    @my_board.value_at(@my_board.number_of_rows,3).should == 1
  end

  it "move takes player value" do
    @my_board.move(3,-1)
    @my_board.value_at(@my_board.number_of_rows,3).should == -1
  end
end
