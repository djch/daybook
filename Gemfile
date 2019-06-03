source "https://rubygems.org"
ruby "~> 2.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem 'rails', '~> 5.2'
# Use Puma as the app server
gem "puma", "~> 3.12"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 3.0"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.11"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :development, :test do
  gem "sqlite3"
  gem "byebug", platform: :mri
  gem 'capybara', '~> 3'
  gem 'selenium-webdriver'
end

group :development do
  gem "web-console"
  gem "listen", "~> 3.1.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  gem "pg", "~> 1.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Autoprefix any CSS properties that need it
gem "autoprefixer-rails", "~> 8"

# Rails engine for cache-friendly, client-side local time
gem "local_time", "~> 2.0"

# Pagination library courtesy of Basecamp
# https://github.com/basecamp/geared_pagination
gem "geared_pagination", "~> 0.2"

# Fake data generator
gem "faker", group: [:development, :test]

# Derailed: handy benchmarks to keep an eye on memory etc.
gem "derailed_benchmarks", group: :development
gem "stackprof", group: :development
