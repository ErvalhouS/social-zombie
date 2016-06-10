require 'rails_helper'

describe ReportController, type: :controller do

  describe 'GET #infected_survivors' do
    it { 'renders the percentage of infected survivors as integer'
      get 'infected_survivors'
      should respond_with :ok
    }
  end
  describe 'GET #healthy_survivors' do
    it { 'renders the percentage of non-infected survivors as integer'
      get 'healthy_survivors'
      should respond_with :ok
    }
  end
  describe 'GET #average_resource' do
    it { 'renders an array of rounded average resource per capita, ordered by resource value'
      get 'average_resource'
      should respond_with :ok
    }
  end
  describe 'GET #loss_by_infection' do
    it { 'renders the total resource value lost by infected survivors as integer'
      get 'loss_by_infection'
      should respond_with :ok
    }
  end

end
