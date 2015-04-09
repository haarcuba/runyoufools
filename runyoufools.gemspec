# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runyoufools/version'

Gem::Specification.new do |spec|
  spec.name          = "runyoufools"
  spec.version       = Runyoufools::VERSION
  spec.authors       = ["Yoav Kleinberger"]
  spec.email         = ["haarcuba@gmail.com"]
  spec.summary       = %q{a generic, language agnostic system test runner}
  spec.description = <<EOF
The basic idea behind runyoufools is that system tests should be simple
scripts, whose exit code determines their success (or failure).

Most testing framework are more suitable for unit tests. System tests require a broader perspective,
and a simpler format. I believe that system tests should be readable, self-explanatory scripts that just
run from top to bottom, e.g. this little bit of Python:

    # test_basic_client_server_chat.py
    # these are the real thing, not Moch objects of any kind
    server = Server()
    clinet = client()
    client.sendMessage( "what's up, server?" )
    assert server.response() == "I'm OK, how are you?"

Different tests should reside in different files, again unlike unit tests.

The purpose of runyoufools is to supply the user with a runner to run his/her tests,
no matter if these tests are Ruby, Python, C++, Perl - whatever - with appropriate hooks for test setup.
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

  spec.add_runtime_dependency 'subprocess'
  spec.add_runtime_dependency 'colorize'
end
