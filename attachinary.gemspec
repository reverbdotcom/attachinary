$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "attachinary/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "attachinary"
  s.version     = Attachinary::VERSION
  s.authors     = ["Milovan Zogovic"]
  s.email       = ["milovan.zogovic@gmail.com"]
  s.homepage    = ""
  s.summary     = "attachinary-#{s.version}"
  s.description = "Attachments handler for Rails that uses Cloudinary for storage."

  if s.respond_to?(:metadata)
    s.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  s.metadata = { "github_repo" => "ssh://github.com/reverbdotcom/attachinary" }

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 7.2.1'
  s.add_dependency 'cloudinary'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'valid_attribute'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rb-fsevent', '~> 0.9.1'
  s.add_development_dependency 'guard-rspec'
end
