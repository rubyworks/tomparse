#!/usr/bin/env ruby

require 'simplecov'

SimpleCov.command_name 'rubytest'
SimpleCov.start do
  coverage_dir 'log/coverage'
end

