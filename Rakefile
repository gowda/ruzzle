# frozen_string_literal: true

require 'bundler/setup'
require 'rake/testtask'

Rake::TestTask.new(:test) do |task|
  task.verbose = true
  task.ruby_opts = ['-r minitest/autorun']
  task.test_files = FileList['tests/**/*_test.rb']
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:cop)
rescue LoadError => e
  abort "Coult not load rubocop tasks: #{e.inspect}"
end

task default: %i[cop test]
