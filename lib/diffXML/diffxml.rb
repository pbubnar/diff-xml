# require 'version'
require 'Nokogiri'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1, doc2)
    @doc1 = doc1
    @doc2 = doc2
    if doc1.class == Nokogiri::XML::Document
      collectXPaths(doc1.root)
    else
      collectXPaths(doc1)
    end
    @xpathArray.each {|element| compareToPath(element)}
  end

  def self.getPath(node, path = nil)
    if node.parent.name.eql? 'document'
      return "/#{path}"
    else
      getPath(node.parent, "#{node.parent.name}/#{path}")
    end
  end

  def self.compareToPath(path)
    @doc2.search(path, @doc1.collect_namespaces)
  end

  def self.collectXPaths(doc)
    doc.element_children.each do |child|
      if child.element_children.empty?
        @xpathArray.push(getPath(child,child.name)) unless child.content.empty?
      else
        collectXPaths(child)
      end
    end
  end
  def self.getXPathArray
    @xpathArray
  end
end
