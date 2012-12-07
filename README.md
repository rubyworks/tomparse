# <span class="ititle">TomParse</span>

[Website](http://github.com/rubyworks/tomparse) /
[Report Issue](http://github.com/rubyworks/tomparse/issues) /
[Source Code](http://github.com/rubyworks/tomparse) /
[Gem Page](http://rubygems.org/gems/tomparse)

[![Build Status](https://secure.travis-ci.org/rubyworks/tomparse.png)](http://travis-ci.org/rubyworks/tomparse)


## Description

TomParse is a <span class="isummary">TomDoc parser for Ruby</span>. 
<span class="idescription">It provides no other functionality than
to take a code comment and parse it in to a convenient object-oriented
structure in accordance with TomDoc standard.</span>

See [TomDoc](https://github.com/mojombo/tomdoc) for more information about
the TomDoc format.


## Installation

TomParse is available as a Ruby gem.

    $ gem install <a href="http://rubygems.org/gems/tomparse" class="iname">tomparse</a>


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


## Resources

<ul>
<li><a class="iresource" href="http://rubyworks.github.com/tomparse" name="home">Homepage</a></li>
<li><a class="iresource" href="http://github.com/rubyworks/tomparse" name="code">Source Code</a> (Github)</li>
<li><a class="iresource" href="http://rubydoc.info/gems/tomparse/frames" name="docs">API Reference</a></li>
<li><a class="iresource" href="http://groups.google.com/group/rubyworks-mailinglist" name="mail">Mailiing List</a></li>
<li><a class="iresource" href="http://chat.us.freenode.net/rubyworks" name="chat">IRC Chat</a></li>
<li><a class="irepository" href="http://github.com/rubyworks/tomparse/tomparse.git" name="upstream">Master Git Repo</a></li>
</ul>


## Requirements

<ul>
<li class="irequirement">
  <a class="name" href="http://rubyworks.github.com/qed/">citron</a> <span class="version"></span> <span class="groups">(test)</span>
</li>
<li class="irequirement">
  <a class="name" href="http://rubyworks.github.com/ae/">detroit</a> <span class="version"></span> <span class="groups">(build)</span>
</li>
</ul>


## Authors

<ul>
<li class="iauthor vcard">
  <span class="nickname">trans</span>
  <span>&lt;<a class="email" href="mailto:transfire@gmail.com">transfire@gmail.com</a>&gt;</span>
  <br/><a class="url" href="http://trans.gihub.com/">http://trans.github.com/</a>
</li>
</ul>


## Copyright & License

<div class="icopyright">
<p>Copyright (c) <span class="year">2012</span> <a href="http://rubyworks.github.com" class="holder">Rubyworks</a></p>

<p>TomParse is distributable under the terms of the <a href="http://www.spdx.org/licenses/BSD-2-Clause" class="license">BSD-2-Clause</a> license.</p>

<p>See LICENSE.txt for details.</p>
</div>

<p class="iorganization">
TomParse is <a href="http://rubyworks.github.com" class="name website">Rubyworks</a> project originally created on <span class="icreated">2012-03-04</span>.
<p>

