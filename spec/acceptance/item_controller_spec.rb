require 'rails_helper'

describe ItemController, type: :controller do
  describe 'POST #exchange' do
    context 'with evenly distributed item value' do
      params = { item: {
          my_items: create_survivor(initial_items: [1,1,1,1]).get_items(1,1),
          other_items:  create_survivor(initial_items: [2,2]).get_items(2)}}

      it { 'it exchanges items from one survivor to another and renders first survivor as JSON'
        post 'exchange', params, { format: 'json' }
        should respond_with :ok
      }

    end

    context 'with invalid params' do

      params = { item: {
          my_items: create_survivor(initial_items: [1,1,1,1]).get_items(1),
          other_items:  create_survivor(initial_items: [2,2]).get_items(2)}}
      it  { 'to raise error can not be trade unevenly '
        expect {
          post 'exchange', params, { format: 'json' }}.to raise_error 'Items can not be traded unevenly!'
      }

    end

  end

  describe 'GET #inventory' do
    params = { item: { survivor: create_survivor(initial_items: [1,1,1,1])} }
    it { 'renders the item list of a survivor'
      post 'inventory', params, { format: 'json' }
      should respond_with :ok
    }
  end


end
