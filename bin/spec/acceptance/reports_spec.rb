require "spec_helper"

RSpec.describe Endpoints::Reports do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./schema/schema.json"
  end

  describe 'GET /reports' do
    it 'returns correct status code and conforms to schema' do
      get '/reports'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'POST /reports' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/reports', MultiJson.encode({})
      assert_equal 201, last_response.status
      assert_schema_conform
    end
  end

  describe 'GET /reports/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/reports/123"
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'PATCH /reports/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch '/reports/123', MultiJson.encode({})
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'DELETE /reports/:id' do
    it 'returns correct status code and conforms to schema' do
      delete '/reports/123'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end
end
