require "spec_helper"

RSpec.describe Endpoints::Reports do
  include Rack::Test::Methods

  describe "GET /reports" do
    it "succeeds" do
      get "/reports"
      assert_equal 200, last_response.status
    end
  end
end
