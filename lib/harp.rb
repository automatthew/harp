require "harp/command_manager"
require "harp/repl"
require "harp/cli"

module Harp
  def self.included(mod)
    mod.module_eval do
      @command_manager = CommandManager.new

      def self.setup_harp(&block)
        command_manager = @command_manager
        # This should either be baked in to REPL, or non-existent.
        @command_manager.command("quit") do
          exit
        end
        @command_manager.instance_exec(command_manager, &block)
      end

      def self.repl
        REPL.new(@command_manager)
      end

      def repl
        self.class.repl.run(self)
      end

      def self.cli
        CLI.new(@command_manager)
      end

      def cli
        self.class.cli.run(self)
      end
    end
  end

end
