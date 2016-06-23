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

  before do
    @negan = Survivor.create(name:'Negan',age:50,gender:'male',password:'password')
    @wilson = Survivor.create(name:'Wilson',age:40,gender:'male',password:'password')
    @negan.save
    @wilson.save
    @negans_water = Item.create(name:'Water',item_value:4,survivor_id:@negan.id)
    @wilsons_water = Item.create(name:'Water',item_value:4,survivor_id:@wilson.id)
    @negans_food = Item.create(name:'Food',item_value:3,survivor_id:@negan.id)
    @wilsons_food = Item.create(name:'Food',item_value:3,survivor_id:@wilson.id)
    @negans_medication = Item.create(name:'Medication',item_value:2,survivor_id:@negan.id)
    @wilsons_medication = Item.create(name:'Medication',item_value:2,survivor_id:@wilson.id)
    @negans_ammunition = Item.create(name:'Ammunition',item_value:1,survivor_id:@negan.id)
    @wilsons_ammunition = Item.create(name:'Ammunition',item_value:1,survivor_id:@wilson.id)

    @negans_water.updated_at
    @wilsons_water.updated_at
    @negans_food.updated_at
    @wilsons_food.updated_at
    @negans_medication.updated_at
    @wilsons_medication.updated_at
    @negans_ammunition.updated_at
    @wilsons_ammunition.updated_at
    @negans_water.save
    @wilsons_water.save
    @negans_food.save
    @wilsons_food.save
    @negans_medication.save
    @wilsons_medication.save
    @negans_ammunition.save
    @wilsons_ammunition.save
  end

  describe 'GET /reports/survivors' do
    it 'returns ok status code and a report of population status, including: healthy percentage, infected percentage, and totals' do
      get '/reports/survivors'
      assert_equal 200, last_response.status
    end
  end

  describe 'GET /reports/items' do
    it 'returns correct status code and conforms to schema' do
      get '/reports/items'
      assert_equal 200, last_response.status
    end
  end
end
