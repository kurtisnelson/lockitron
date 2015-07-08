# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lockitron/version'

Gem::Specification.new do |s|
  s.name = "lockitron"
  s.version = Lockitron::VERSION

  s.authors = ["Kurt Nelson"]
  s.date = "2013-12-29"
  s.description = "Communicate with a Lockitron"
  s.email = "kurtisnelson@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.homepage = "http://github.com/kurtisnelson/lockitron"
  s.licenses = ["MIT"]
  s.rubygems_version = "1.8.24"
  s.summary = "Access the Lockitron API"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'faraday', '~> 0.9'
  s.add_dependency 'oauth2', '~> 1.0'
  s.add_development_dependency 'rdoc', '~> 4.2'
  s.add_development_dependency 'bundler', '~> 1.10'
  s.add_development_dependency 'dotenv'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.3'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'vcr', '~> 2.9'
  s.add_development_dependency 'webmock', '~> 1.21'
end

