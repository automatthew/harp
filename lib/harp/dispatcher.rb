module Harp

  class Dispatcher

    attr_reader :commands
    def initialize
      @commands = {}
    end

    def command(command_name, *spec, &block)
      names = [command_name]
      #TODO aliases
      if spec.last.is_a?(Hash)
        options = spec.pop
        if command_alias = options[:alias]
          names << command_alias
        end
      end
      names.each do |name|
        command = @commands[name] ||= Command.new(name)
        command.add_spec(spec, block)
      end
    end

    def command_names
      @commands.keys.sort
    end

    ## Helper for defining the action for the "!" command.
    ## Typically used to shell out, a la Vim.
    #def on_bang(&block)
      #on(/^\!\s*(.*)$/, &block)
    #end

  end

  class Command
    def initialize(name)
      @name = name
      @blocks = {}
    end

    def add_spec(spec, block)
      # TODO validate block and arity
      @blocks[spec]= block
    end

    def block_for(args)
      @blocks.each do |spec, block|
        if match(spec, args)
          return block
        end
      end
      return nil
    end

    def match(spec, args)
      spec.size == args.size
    end

  end

end

