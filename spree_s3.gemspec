Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_s3'
  s.version     = '0.1.0'
  s.summary     = 'Amazon S3 integration for Spree'
  s.description = 'Facebook API integration for your Spree store, using the aws-s3 gem.'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Dylan Meissner'
  # s.email             = ''
  # s.homepage          = ''
  # s.rubyforge_project = ''

  s.files        = Dir['README.md', 'LICENSE', 'lib/**/*', 'app/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.30.1')
  s.add_dependency('paperclip', '>=2.3.6')
  s.add_dependency('aws-s3', '>= 0.6.2')
end