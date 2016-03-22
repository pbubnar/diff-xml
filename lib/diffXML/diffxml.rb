require 'version'
require 'Nokogiri'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1)
    if doc1.class == Nokogiri::XML::Document
      collectXPaths(doc1.root)
    else
      collectXPaths(doc1)
    end
    @xpathArray.each {|element| compareToPath(element)}
  end

  def self.getPath(node, path = nil)
    if path.parent.name.eql? 'document'
      path
    else
      getPath(node.parent, "#{node.parent}/#{path}")
    end
  end

  def self.compareToPath(path)
    @doc2.search(path, @doc1.collect_namespaces)
  end

  def self.collectXPaths(doc)
    doc.element_children.each do |child|
      if child.element_children.empty?
        @xpathArray.push(self.getPath(child))
      else
        compareXML(child)
      end
    end
  end
end
