source "http://rubygems.org"

# Declare your gem's dependencies in attachinary.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# used by the dummy application
gem 'jquery-rails'
gem 'cloudinary', '1.29.0' # same version used in reverb core
gem 'simple_form'
gem "webrick", "~> 1.8"
gem "sprockets-rails", "~> 3.4"

group :assets do
  gem 'coffee-rails'
end

group :mongoid do
  # mongoid's latest release version i.e. 9.0.1 doesn't support Rails 7.2 yet.
  # However, they have code in their master branch which is supporting Rails 7.2,
  # therefore, using the specific reference here until we get a clean release from them.
  # Cleanup ticket: https://reverb.atlassian.net/browse/PLAT-2225
  gem 'mongoid', github: 'mongodb/mongoid', ref: 'a79e90cb67b8a5865e99a1c6d7cb11e0d7591e7c'
end

group :test do
  # headless chrome without selenium
  # Using a ref until a new gem version is available due to this issue: https://github.com/twalpole/apparition/issues/81
  # Same version used in reverb core
  gem "apparition", git: 'https://github.com/twalpole/apparition', ref: 'ca86be4d54af835d531dbcd2b86e7b2c77f85f34'
  # Cleanup ticket: https://reverb.atlassian.net/browse/PLAT-2226
  gem 'factory_bot_rails', github: 'thoughtbot/factory_bot_rails', ref: 'refs/pull/495/head'
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
