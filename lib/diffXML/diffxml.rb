require 'version'
require 'Nokogiri'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1)
    if doc1.class == Nokogiri::XML::Document
      compareXML(doc1.root)
    else
      doc1.element_children.each do |child|
        if child.element_children.empty?
          @xpathArray.push(self.getPath(child))
        else
          compareXML(child)
        end
      end
    end

  end

  def self.getPath(node, path = nil)
    if path.parent.name.eql? 'Document'
      path
    else
      getPath(node.parent, "#{node.parent}/#{path}")
    end
  end

  def self.compareToPath(path)
    @doc2.search(path, @doc1.collect_namespaces)
  end
end
