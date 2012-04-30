#require 'microtest/testunit'
#require 'microtest/assertions'
#require 'test/fixtures/multiplex'

require 'citron'
require 'ae'

require 'tomparse'

#module TomParse
#  class Test < ::Test::Unit::TestCase
#    def self.test(name, &block)
#      define_method("test_#{name.gsub(/\W/,'_')}", &block) if block
#    end
#
#    def default_test
#    end
#
#    def fixture(name)
#      @fixtures ||= {}
#      @fixtures[name] ||= File.read("test/fixtures/#{name}.rb")
#    end
#  end
#end

