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

    @negans_water = Item.create(name:'Water',item_value:4,survivor_id:@negan.id)
    @wilsons_water = Item.create(name:'Water',item_value:4,survivor_id:@wilson.id)

    #Negan is trying to trade his water with Wilson
    @trade = Trade.create( to: @wilson.id, from_items: MultiJson.encode([@negans_water.to_hash]) )

    @trade.save

    @trade.updated_at
    @negans_water.updated_at
    @wilsons_water.updated_at
    @negan.updated_at
    @wilson.updated_at
    @negan.save
    @wilson.save
    @negans_water.save
    @wilsons_water.save
    #Wilson has accepted the trade, and has sent his water as
    @trade.accept(@wilsons_water)
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
      @example = Trade.new( to: @wilson.id, from_items: MultiJson.encode([@negans_water.to_hash]) )
    end
    context 'With logged user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end
      it 'returns created status code, conforms to schema and with `pending_trade` HTTP header on any request' do
        header "Content-Type", "application/json"
        post '/trades', MultiJson.encode(@example)
        assert_equal 201, last_response.status
        assert_schema_conform
        get '/trades'
        refute last_response.headers["pending_trade"].nil?
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
        @example = Trade.new( to: @wilson.id, from_items: MultiJson.encode([@negans_water.to_hash]) )
        @example.save
        @example.to_items = @wilsons_water
      end

      it 'returns accepted status code and conforms to schema' do
        header "Content-Type", "application/json"
        patch "/trades/#{@trade.id}", MultiJson.encode(@example)
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
