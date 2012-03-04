# TomParse

TomParse is TomDoc parser for Ruby. It provides no other functionality
than to take a code comment and parse it in to a convenient object-oriented
structure in accordance with TomDoc standard.

See [TomDoc](https://github.com/mojombo/tomdoc) for more information about
the TomDoc format.


## Limitations

Current implmentation doesn't yet support named parameters. Hopefully
that will be fixed soon in an upcoming release --any volunteers?


## Installation

    $ gem install tomparse


## Instruction

The primay interface is the `TomParse.parse` method. It will parse the
comment and return a `TomParse::TomDoc` instance.

    TomParse.parse(comment)  #=> TomParse::TomDoc

The comment string can have comment markers ('#') or not. The
parse will remove them if present. The resulting TomDoc object
then has a selection of methods that provide information from
the comment, such as `#arguments`, `#examples`, etc.

See the [API documention](http://rubydoc.info/gems/tomparse/frames)
for more details on this.


## Example

If you are unfamiliar with TomDoc, an example TomDoc comment for a method
looks something like this:

    # Duplicate some text an abitrary number of times.
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


## License

Copyright (c) 2012 Rubyworks

TomParse is distributable under the terms of the *BSD-2-Clause* license.

See LICENSE.txt for details.

