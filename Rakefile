require "bundler/gem_tasks"

desc "Poke around in a console"
task :pry do
  require 'pry'
  require 'lockitron'
  user = Lockitron::User.new(ENV['LOCKITRON_TOKEN'])
  locks = user.locks
  binding.pry
end
