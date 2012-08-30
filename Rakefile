require "starter/tasks/gems"
require "starter/tasks/git"

desc "Build everything that needs building"
task "build" => %w[ gem:build ]

desc "Build and push the gem, tag the git"
task "release" => %w[ build gem:push tag ]

