# diff-xml [![Gem Version](https://badge.fury.io/rb/diffxml.svg)](https://rubygems.org/gems/diffxml)

Inspired by the equivalent-xml gem, I wanted a way to get the differences between the two xmls, instead of just checking to see that there were differences, this is an alternative method I came up with, and I will add as I work on it, as it is still in its infancy.

## Disclaimer

This is an alternate method to a project I was working on, as such, there are no promises that it is the most efficient way to find the differences.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'diffxml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diffxml

## Usage
Require the gem with:
```ruby
require 'DiffXML'
```


Pass two xml documents to the gem using 
```ruby
DiffXML.compareXML(doc1, doc2)
```
the returned value will be an array with the XPaths of all nodes that were not matched.

## To Do
* Plans to return the values of both nodes that are at the XPath in the array, as well as the XPath location are in the works.
* General upkeep and a more rigorous test set are also planned.
* RDoc implementation for documentation.
* optimize searches: the memory handling has been improved, however, the search still does not differentiate between nodes with the same path, meaning xmls in different orders may report false negatives(untested)
because it just compares the string of the node set as opposed to comparing each node in the set individually. and speed is awful past a certain point.
* Add ignore capabilities for XPaths
* Refactor Utility methods into seperate file

## Known Issues
* ~~With large XML documents, specifically with tested documents over 1500 elements, but possibly fewer, the gem will reach a point where it cannot allocate memory.~~
  * Fixed in latest commit, will be applied with version 0.2.0 release, optimization of the compare is still needed

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pbubnar/diffxml.

