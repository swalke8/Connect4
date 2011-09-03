require 'human_player'
require 'mock_console'

describe HumanPlayer do

  before(:each) do
    @board = Board.new
    @console = MockConsole.new
    @player = HumanPlayer.new(@board, @console, 1)
  end

  it "can get a column input" do
    @console.array_gets = [2]
    @player.get_column.should == 2
    @console.array_gets.empty?.should be_true
    @console.string_puts.should == "2\n"
  end

  it "displays a prompt for a move" do
    @player.prompt_for_column
    @console.string_puts.should == "Enter a column: "
  end

  it "can get a move" do
    @console.array_gets = [4]
    @player.get_move
    @console.array_gets.empty?.should be_true
    @console.string_puts.should == "Enter a column: 4\n"
  end

  it "validates a column input" do
    @console.array_gets = [ 9, 2 ]
    @player.get_move
    @console.array_gets.empty?.should be_true
    @console.string_puts.should == "Enter a column: 9\nInvalid move!\nEnter a column: 2\n"
  end

end
