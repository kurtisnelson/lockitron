require "bundler/gem_tasks"
begin
require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :default => :spec
rescue LoadError
end
desc "Poke around in a console"
task :pry do
  require 'pry'
  require 'lockitron'
  user = Lockitron::User.new(ENV['LOCKITRON_TOKEN'])
  locks = user.locks
  binding.pry
end
