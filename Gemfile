source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#gem 'sdoc', group: :doc

gem 'slim-rails'
gem 'devise'
gem 'carrierwave'
gem 'remotipart'

gem 'cocoon'

# for ActionCable
gem 'skim'
gem 'gon'

# 3.7   DEPRECATION WARNING: Sprockets method `register_engine` is deprecated.
gem 'sprockets', '3.6.3'

gem 'json-schema'
gem 'json_spec'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'brakeman', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test, :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'rubocop', require: false

  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'poltergeist'

  # For debugging
  gem 'pry-rails'
  gem 'pry-byebug'

  # устарел
  # gem 'quiet_assets'
end

# более старшая версия 0.19.2-0.19.4 вызывает предупреждение https://github.com/erikhuda/thor/issues/538
# Expected string default value for '--jbuilder'; got true (boolean)
# Expected string default value for '--helper'; got true (boolean)
# Expected string default value for '--assets'; got true (boolean)
gem 'thor', '0.19.1'

group :test do
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'capybara'
  gem 'launchy'
  gem 'fuubar'
end