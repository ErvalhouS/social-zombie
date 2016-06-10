require 'rails_helper'

describe SurvivorController, type: :controller do

  describe 'GET #index' do
    it { 'renders the list of survivors'
      get :index
      should respond_with :ok
    }
  end

  describe 'GET #show' do
    it { 'renders the list of survivors'
    survivor = create_survivor
      get :show, id:  survivor.id.to_s
      should respond_with :ok
    }
  end

  describe 'POST #create' do
    it { 'renders the list of survivors'
      post 'create', survivor:{
                       name: 'Alice',
                       age: 22,
                       gender: 'f',
                       lat: 5.8653996,
                       lng: -35.2848054}
      should respond_with :created
    }
  end


  describe 'PATCH/PUT #update' do
    it { 'renders the list of survivors'
      survivor = create_survivor
      put :update, id:  survivor.id.to_s, survivor:{name:'Elijah'}
      should respond_with :ok
    }
  end

  describe 'DELETE #destroy' do
    it { 'renders the list of survivors'
    survivor = create_survivor
    delete :destroy, id: survivor.id.to_s
    should respond_with :ok
    }
  end

end
