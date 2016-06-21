require "spec_helper"

RSpec.describe Endpoints::Schema do
  include Rack::Test::Methods

  let(:schema_filename) { "#{Config.root}/schema/schema.json" }

  subject(:get_schema) { get "/schema.json" }

  context "with a schema.json" do
    let(:contents) { "contents" }

    before do
      allow(File).to receive(:exists?).and_return(true)
      allow(File).to receive(:read).and_return(contents)
    end

    it "returns the schema is present" do
      get_schema
      assert_equal 200, last_response.status
      assert_equal "application/schema+json", last_response.headers["Content-Type"]
      assert_equal contents, last_response.body
    end
  end
end
