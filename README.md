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

Pass two xml documents to the gem using 
```ruby
DiffXML.compareXML(doc1, doc2)
```
the returned value will be an array with the XPaths of all nodes that were not matched.

## To Do
Plans to return the values of both nodes that are at the XPath in the array, as well as the XPath location are in the works.
General upkeep and a more rigorous test set are also planned.
RDoc implementation for documentation.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pbubnar/diffxml.

