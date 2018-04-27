Gem::Specification.new do |gem|
  gem.name     = "sms_aero"
  gem.version  = "0.2.0"
  gem.author   = "Andrew Kozin (nepalez)"
  gem.email    = "andrew.kozin@gmail.com"
  gem.homepage = "https://github.com/nepalez/sms_aero"
  gem.summary  = "HTTP(s) client to SMS Aero API"
  gem.license  = "MIT"

  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = gem.files.grep(/^spec/)
  gem.extra_rdoc_files = Dir["README.md", "LICENSE", "CHANGELOG.md"]

  gem.required_ruby_version = ">= 2.2"

  gem.add_runtime_dependency "evil-client", "~> 3.0"

  gem.add_development_dependency "rake", ">= 10"
  gem.add_development_dependency "rspec", "~> 3.0"
  gem.add_development_dependency "rubocop", "~> 0.48"
  gem.add_development_dependency "webmock", "~> 2.1"
end
