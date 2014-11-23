# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monte_carlo/version'

Gem::Specification.new do |spec|
  spec.name          = "monte_carlo"
  spec.version       = MonteCarlo::VERSION
  spec.authors       = ["Assaf Gelber"]
  spec.email         = ["assaf.gelber@gmail.com"]
  spec.summary       = %q{A small gem to help with Monte Carlo Method experiments in ruby.}
  spec.description   = %q{A small gem to help with Monte Carlo Method experiments in ruby.}
  spec.homepage      = "https://github.com/agelber/monte_carlo"
  spec.license       = "MIT"

  spec.required_ruby_version     = '>= 1.9.3'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.0"
end
