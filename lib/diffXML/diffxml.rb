require 'version'
require 'Nokogiri'

module DiffXML
  def self.compareXML(doc1, doc2)


  end

  def self.getPath(node, path)
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
