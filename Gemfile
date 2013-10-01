source 'https://rubygems.org'

gem 'rails', '3.2.12'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production, :development do
  gem 'metainspector'
  # so that we don't hit the internet on tests
end

gem 'pg'
gem 'postgres_ext'
gem 'nokogiri'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'sidekiq'
gem 'activerecord-postgres-hstore'
gem 'jquery-rails'
#gem 'clockwork'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'less-rails-bootstrap'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'debugger'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'sextant'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
  gem 'selenium-webdriver'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'database_cleaner'
  gem 'launchy'
end
