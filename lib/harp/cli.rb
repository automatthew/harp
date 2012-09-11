
module Harp

  class CLI

    def initialize(command_manager)
      @command_manager = command_manager
      @commands = command_manager.commands.keys
    end

    def run(context)
      name, *args = parse(ARGV)
      @command_manager.handle(name, args, context)
    end

    def parse(array)
      array
    end

  end

end


