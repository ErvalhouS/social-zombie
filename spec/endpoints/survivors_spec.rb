require "spec_helper"

RSpec.describe Endpoints::Survivors do
  include Rack::Test::Methods

  describe "GET /survivors" do
    it "succeeds" do
      get "/survivors"
      assert_equal 200, last_response.status
    end
  end
end
