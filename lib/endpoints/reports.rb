module Endpoints
  class Reports < Base
    namespace "/reports" do

      get "/survivors" do
        encode Survivor.status
      end

      get "/items" do
        encode Item.status
      end

    end
  end
end
