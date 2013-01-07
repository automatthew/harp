# stdlib
require "set"
require "readline"

Readline.completion_append_character = nil
#Readline.basic_word_break_characters = ""

module Harp

  class REPL
    Prompt = "<3: "

    def initialize(command_manager)
      @command_manager = command_manager
      Readline.completion_proc = self.method(:complete)
    end

    def commands
      @command_manager.commands.keys
    end

    def complete(str)
      case Readline.line_buffer
      when /^\s*!/
        # if we're in the middle of a bang-exec command, completion
        # should look at the file system.
        self.complete_path(str)
      else
        # otherwise use the internal dict.
        self.complete_term(str)
      end
    end

    def complete_path(str)
      Dir.glob("#{str}*")
    end

    def complete_term(str)
      # Terms can be either commands or indexes into the configuration
      # data structure.  No command contains a ".", so that's the test
      # we use to distinguish.
      bits = str.split(".")
      if bits.size > 1
        # An attempt to allow completion of either full configuration index
        # strings, or of component parts.  E.g., if the configuration contains
        # foo.bar.baz, this code will offer both "foo" and "foo.bar.baz"
        # as completions for "fo".
        v1 = @completions.grep(/^#{Regexp.escape(str)}/)
        v2 = @completions.grep(/^#{Regexp.escape(bits.last)}/)
        (v1 + v2.map {|x| (bits.slice(0..-2) << x).join(".") }).uniq
      else
        self.command_complete(str) +
          @completions.grep(/^#{Regexp.escape(str)}/)
      end
    end

    def command_complete(str)
      commands.grep(/^#{Regexp.escape(str)}/) 
    end

    def sanitize(str)
      # ANSI code stripper regex cargo culted from
      # http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed
      str.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, "")
    end

    def run(context)
      @completions = context.completions rescue Set.new
      @run = true
      puts
      stty_save = `stty -g`.chomp
      trap("INT") { system "stty", stty_save; exit }
      while @run && (line = Readline.readline(Prompt, true).strip)
        # Treat ! as the shell out command
        if line[0] == "!"
          system(line.slice(1..-1))
          next
        end

        if line.empty?
          next
        end

        name, *args = line.split(/\s+/)

        begin
          @command_manager.handle(name, args, context)
        rescue ArgumentError => e
          puts e.message
        end
      end
    end

  end

end

