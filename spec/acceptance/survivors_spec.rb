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

  before do
    @negan = Survivor.create(name:'Negan',age:50,gender:'male',password:'password')

    # temporarily touch #updated_at until we can fix prmd
    @negan.updated_at
    @negan.save
  end

  describe 'GET /survivors' do
    it 'returns correct status code and conforms to schema' do
      get '/survivors'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'POST /survivors' do
      it 'returns created status code and conforms to schema' do
        header "Content-Type", "application/json"
        post '/survivors', MultiJson.encode(Survivor.new(name:'Wilson',age:30,gender:'male',password:'password'))
        assert_equal 201, last_response.status
        assert_schema_conform
      end
  end

  describe 'GET /survivors/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/survivors/#{@negan.id}"
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'PATCH /survivors/:id' do
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
        @negan.gender = 'alpha'
      end

      it 'returns accepted status code and conforms to schema' do
        header "Content-Type", "application/json"
        patch "/survivors/#{@negan.id}", MultiJson.encode(@negan)
        assert_equal 202, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do

      it 'returns unauthorized status code and conforms to schema' do
        header "Content-Type", "application/json"
        patch "/survivors/#{@negan.id}", MultiJson.encode({})
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end
  end

  describe 'DELETE /survivors/:id' do
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end

      it 'returns ok status code and conforms to schema' do
        delete "/survivors/#{@negan.id}"
        assert_equal 200, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do

      it 'returns unauthorized status code and conforms to schema' do
        delete "/survivors/#{@negan.id}"
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end
  end
end
