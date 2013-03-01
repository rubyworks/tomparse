#!/usr/bin/env ruby
#ignore 'pkg', 'log'

state :need_manifest? do
  ! system 'mast --quiet --verify'
end

desc "update manifest"
rule need_manifest? do
  sh 'mast -u'
end

desc "rerun specific tests if they change"
rule 'test/test_*.rb' do |files|
  sh 'rubytest -Ilib ' + files.join(' ')
  #require 'rubytest'
  #Test::Runner.run do |run|
  #  run.loadpath << 'lib'
  #  run.files << files
  #end
end

desc "run all unit tests if any lib scripts change"
rule 'lib/**/*.rb' do |files|
  sh 'rubytest -Ilib test/test_*.rb', 'coverage'=>'true'
end

