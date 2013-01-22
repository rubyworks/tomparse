# Release History

## 0.3.0 / 2012-01-21

This release fixes a bug which prevented descriptions from having
multiple paragraphs. In addition it adds support for section tags.
See the README for more information on tags.

Changes:

* Fix multi-paragraph description parsing.
* Add support for tags.


## 0.2.1 / 2012-04-30

This release fixes indention with multi-line examples.

Changes:

* Correctly indent multiline code examples.
* Swtich to Citron for testing.


## 0.2.0 / 2012-03-07

This release improves support of TomDoc, in particular, named parameters. It also
fixes a bug with appending to argument and option descriptions.

Changes:

* Ass support for named parameters.
* Fix appending to argument description issue.


## 0.1.0 / 2012-03-04

TomParse is stand-alone TomDoc parser, spun-off and rewritten from the original
tomdoc.rb code from the defunkt/tomdoc project. Having a stand-alone project
just for the parser, makes it more convenient for other libraries to make use,
including, eventually, the original tomdoc project itself.

Changes:

* Happy Birthday.

