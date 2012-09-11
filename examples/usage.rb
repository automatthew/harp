$:.unshift "#{File.expand_path(File.dirname(__FILE__))}/../lib"
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
    command_names = harp.command_names.select {|name| name.size > 1 }

    command("help", :alias => "h") do
      puts "* Available commands: " << command_names.sort.join(", ")
      puts "* Tab completion works for commands."
    end

    # Harp's repl provides a "quit" command by default, but you can
    # override it to add value.
    command("quit", :alias => "q") do
      puts "Farewell to the girl with the sun in her eyes."
      exit
    end

    # define a command that calls an instance method of your class.
    # The block parameter is always an array, even if your regex
    # had only one match group.
    # This command will only accept a single-word argument (no
    # whitespace allowed).
    command("use", :adverb, :alias => "abuse") do |args|
      self.use(args.first)
    end

  end

end

#UsefulThing.new.repl

