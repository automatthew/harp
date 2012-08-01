Gem::Specification.new do |s|
  s.name = "consolize"
  s.version = "0.2.0"
  s.authors = ["Matthew King"]
  s.summary = "A mixin for creating application consoles with Readline support"

  s.files = %w[
    README.md
    LICENSE
    lib/consolize.rb
    examples/usage.rb
  ]
  s.require_path = "lib"

  s.add_dependency("rb-readline", "0.4.2")
end
