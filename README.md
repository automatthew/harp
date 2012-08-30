# HARP

A mixin for creating application REPLs with Readline support.

## Example

    gem install harp

```ruby
require "harp"

class UsefulThing

  # define all the useful methods and behaviors you need
  def use(adverb)
    puts "You used me #{adverb}!"
  end

  # Mix it in
  include Harp

  # Set it up
  setup_repl do |repl|

    on("help") do
      commands = repl.commands
      puts "* Available commands: " << commands.sort.join(" ")
      puts "* Tab completion works for commands."
    end

    # Harp provides a "quit" command by default, but you can
    # override it to add value.
    on("quit") do
      puts "Farewell to the girl with the sun in her eyes."
      exit
    end

    # Set up a handler for a command where the first token is "!"
    # I.e., shell out like Vim does.
    on_bang do |args|
      system args.first
    end

    # define a command that calls an instance method of your class.
    # The block parameter is always an array, even if your regex
    # had only one match group.
    # This command will only accept a single-word argument (no
    # whitespace allowed).
    on(/use (\S+)$/) do |args|
      self.use(args.first)
    end

  end

end

UsefulThing.new.repl
```


## Usage


    $ ruby -I lib/ examples/usage.rb 

    <3: help
    * Available commands:  help quit use
    * Tab completion works for commands.
    <3: use well
    You used me well!
    <3: use badly
    You used me badly!
    <3: use without proper care
    command not found
    <3: ! ls
    LICENSE           README.md         consolize.gemspec examples          lib
    <3: quit
    Farewell to the girl with the sun in her eyes.



