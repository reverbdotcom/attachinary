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
  gem 'mongoid'
end

group :test do
  # headless chrome without selenium
  # Using a ref until a new gem version is available due to this issue: https://github.com/twalpole/apparition/issues/81
  # Same version used in reverb core
  gem "apparition", git: 'https://github.com/twalpole/apparition', ref: 'ca86be4d54af835d531dbcd2b86e7b2c77f85f34'
end


# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
