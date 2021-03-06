source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.3.2'
# Use PostgreSQL as the database
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use JSON web tokens for authentication
gem 'json_web_token', '~> 0.3.5'
gem 'jwt_claims', '~> 0.1.0'
# For CORS
gem 'rack-cors', require: 'rack/cors'
# For JS uglification
gem 'uglifier'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # Manage environment variables
  gem 'dotenv-rails', '~> 2.5'
  gem 'faker'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 4.1.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'foreman', '~> 0.87.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# GraphQL
gem 'graphql', '1.8'
gem 'graphiql-rails', '1.4.4', group: :development
gem 'search_object', '1.2.0'
gem 'search_object_graphql', '0.1'
gem 'apollo_upload_server', '2.0.0.beta.3'
