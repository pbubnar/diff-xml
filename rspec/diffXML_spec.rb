require 'nokogiri'
require 'rspec'
require 'rspec/matchers'
require_relative '../lib/diffxml'

describe DiffXML do
  xml1 = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></fourth></doc>")
  xml2 = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asdf</finalChild></firstthird></third><fourth></fourth></doc>")
  xml3 = Nokogiri::XML("<doc xmlns='foo:bar'><first>foo  bar baz</first><second>things</second><third>
                        <firstthird><finalChild>asfd</finalChild></firstthird></third><fourth></fourth></doc>")


  it 'should return an XPath for a given node' do
    node = xml1.element_children[0].element_children[2].element_children[0].element_children[0]
    expect(DiffXML::Utils.getPath(node, node.name)).to eql 'doc/third/firstthird/finalChild'
  end

  it 'should return an XPath for a given node when no name is passed in' do
    node = xml1.element_children[0].element_children[2].element_children[0].element_children[0]
    expect(DiffXML::Utils.getPath(node)).to eql 'doc/third/firstthird/finalChild'
  end

  it 'should Collect all XPaths of the children into an array' do
   DiffXML::Utils.collectXPaths(xml1, DiffXML.getXPathArray)
   expect(DiffXML.getXPathArray.size).to be 3
   expect(DiffXML.getXPathArray).to eql %w[doc/first doc/second doc/third/firstthird/finalChild]
  end

  it 'should retrieve and compare a node from a second document using a Path' do
    expect(DiffXML.compareToPath('doc/first',xml1,xml2)).to eql true
  end

  it 'should go through 2 XMLs removing XPaths from the array as they are found' do
    expect(DiffXML.compareXML(xml1,xml2).size).to be 0
  end

  it 'should return the differences in the event of a non match' do
    expect(DiffXML.compareXML(xml1,xml3).size).to be 1
    expect(DiffXML.getXPathArray[0].to_s).to eql 'doc/third/firstthird/finalChild'
  end

  it 'should handle large xml documents without running out of memory' do
    largeXML1 = Nokogiri::XML(File.read('./wikimediaxml_test.xml'))
    largeXML2 = Nokogiri::XML(File.read('./wikimediaxml_test.xml'))
    expect(DiffXML.compareXML(largeXML1,largeXML2).size).to be 0
  end

end
