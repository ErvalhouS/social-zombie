require "spec_helper"

RSpec.describe Endpoints::Trades do
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
    @wilson = Survivor.create(name:'Wilson',age:40,gender:'male',password:'password')
    @negans_water = Item.new(name:'Water',item_value:4,survivor_id:@negan.id)
    @wilsons_water = Item.new(name:'Water',item_value:4,survivor_id:@wilson.id)

    @trade= Trade.create
    @trade.from_items = MultiJson.encode(items: [@negans_water.to_hash])
    @trade.to_items = MultiJson.encode(items: [@wilsons_water.to_hash])
    # temporarily touch #updated_at until we can fix prmd
    @negan.updated_at
    @wilson.updated_at
    @negans_water.updated_at
    @wilsons_water.updated_at
    @trade.updated_at

    @negan.save
    @wilson.save
    @negans_water.save
    @wilsons_water.save

    @trade.save
  end

  describe 'GET /trades' do
      it 'returns correct status code and conforms to schema' do
        get '/trades'
        assert_equal 200, last_response.status
        assert_schema_conform
      end
  end

  describe 'POST /trades' do
    before do
      @example= Trade.new
      @example.from_items = MultiJson.encode(items: [@negans_water.to_hash])
      @example.to_items = MultiJson.encode(items: [@wilsons_water.to_hash])
    end
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end
      it 'returns created status code and conforms to schema' do
        header "Content-Type", "application/json"
        post '/trades', MultiJson.encode(@example)
        assert_equal 201, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do
      before do
        post '/logout'
      end
      it 'returns unathorized status code and conforms to schema' do
        header "Content-Type", "application/json"
        post '/trades', MultiJson.encode(@example)
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end

  end

  describe 'GET /trades/:id' do

    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end
      it 'returns correct status code and conforms to schema' do
        get "/trades/#{@trade.id}"
        assert_equal 200, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do
      before do
        post '/logout'
      end
      it 'returns unathorized status code and conforms to schema' do
        get "/trades/#{@trade.id}"
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end
  end

  describe 'PATCH /trades/:id' do
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
        @trade.accepted = true
      end

      it 'returns accepted status code and conforms to schema' do
        header "Content-Type", "application/json"
        patch "/trades/#{@trade.id}", MultiJson.encode(@trade)
        assert_equal 202, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do
      before do
        post '/logout'
      end
      it 'returns unauthorized status code and conforms to schema' do
        header "Content-Type", "application/json"
        patch "/trades/#{@trade.id}", MultiJson.encode({})
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end
  end

  describe 'DELETE /trades/:id' do
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end

      it 'returns ok status code and conforms to schema' do
        delete "/trades/#{@trade.id}"
        assert_equal 200, last_response.status
        assert_schema_conform
      end
    end
    context 'With non-logged user' do
      before do
        post '/logout'
      end
      it 'returns unauthorized status code and conforms to schema' do
        delete "/trades/#{@trade.id}"
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end
  end
end
