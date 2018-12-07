require "rspec/core"
require "rspec/core/rake_task"

require 'rake'
require 'rspec/core/rake_task'
require 'coveralls/rake/task'

desc 'Run RSpec'
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

Coveralls::RakeTask.new
task default: :spec

