# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'corundum'
  spec.version       = '1.0.3'
  spec.authors       = ['ProtoTest, LLC']
  spec.email         = ['info@prototest.com']
  spec.summary       = 'Selenium web automation framework in ruby.'
  spec.description   = 'Corundum was created to simplify the process of creating enterprise-scale automated testing suites.  The inclusion of advanced features, diagnostic information, easy configuration, and enhanced APIs helps make automating in code-based automation tools much more practical.'
  spec.homepage      = 'http://www.prototest.com'
  spec.license       = 'Copyright (c) 2014 ProtoTest'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'bundler', '~> 1.6'
  spec.add_dependency 'rake'
  spec.add_dependency 'rspec', '2.14.1'
  spec.add_dependency 'rspec-expectations', '2.14.5'
  spec.add_dependency 'selenium-webdriver', '2.42.0'
  spec.add_dependency 'builder'
  spec.add_dependency 'oily_png'

end
