# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "diffxml"
  spec.version       = '0.1.1'
  spec.authors       = ["Jake Bubnar"]
  spec.email         = ["jake@pjbapps.com"]
  spec.licenses       = ["MIT"]
  spec.summary       = 'A simple xml comparison tool to get a list of diffs between two files passed to it'
  spec.description   = 'Goes through each child to find the XPaths of each final child, and compares them to the path in the second file'
  spec.homepage      = 'https://github.com/pbubnar/diff-xml'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.test_files = ['rspec/diffXML_spec.rb']

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rspec", "~>3.4", ">= 3.4.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "nokogiri", "~> 1.6", ">= 1.6.7.2"
end
