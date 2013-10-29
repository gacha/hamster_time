# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hamster_time/version'

Gem::Specification.new do |spec|
  spec.name          = "hamster_time"
  spec.version       = HamsterTime::VERSION
  spec.authors       = ["Gatis Tomsons"]
  spec.email         = ["gatis.tomsons@gmail.com"]
  spec.summary       = %q{To sync Hamster time tracking with Pivotal Time}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sqlite3", "~> 1.3"
  spec.add_dependency "activerecord", "~> 4.0"
  spec.add_dependency "activesupport", "~> 4.0"
  spec.add_dependency "dotenv", "~> 0.9.0"
  spec.add_dependency "mechanize", "~> 2.7.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
