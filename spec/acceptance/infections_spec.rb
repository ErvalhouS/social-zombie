require "spec_helper"

RSpec.describe Endpoints::Infections do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./schema/schema.json"
  end

  describe 'POST /infections/:id' do

    before do
      @negan = Survivor.create(name:'Negan',age:50,gender:'male',password:'password')
      @wilson = Survivor.create(name:'Wilson',age:40,gender:'male',password:'password')
      @negan.updated_at
      @wilson.updated_at
      @negan.save
      @wilson.save
    end
    context 'with logged on user' do
      before do
        post '/login', {name: 'Negan', password: 'password'}
      end
      it 'returns created status code and conforms to schema' do
        header "Content-Type", "application/json"
        post "/infections/#{@wilson.id}", MultiJson.encode({})
        assert_equal 201, last_response.status
        assert_schema_conform
      end
    end
    context 'with non-logged on user' do
      before do
        post '/logout'
      end
      it 'returns unauthorized status code and conforms to schema' do
        header "Content-Type", "application/json"
        post "/infections/#{@wilson.id}", MultiJson.encode({})
        assert_equal 401, last_response.status
        assert_schema_conform
      end
    end

  end

end
