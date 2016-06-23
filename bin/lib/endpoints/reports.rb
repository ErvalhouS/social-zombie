module Endpoints
  class Reports < Base
    namespace "/reports" do
      get do
        encode []
      end

      post do
        status 201
        encode Hash.new
      end

      get "/:id" do
        encode Hash.new
      end

      patch "/:id" do
        encode Hash.new
      end

      delete "/:id" do
        encode Hash.new
      end
    end
  end
end
