# encoding: utf-8

Gem::Specification.new do |s|
  # Release Specific Information
  s.version = "0.5.0"
  s.date = "2014-02-05"

  # Gem Details
  s.name = "bluesy-noise"
  s.authors = ["Paul Prince"]
  s.email = "paul@littlebluetech.com"
  s.summary = %q{A Compass/SASS extension to generate gamma-neutral noise textures.}
  s.description = %q{Fork of a sass port of the noisy js plugin, as a compass extension. Creates backgrond noise images (that neither darken nor lighten the underlying image) as base64 data URIs.}
  s.homepage = "https://littlebluetech.com/projects/bluesy-noise"

  # Gem Files
  s.files = %w(README.md)
  s.files += Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")
  s.files += Dir.glob("templates/**/*.*")

  # Gem Bookkeeping
  s.rubygems_version = %q{1.6.2}
  s.add_dependency("compass")
  s.add_dependency("chunky_png")
  s.add_development_dependency("rspec", ">=2.0")
end
