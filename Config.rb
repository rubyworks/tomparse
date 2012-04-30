config 'rubytest' do |run|
  run.files << 'test/test_*.rb'

  $:.unshift('test')
  $:.unshift('lib') 
end

config 'rubytest', :profile=>'coverage' do |run|
  run.files << 'test/test_*.rb'

  $:.unshift('test')
  $:.unshift('lib')

  require 'simplecov'
  SimpleCov.start do
    coverage_dir 'log/coverage'
  end
end

