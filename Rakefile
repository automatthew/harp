require "starter/tasks/gems"
require "starter/tasks/git"

desc "Build everything that needs building"
task "build" => %w[ gem:build ]

desc "Build and push the gem, tag the git"
task "release" => %w[ build gem:push tag ]






#raise "GIVE ME GEMSPEC" unless gemspec = FileList["*.gemspec"].first
#project_name = gemspec.chomp(".gemspec")


#task "build" do
  #sh "gem build #{gemspec}"
#end

#task "clean" do
  #FileList["#{project_name}-*.gem"].each do |file|
    #rm file
  #end
#end

#task "tag" do
  #str = File.read(gemspec)
  #spec = eval(str)
  #version = spec.version.version
  #git_tag = `git tag -l #{version}`.chomp
  #if git_tag
    #puts "Tag #{version} already exists. Bump the version in the gemspec."
  #else
    #message = ENV["message"] || version
    #command = "git tag -am #{message} #{version}"
    #print "Issue command '#{command}' [y/N] "
    #case STDIN.gets.chomp
    #when /^y/i
      #sh command
    #else
      #puts "Cancelled."
    #end
  #end
#end
