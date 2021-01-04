# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Basic
ruby '~> 2.6.3'
gem 'file_validators'
gem 'jbuilder', '~> 2.9.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search'
gem 'puma', '~> 4.1.0'
gem 'rails', '~> 6.0.0'
gem 'slim'
gem 'webpacker', '~> 4.0.7'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
#
# OOD
gem 'interactor', '~> 3.0' # Allows to create service objects
gem 'u-service'
gem 'virtus'

# Authentication and authorization
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'pundit'
gem 'request_store'

# I18n
gem 'i18n-js', '~> 3.3.0'
gem 'i18n-tasks', '~> 0.9.20'
gem 'rails-i18n'

# Models and resources
gem 'aasm'
gem 'acts_as_list'
gem 'chronic' # Chronic is a pure Ruby natural language date parser.
gem 'chronic_duration' # A simple Ruby natural language parser for elapsed time
gem 'discard', '~> 1.1'
gem 'paper_trail'
gem 'ransack'

# pagination - which should we use?
gem 'kaminari'
gem 'will_paginate', '~> 3.1.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# HTML templator

# Allows to generate API docs based on rspec tests
gem 'apitome'
gem 'rspec_api_documentation'

# PDF generator
gem 'prawn', require: false

# Allows to manage nested forms
gem 'cocoon'

# Allows to manage file validations

group :development, :test do
  gem 'annotate', require: false
  # gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'cucumber-rails', require: false
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'guard', require: false
  gem 'guard-cucumber', require: false, github: 'railsme/guard-cucumber'
  gem 'guard-rspec', require: false
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 4.0.0.beta2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', '~> 0.74.0', require: false
  gem 'rubocop-rails', '~> 2.3.0', require: false
  gem 'rubocop-rspec', '~> 1.35.0', require: false
  gem 'spring'
  gem 'spring-commands-cucumber', require: false
  gem 'spring-commands-rspec', require: false
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 3.28.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
