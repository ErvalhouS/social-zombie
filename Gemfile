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
