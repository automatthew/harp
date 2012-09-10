require "harp"

class UsefulThing

  # define all the useful methods and behaviors you need
  def use(adverb)
    puts "You used me #{adverb}!"
  end

  # Mix it in
  include Harp

  # Set it up
  setup_harp do |harp|

    command("help") do
      commands = harp.command_names
      puts "* Available commands: " << commands.sort.join(" ")
      puts "* Tab completion works for commands."
    end

    # Harp provides a "quit" command by default, but you can
    # override it to add value.
    command("quit") do
      puts "Farewell to the girl with the sun in her eyes."
      exit
    end

    ## Set up a handler for a command where the first token is "!"
    ## I.e., shell out like Vim does.
    #on_bang do |args|
      #system args.first
    #end

    # define a command that calls an instance method of your class.
    # The block parameter is always an array, even if your regex
    # had only one match group.
    # This command will only accept a single-word argument (no
    # whitespace allowed).
    command("use", :adverb) do |args|
      self.use(args.first)
    end

  end

end

UsefulThing.new.repl

