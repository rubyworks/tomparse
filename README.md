# TomParse

[Website](http://github.com/rubyworks/tomparse) /
[Report Issue](http://github.com/rubyworks/tomparse/issues) /
[Source Code](http://github.com/rubyworks/tomparse) /
[Gem Page](http://rubygems.org/gems/tomparse)

[![Build Status](https://secure.travis-ci.org/rubyworks/tomparse.png)](http://travis-ci.org/rubyworks/tomparse)
[![Gem Version](https://badge.fury.io/rb/tomparse.png)](http://badge.fury.io/rb/tomparse)


## Description

TomParse is a TomDoc parser for Ruby. It provides no other functionality than
to take a code comment and parse it in to a convenient object-oriented
structure in accordance with TomDoc standard. See [TomDoc](https://github.com/mojombo/tomdoc)
for more information about the TomDoc format.


## Instruction

### Installation

TomParse is available as a Ruby gem.

    $ gem install tomparse

### Usage

The primary interface is the `TomParse.parse` method. It will parse the
comment and return a `TomParse::TomDoc` instance.

    TomParse.parse(comment)  #=> TomParse::TomDoc

The comment string can have comment markers ('#') or not. The
parse will remove them if present. The resulting TomDoc object
then has a selection of methods that provide information from
the comment, such as `#arguments`, `#examples`, etc.

See the [API documention](http://rubydoc.info/gems/tomparse/frames)
for more details on this.

### Example

If you are unfamiliar with TomDoc, an example TomDoc comment for a method
looks something like this:

    # Duplicate some text an arbitrary number of times.
    #
    # text  - The String to be duplicated.
    # count - The Integer number of times to duplicate the text.
    #
    # Examples
    #   multiplex('Tom', 4)
    #   # => 'TomTomTomTom'
    #
    # Returns the duplicated String.
    def multiplex(text, count)
      text * count
    end

### Extra Features

Okay, we told a little white lie in the description. TomParse does take a tiny 
bit of liberty with the specification to offer up some additional documentation
goodness. In particular, TomParse recoginizes paragraphs starting with an all-caps
word, followed by a colon and a space, as special tags. Here is an example:

```ruby
  # Method to do something.
  #
  # TODO: This is a todo note.
  #
  # Returns nothing.
  def dosomething
    ...
```

When this is parsed, rather then lumping the TODO line in with the description,
the TomDoc instance will have a `tags` property containing `{'todo'=>'This is a todo note.'}`.


## Resources

* [Website](http://rubyworks.github.com/tomparse)
* [Source Code](http://github.com/rubyworks/tomparse) (Github)
* [API Reference](http://rubydoc.info/gems/tomparse/frames")
* [Mailiing List](http://groups.google.com/group/rubyworks-mailinglist)
* [IRC Chat](http://chat.us.freenode.net/rubyworks)
* [Upstream Repo](http://github.com/rubyworks/tomparse/tomparse.git)


## Authors

<ul>
<li class="iauthor vcard">
  <span class="nickname">trans</span>
  <span>&lt;<a class="email" href="mailto:transfire@gmail.com">transfire@gmail.com</a>&gt;</span>
  <br/><a class="url" href="http://trans.gihub.com/">http://trans.github.com/</a>
</li>
</ul>


## Development 

### Requirements

* [Citron](http://rubyworks.github.com/citron) (testing)
* [AE](http://rubyworks.github.com/ae) (testing)
* [Detroit](http://detroit.github.com/detroit) (building)


## Copyright & License

TomParse is copyrighted open-source software.

Copyright (c) 2012 [Rubyworks](http://rubyworks.github.com). All rights reserved.

TomParse is distributable under the terms of the [BSD-2-Clause]((http://www.spdx.org/licenses/BSD-2-Clause) license.

See LICENSE.txt for details.

