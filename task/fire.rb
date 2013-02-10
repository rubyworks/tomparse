#!/usr/bin/env ruby
ignore 'pkg', 'log'

state :need_manifest? do
  ! system 'mast --quiet --recent'
end

rule need_manifest? do
  sh 'mast -u'
end

rule 'test/test_*.rb' do |files|
  require 'rubytest'
  Test.run do |run|
    $:.unshift('lib') 
    run.files << files
  end
end

desc "Run all unit tests with coverage report."
task 'test' do
  require 'rubytest'
  #require 'citron'
  #require 'ae'

  require 'simplecov'
  SimpleCov.command_name "test:all"
  SimpleCov.start do
    coverage_dir 'log/coverage'
  end

  Test.run do |run|
    $:.unshift('lib') 
    run.files << 'test/test_*.rb'
  end
end

