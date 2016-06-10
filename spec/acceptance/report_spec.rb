require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Reports' do

  get '/reports/infected_survivors' do
    example 'It renders the percentage of infected survivors as integer' do
      do_request
      status.should == 200
    end
  end
  get '/reports/healthy_survivors' do
    example 'It renders the percentage of non-infected survivors as integer' do
      do_request
      status.should == 200
    end
  end
  get '/reports/average_resource' do
    example 'It renders an array of rounded average resource per capita, ordered by resource value' do
      do_request
      status.should == 200
    end
  end
  get '/reports/loss_by_infection' do
    example 'It renders the loss of resource value to zombies, and a hash with resource value as key and quantity as value' do
      do_request
      status.should == 200
    end
  end
end
