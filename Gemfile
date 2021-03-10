# frozen_string_literal: true

source 'https://rubygems.org'

solidus_branch = ENV.fetch('SOLIDUS_BRANCH', 'master')

gem 'solidus', github: 'solidusio/solidus', branch: solidus_branch
gem 'avatax-ruby', github: 'whitespectre/avatax', branch: 'adn'

gem 'solidus_auth_devise'

gem 'factory_bot', '~> 4.8'

case ENV['DB']
when 'postgres'
  gem 'pg'
when 'mysql'
  gem 'mysql2'
else
  gem 'sqlite3', '~> 1.4'
end

gemspec
