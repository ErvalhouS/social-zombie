require "spec_helper"

RSpec.describe Endpoints::Reports do
  include Rack::Test::Methods

  describe "GET /reports/survivors" do
    it "succeeds" do
      get "/reports/survivors"
      assert_equal 200, last_response.status
    end
  end
end
