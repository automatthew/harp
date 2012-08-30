Gem::Specification.new do |s|
  s.name = "harp"
  s.version = "0.2.2"
  s.authors = ["Matthew King"]
  s.homepage = "https://github.com/automatthew/harp"
  s.summary = "A mixin for creating simple application repls with Readline support"

  s.files = %w[
    README.md
    LICENSE
    lib/harp.rb
    examples/usage.rb
  ]
  s.require_path = "lib"

  s.add_dependency("rb-readline", "0.4.2")
  s.add_development_dependency("starter", ">=0.1.0")
end
