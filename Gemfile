source 'https://rubygems.org'
ruby '2.1.7'

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bootstrap_form'
gem 'bcrypt-ruby', '~> 3.1.0' 
gem 'sidekiq'
gem 'mailgun-ruby'
gem 'sentry-raven'
gem 'carrierwave'
gem 'mini_magick'
gem 'stripe'
gem 'stripe_event'
gem 'figaro'
gem 'draper'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'grape'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
  gem 'capybara-email'
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'selenium-webdriver'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'redis'
  gem 'carrierwave-aws'
end

