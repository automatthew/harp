module Harp

  class CommandManager

    attr_reader :commands
    def initialize
      @commands = {}
    end

    def handle(name, args, context)
      block = find_command(name, args)
      context.instance_exec(args, &block)
    end

    def find_command(name, args)
      if command = @commands[name]
        if block = command.block_for(args)
          return block
        else
          raise ArgumentError, "Invalid arguments for command."
        end
      else
        raise ArgumentError, "Command not found: '#{name}'."
      end
    end

    def command(command_name, *spec, &block)
      names = [command_name]
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

