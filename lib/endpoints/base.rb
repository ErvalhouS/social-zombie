require_relative 'pliny/helpers/auth.rb'
module Endpoints
  # The base class for all Sinatra-based endpoints. Use sparingly.
  require 'will_paginate'
  require 'will_paginate/sequel'
  require 'will_paginate/array'
  require 'sinatra/rate-limiter'
  require 'sequel/extensions/pagination'
  require 'openssl'
  require 'jwt'
  require 'geokit'

  class Base < Sinatra::Base
    register Sinatra::Namespace
    register Sinatra::RateLimiter


    helpers Pliny::Helpers::Encode
    helpers Pliny::Helpers::Params
    helpers Pliny::Helpers::Serialize
    # Personalized auth helper
    helpers Pliny::Helpers::Auth

    require 'will_paginate'
    require 'will_paginate/sequel'

    # Auth keys loading
    signing_key_path = File.expand_path("../../../app.rsa", __FILE__)
    verify_key_path = File.expand_path("../../../app.rsa.pub", __FILE__)

    signing_key = ""
    verify_key = ""

    File.open(signing_key_path) do |file|
      signing_key = OpenSSL::PKey.read(file)
    end

    File.open(verify_key_path) do |file|
      verify_key = OpenSSL::PKey.read(file)
    end

    set :signing_key, signing_key
    set :verify_key, verify_key

    enable :rate_limiter
    enable :sessions
    set :dump_errors, false
    set :raise_errors, true
    set :root, Config.root
    set :show_exceptions, false
    set :rate_limiter_environments,     [:production]
    set :rate_limiter_default_limits,   [1000, 60*60]
    set :rate_limiter_redis_conn,       Redis.new(url: Config.redis_url)
    set :rate_limiter_redis_namespace,  'rate_limit'
    set :rate_limiter_redis_expires,    24*60*60

    set :rate_limiter_default_options, {
                                         send_headers:   true,
                                         header_prefix:  'Rate-Limit',
                                         identifier:     Proc.new{ |request| request.ip }
                                     }

    set :session_secret, "supersecret"

    configure :development do
      register Sinatra::Reloader
      also_reload "#{Config.root}/lib/**/*.rb"
    end

    error Sinatra::NotFound do
      raise Pliny::Errors::NotFound
    end

    before do
      rate_limit
      # call for setting @user_id if logged
      authorized?
      if @user_id
        pending_trade = Survivor.find(token: @user_id).try(:pending_trade)
        if pending_trade
          headers 'pending_trade' => serialize(pending_trade)
        end
      end
      # geocoded position recorded if logged
      unless Geokit::Geocoders::IpGeocoder.private_ip_address?(request.ip) || @user_id.nil?
        res=Geokit::Geocoders::MultiGeocoder.geocode(Geokit::Geocoders::IpGeocoder.do_geocode(request.ip).to_geocodeable_s)
        survivor = Survivor.find(token: @user_id)
        survivor.lat= res.lat
        survivor.lng= res.lng
        survivor.save
      end
    end

    if memcache_servers = ENV["MEMCACHE_SERVERS"]
      use Rack::Cache,
          verbose: true,
          metastore:   "memcached://#{memcache_servers}",
          entitystore: "memcached://#{memcache_servers}"
    end

    def paginate_attributes(object)
      {
          current_page: object.current_page,
          next_page: object.next_page,
          prev_page: object.previous_page,
          total_pages: object.total_pages,
          total_count: object.total_entries
      }
    end

    def filter(filtering_params)
      # no scope search
      results = self.where(nil)
      filtering_params.each do |key, value|
        # applying scopes
        results = results.public_send(key, value) if value.present?
      end
      results
    end

    def sort_results(sort_param)
      # default sort
      results = self.order(:created_at.desc)
      if sort_param.present?
        # sort by passing param directly or with a plus before
        # sort in reverse order if the sort param starts with a hyphen
        # allows you to create links like ....&sort=name...   or  ....&sort=-age....   or  ....&sort=-age,+name.... for reverse order by name
        sort_param.split(',').each do |value|
          # applying reverse sorts
          if value.start_with?('-')
            results = results.order(value.sub(/^-/, '').to_sym.desc)
          else
            results = results.order(value.sub(/^+/, '').to_sym)
          end
        end
      end
      results
    end
  end
end
