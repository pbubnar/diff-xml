require 'Nokogiri'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1, doc2)
    if doc1.class == Nokogiri::XML::Document
      collectXPaths(doc1.root)
    else
      collectXPaths(doc1)
    end
    @xpathArray.map!.with_index do |element, i|
      GC.start if i % 50 == 0
      puts "iteration #{i} and #{element}"
      nil if compareToPath(element, doc1, doc2)
    end
  end

  def self.getPath(node, path = nil)
    if node.parent.name.eql? 'document'
      return path
    else
      if path.nil?
        getPath(node, node.name)
      else
        getPath(node.parent, "#{node.parent.name}/#{path}")
      end
    end
  end

  def self.compareToPath(path, doc1, doc2)
    doc2.search(path, doc1.collect_namespaces).to_s == doc1.search(path, doc1.collect_namespaces).to_s
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
