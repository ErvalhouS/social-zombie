<<<<<<< HEAD
source "https://rubygems.org"
ruby "2.3.1"

gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", "~> 0.17"
gem "pry"
gem "puma", "~> 2.16"
gem "rack-ssl"
gem "rack-timeout", "~> 0.4"
gem "rake"
gem "redis"
gem "rollbar", require: "rollbar/middleware/sinatra"
gem "sequel", "~> 4.34"
gem "sequel-paranoid"
gem "sequel_pg", "~> 1.6", require: "sequel"
gem "sinatra", "~> 1.4", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"
gem "sinatra-rate-limiter"
gem "sucker_punch"
gem "geokit"
gem "bcrypt"
gem "will_paginate"
gem "dalli"
gem "rack-cache"
gem "jwt"
=======
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'

gem 'pg', group: :production
gem 'sqlite3', group: [:development, :test]

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
>>>>>>> 82e0d4946fb88643ca0afc143364ced15e297d32

group :development, :test do
  gem "pry-byebug"
end

group :test do
  gem "simplecov", require: false
  gem "committee"
  gem "database_cleaner"
  gem "dotenv"
  gem "rack-test"
  gem "rspec"
end
