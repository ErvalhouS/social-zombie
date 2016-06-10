require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Survivors' do

    get '/survivors' do
      example 'Getting the list of survivors' do
        do_request
        status.should == 200
      end
    end

    get '/survivors/show/:id' do
      survivor = create_survivor
      let(:id){ survivor.id.to_s }
      example 'Getting the details of a survivor' do
        do_request
        status.should == 200
      end
    end

    post 'survivors/create' do
      parameter :survivor, 'Survivor to be created data, as hash'
      example 'Creating a new Survivor' do
        do_request(survivor:{
                       name: 'Alice',
                       age: 22,
                       gender: 'f',
                       lat: 5.8653996,
                       lng: -35.2848054})
        status.should == 201
      end
    end

  patch 'survivors/update/:id' do
    survivor = create_survivor
    let(:id){ survivor.id.to_s }
    parameter :survivor, 'Survivor to be created data, as hash'
    example 'Updating fields on given Survivor' do
      do_request(survivor:{name:'Elijah'})
      status.should == 200
    end
  end

  delete 'survivors/:id' do
    survivor = create_survivor
    let(:id){ survivor.id.to_s }
    example 'Deleting given Survivor' do
      do_request
      status.should == 200
    end
  end

end
