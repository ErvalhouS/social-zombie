require "spec_helper"

RSpec.describe Endpoints::Trades do
  include Rack::Test::Methods

  describe "GET /trades" do
    it "succeeds" do
      get "/trades"
      assert_equal 200, last_response.status
    end
  end
end
