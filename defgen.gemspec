# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'defgen/version'

Gem::Specification.new do |gem|
  gem.name          = "defgen"
  gem.version       = Defgen::VERSION
  gem.authors       = ["Paul Samuels"]
  gem.email         = ["paulio1987@gmail.com"]
  gem.description   = %q{Build an NSUserDefaults category using a simple DSL}
  gem.summary       = %q{Build an NSUserDefaults category using a simple DSL}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency 'xcodeproj'
  gem.add_dependency 'plist'
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "rb-fsevent"
end
