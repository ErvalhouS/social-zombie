module Endpoints
  class Infections < Base
    namespace "/infections" do

      post "/:id" do |id|
        protected!
        @infection = Infection.create(survivor_id:id,reporter_id:current_user.id)
        if @infection.save
          status 201
          encode @infection
        else
          status 422
          encode @infection.errors
        end
      end

    end
  end
end
