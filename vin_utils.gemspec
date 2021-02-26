require_relative 'lib/vin_utils/version'

Gem::Specification.new do |spec|
  spec.name          = 'vin_utils'
  spec.version       = VinUtils::VERSION
  spec.authors       = ['Diego Stiehl']
  spec.email         = ['seccomiro@users.noreply.github.com']

  spec.summary       = 'A gem to check and suggest VIN identifiers'
  spec.description   = 'A gem to check and suggest VIN identifiers'
  spec.homepage      = 'https://github.com/seccomiro/vin_utils'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/seccomiro/vin_utils'
  spec.metadata['changelog_uri'] = 'https://github.com/seccomiro/vin_utils'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']
end
