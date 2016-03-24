require 'Nokogiri'
require 'DiffXML/utils'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1, doc2)
    @namespaces = doc1.collect_namespaces
    if doc1.class == Nokogiri::XML::Document
      DiffXML::Utils.collectXPaths(doc1.root, @xpathArray)
    else
      DiffXML::Utils.collectXPaths(doc1, @xpathArray)
    end
    @xpathArray.delete_if.with_index do |element, i|
      puts "iteration #{i} and #{element}"
      compareToPath(element, doc1, doc2)
    end
  end

  def self.compareToPath(path, doc1, doc2)
    doc2.search(path, @namespaces).to_s == doc1.search(path, @namespaces).to_s
  end

  def self.getXPathArray
    @xpathArray
  end
end
