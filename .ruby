---
source:
- meta
authors:
- name: Trans
  email: transfire@gmail.com
copyrights:
- holder: Rubyworks
  year: '2012'
  license: BSD-2-Clause
requirements:
- name: minitest
  version: 1.5+
  groups:
  - test
  development: true
- name: turn
  groups:
  - test
  development: true
- name: rake
  version: 0.9+
  groups:
  - development
  development: true
dependencies: []
alternatives: []
conflicts: []
repositories:
- uri: git@github.com:rubyworks/tomparse.git
  scm: git
  name: upstream
resources:
  home: http://rubyworks.github.com/tomparse
  docs: http://rubydoc.info/gems/tomparse
  code: http://github.com/rubyworks/tomparse
  mail: http://groups.google.com/groups/rubyworks-mailinglist
extra: {}
load_path:
- lib
revision: 0
created: '2012-03-04'
summary: TomDoc parser for Ruby
title: TomParse
version: 0.1.0
name: tomparse
description: ! 'TomParse is a Ruby TomDoc parser. It contains no other functionality

  than the ability to take a comment and parse it in accordance to the

  TomDoc standard.'
organization: rubyworks
date: '2012-03-04'
