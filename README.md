# Social-Zombie

[![Build Status](https://travis-ci.org/ErvalhouS/social-zombie.svg?branch=master)](https://travis-ci.org/ErvalhouS/social-zombie)

Social-zombie is a system to share resources between non-infected humans. It consists on an API based on Pliny, that features:

* Config: `ENV` wrapper for explicit defining what config vars are mandatory and optional
* Endpoints: the Sinatra equivalent of a Rails Controller
* Initializers: tiny files to configure libraries
* Mediators: plain ruby classes to manipulate models
* Models: very thin wrappers around the database
* CORS middleware to allow JS developers to consume your API
* Rollbar for tracking exceptions, asynchronously with SuckerPunch
* Log helper that logs in data format to stdout
* Mediators to help encapsulate more complex interactions
* Rspec for lean and fast testing
* Puma as the web server, configured for optimal performance on Heroku
* Rack-test to test the API endpoints
* Request IDs
* RequestStore, thread safe option to store data with the current request
* Sequel for ORM
* Versioning to allow versioning your API in the HTTP `Accept header`

Beside those, there are some more practical features, e.g.:

* Paging - Sorting - Filtering on collections
* Rate limiting
* Last-modified and time-based caching
* TLS connections enforcing

# Requirements

* Postgres version greater than 9.3 with the uuid-ossp module. Most installers will have this covered, you can confirm it's available by running `CREATE EXTENSION "uuid-ossp"`;
* Memcache for Rack::Cache
* Redis for Rate Limiting
* Foreman, to declare processes with Procfile
* Ruby, Rubygems, Sinatra

# Installation

* Install dependencies

Refer to file [setup_ubuntu.sh](https://github.com/ErvalhouS/social-zombie/blob/master/setup_ubuntu.sh) for commands needed to install core dependencies on an Ubuntu 12.04+ Linux machine.

* If you already have all dependencies in place, just clone app then run the bin/setup script to install gem dependencies, create databases, etc:
```
$ git clone --branch=master https://github.com/ErvalhouS/social-zombie.git social-zombie
$ cd social-zombie
$ bin/setup
```
* You can confirm your environment is setup by running tests:
```
$ rake
```
* And use Foreman to boot your app server:
```
$ foreman start
```
* Refer to [schema.md](https://github.com/ErvalhouS/social-zombie/blob/master/schema.md) for schema of application and use examples

# WARNING!
# DON'T FORGET TO ADD ".env" AND ".env.test" ON .gitignore TO AVOID PARAMS LEAKING TO THE SCARY INTERNET
# EXPORT EACH VALUE AS ENVROIMENT VARIABLE INSTEAD, IS MUCH SAFER!
