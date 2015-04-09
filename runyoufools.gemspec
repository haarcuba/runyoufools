# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runyoufools/version'

Gem::Specification.new do |spec|
  spec.name          = "runyoufools"
  spec.version       = Runyoufools::VERSION
  spec.authors       = ["Yoav Kleinberger"]
  spec.email         = ["haarcuba@gmail.com"]
  spec.summary       = %q{a generic, language agnostic test-runner for system tests}
  spec.description = <<EOF
The purpose of runyoufools is to supply the user with a runner to run his/her
*system* tests, no matter if these tests are Ruby, Python, C++, Perl -
whatever. This is NOT a runner for unit tests - which have different solutions you can easily find.
EOF
  spec.homepage      = "https://github.com/haarcuba/runyoufools"
  spec.license       = "GPL-2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry'

  spec.add_runtime_dependency 'colorize'
end
