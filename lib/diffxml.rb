require 'Nokogiri'
require 'DiffXML/utils'

module DiffXML
  @xpathArray = []
  def self.compareXML(doc1, doc2, ignores = [], css = false)
    raise "Expected true or false for css parameter, got #{css}"  unless css.is_a? TrueClass or css.is_a? FalseClass
    @namespaces = doc1.collect_namespaces
    cssClass = Nokogiri::CSS
    if doc1.class == Nokogiri::XML::Document
      DiffXML::Utils.collectXPaths(doc1.root, @xpathArray)
    else
      DiffXML::Utils.collectXPaths(doc1, @xpathArray)
    end
    if !ignores.empty?
      ignores.each do |ignore|
        if css
          @xpathArray.delete(cssClass.xpath_for(ignore)[0])
        else
        @xpathArray.delete(ignore)
        end
      end
    end
    @xpathArray.delete_if do |element|
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
