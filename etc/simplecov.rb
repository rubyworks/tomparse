#!/usr/bin/env ruby

require 'simplecov'

SimpleCov.command_name 'tomparse'
SimpleCov.start do
  coverage_dir 'log/coverage'
end

