require 'DiffXML'
module DiffXML

  class Utils
    def self.collectXPaths(doc, xpArray)
      doc.element_children.each do |child|
        if child.element_children.empty?
          xpArray.push(getPath(child,child.name)) unless child.content.empty?
        else
          collectXPaths(child, xpArray)
        end
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
  end
end
