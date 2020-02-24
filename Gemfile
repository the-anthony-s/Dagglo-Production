source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
# Use postgres as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'



## Environment
# HAML markup language
gem "haml-rails"
# Autoprefix for Styles
gem "autoprefixer-rails"
# Internationalization
gem 'i18n-tasks', '~> 0.9.30'
# Google Analytics
gem 'google-analytics-rails', '1.1.1'
# Active link tracker
gem 'active_link_to'
# Beautiful ID for the routes
gem 'friendly_id', '~> 5.2.4'
# Category trees
gem 'ancestry'
# Seed data generator
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
# Meta Tags -> SEO
gem 'meta-tags'



## Admin Dashboard
gem 'activeadmin'
gem 'activeadmin_quill_editor'
gem 'chosen-rails'



## Analytics
# Log users activity, info: https://github.com/ankane/ahoy, jquery is a MUST!!!
gem 'ahoy_matey'
# Public Activity tracking
gem 'public_activity'



## Assets
# Icons
gem 'font-awesome-sass', '~> 5.9.0'
# Authentication solution
gem 'devise'
gem 'devise_invitable', '~> 2.0.0'
# Captcha or spam filter. Read more: https://github.com/markets/invisible_captcha
gem 'invisible_captcha'
# Forms
gem 'simple_form'
gem "selectize-rails"
gem 'country_select', require: 'country_select_without_sort_alphabetical'
# Geolocation
gem 'geocoder'
# Money formatting
gem "money"
# PDF Receipts templete
gem 'receipts'
# Hide deleted records but keep them in the database
gem "paranoia", "~> 2.2"


## Errors
# Rescue and report exceptions in non-critical code. Read more: https://github.com/ankane/safely
gem 'safely_block'



## Performance
# Right amount of Rails eager loading. Read more: https://github.com/salsify/goldiloader
gem 'goldiloader'
# Single-process Ruby asynchronous processing library
gem 'sucker_punch'
# A fast JSON parser and Object marshaller
gem 'oj'
# Stores
gem 'redis-rails'



## Payments
# Stripe
gem 'stripe'
gem 'stripe_event'



## Search
# Elasticsearch by Instacard
gem 'searchkick'
# Search analytics
gem 'searchjoy'



## File handling
gem 'shrine', '~> 3.0'
gem 'aws-sdk-s3', '~> 1.14'
gem 'image_processing', '~> 1.10'
gem 'uppy-s3_multipart', '>= 0.3.2'
gem 'marcel'
gem 'fastimage'



## Contact form / Emails
# Mandrill -> Email sender
gem 'mandrill-api', require: "mandrill"





# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Static analysis tool which checks Ruby on Rails applications for security vulnerabilities
  gem 'brakeman'
  # Add a comment summarizing the current schema to the top or bottom
  gem 'annotate'
end


group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bundler'
