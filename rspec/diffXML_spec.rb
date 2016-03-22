require 'nokogiri'
require 'rspec'
require 'rspec/matchers'
require_relative '../lib/diffXML/diffxml'

describe DiffXML do
  it 'should return an XPath for a given node' do
    xml = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></forth></doc>")
    node = xml.element_children[0].element_children[2].element_children[0].element_children[0]
    expect(DiffXML.getPath(node, node.name)).to eql 'doc/third/firstthird/finalChild'
  end

  it 'should Collect all XPaths of the children into an array' do
   xml = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></forth></doc>")
   DiffXML.collectXPaths(xml)
   expect(DiffXML.getXPathArray.size).to be 3
   expect(DiffXML.getXPathArray).to eq %w(doc/first doc/second doc/third/firstthird/finalChild)
  end

end
