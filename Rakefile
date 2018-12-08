# frozen_string_literal: true

require 'rake'
require 'rspec/core'
require 'coveralls/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

desc 'Run RSpec'
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

desc 'Run coveralls for code coverage'
Coveralls::RakeTask.new

desc 'Run Rubocop to auto-format code'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['-a']
end

task default: :spec
