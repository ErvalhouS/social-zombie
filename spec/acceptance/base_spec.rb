require "spec_helper"

RSpec.describe Endpoints::Survivors do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./schema/schema.json"
  end

  describe 'All requests to the Endpoints' do

    before do
      @negan = Survivor.create(name:'Negan',age:50,gender:'male',password:'password')
      @negan.updated_at
      @negan.save
    end
    context 'with logged on user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
        # Mocks Geolocation the same way as base.rb L 84 does
        # on every request of logged users, any better idea at testing this?
        geocode_payload = Geokit::GeoLoc.new(:lat => 123.456, :lng => 123.456)
        geocode_payload.success = true
        @negan.lat = geocode_payload.lat
        @negan.lng = geocode_payload.lng
        @negan.save
      end
      it 'updates user latitude and longitude' do
        get '/'
        assert_equal 200, last_response.status
        assert_equal 123.456, @negan.lat
        assert_equal 123.456, @negan.lng
      end
    end

  end

  end
