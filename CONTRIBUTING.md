# CONTRIBUTING


## Build Requirements

* [Rubytest](http://rubyworks.github.com/rubytest) (testing)
* [Citron](http://rubyworks.github.com/citron) (testing)
* [AE](http://rubyworks.github.com/ae) (testing)
* [Rulebow](http://detroit.github.com/rulebow) (building)
* [Detroit](http://detroit.github.com/detroit) (building)

The last is not being used currently, but will be once it is fixed.


## Running Tests

To run the test suite use:

    $ bundle exec rubytest -Ilib test/

To add test coverage use:

    $ bundle exec rubytest -c simplecov -Ilib test/


