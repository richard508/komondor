# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'komondor/version'

Gem::Specification.new do |spec|
  spec.name          = "komondor"
  spec.version       = Komondor::VERSION
  spec.authors       = ["Richard Almonte", "David Briggs"]
  spec.email         = ["richard.almonte@infosurv.com", "dbriggs@me.com"]
  spec.description   = %q{A helper gem to add single sign on to apps.}
  spec.summary       = %q{A helper gem to add single sign on to apps.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
