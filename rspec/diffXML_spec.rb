require 'nokogiri'
require 'rspec'
require 'rspec/matchers'
require_relative '../lib/diffXML/diffxml'

describe DiffXML do
  xml1 = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></fourth></doc>")
  xml2 = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></fourth></doc>")
  it 'should return an XPath for a given node' do
    node = xml1.element_children[0].element_children[2].element_children[0].element_children[0]
    expect(DiffXML.getPath(node, node.name)).to eql '/doc/third/firstthird/finalChild'
  end

  it 'should Collect all XPaths of the children into an array' do
   DiffXML.collectXPaths(xml1)
   expect(DiffXML.getXPathArray.size).to be 3
   expect(DiffXML.getXPathArray).to eql %w[/doc/first /doc/second /doc/third/firstthird/finalChild]
  end

  it 'should retrieve and compare a node from a second document using a Path' do
    expect(DiffXML.compareToPath('doc/first',xml1,xml2)).to eql true
  end

end
