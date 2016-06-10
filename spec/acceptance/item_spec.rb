require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Items' do
      post 'items/exchange' do
        parameter :my_items, 'My items'
        parameter :other_items, 'Items of other survivor'

        example 'Exchanging items from one survivor to another, with valid params' do
          do_request(item: {
                         my_items: create_survivor(initial_items: [1,1,1,1]).get_items(1,1),
                         other_items:  create_survivor(initial_items: [2,2]).get_items(2)})
          status.should == 200
        end

        example 'Exchanging items from one survivor to another, with invalid params' do

          expect{
            do_request(item: {
                                my_items: create_survivor(initial_items: [1,1,1,1]).get_items(1),
                                other_items:  create_survivor(initial_items: [2,2]).get_items(2)})
          }.to raise_error 'Items can not be traded unevenly!'
        end
      end

      post 'items/inventory' do
        parameter :survivor, 'Survivor identifier'

        example 'Get a list of all items of given survivor' do
          do_request(item: { survivor: create_survivor(initial_items: [1,1,1,1])})
          status.should == 200
        end
      end

end
