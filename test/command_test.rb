require "harp"

describe "Command matching" do

  before(:each) do
    @dispatcher = Harp::Dispatcher.new
  end

  specify "command without args" do
    block = lambda { true }

    @dispatcher.command("simple", &block)

    command = @dispatcher.commands["simple"]
    command.should_not be_nil

    cblock = command.block_for([])
    cblock.should be_a_kind_of Proc

    command.block_for(["foo"]).should be_nil
  end

  specify "command with one arg" do
    block = lambda { true }

    @dispatcher.command("one_arg", /(\S+)/, &block)

    command = @dispatcher.commands["one_arg"]
    command.should_not be_nil

    cblock = command.block_for(["foo"])
    cblock.should be_a_kind_of Proc

    command.block_for(["foo", "bar"]).should be_nil
  end

  specify "command with multiple specs" do
    block1 = lambda { true }
    block2 = lambda { false }

    @dispatcher.command("multi", &block1)
    @dispatcher.command("multi", /(\S+)/, &block2)

    command = @dispatcher.commands["multi"]
    command.should_not be_nil

    cblock = command.block_for([])
    cblock.should == block1

    cblock = command.block_for(["foo"])
    cblock.should == block2

    command.block_for(["foo", "bar"]).should be_nil
  end

end

