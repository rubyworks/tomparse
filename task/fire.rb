#!/usr/bin/env ruby

rule 'test/**/test_*.rb' do |files|
  require 'rubytest'
  $:.unshift('lib') 
  runner = Test::Runner.new do |run|
    run.files << files
  end
  runner.run
end

desc "Run all unit tests with coverage report."
task 'test' do
  require 'rubytest'
  #require 'citron'
  #require 'ae'

  $:.unshift('lib') 

  runner = Test::Runner.new do |run|
    run.files << 'test/**/test_*.rb'
  end

  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'log/coverage'
  end

  runner.run
end

