source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem "rails", "~> 7.0.2", ">= 7.0.2.2"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails", '~> 1.0.0'
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"
gem "sassc-rails"
gem 'bootstrap', '~> 5.1.3'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.8'
gem 'faker', '~> 2.19'
gem 'will_paginate', '~> 3.3'
gem 'active_storage_validations', '~> 0.9.6'
gem 'image_processing', '1.12.1'
gem 'mini_magick', '4.9.5'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "spring"
end

group :test do
  gem "capybara"
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.5'
  gem 'minitest', '~> 5.15'
  gem 'minitest-reporters', '~> 1.5'
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem 'pg', '~> 1.3', '>= 1.3.2'
end
