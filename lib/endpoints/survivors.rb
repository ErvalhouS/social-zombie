module Endpoints
  class Survivors < Base
    namespace "/survivors" do
      serializer Serializers::Survivor
      get do
        if params[:page].nil? || params[:page]==0
          params[:page]=1
        end
        if params[:per_page].nil? || params[:per_page]<=0
          params[:per_page]= Config.per_page
        end

        last_modified(Survivor.order(:updated_at).all.last.try(:updated_at))
        headers 'Link' => paginate_attributes(Survivor.all.paginate(page: params[:page], per_page: params[:per_page]))
        encode serialize(Survivor.all.paginate(page: params[:page], per_page: params[:per_page]))
      end

      post do
        survivor = Survivor.new(body_params)
        if survivor.save
          status 201
          encode serialize(survivor)
        else
          status 422
          encode serialize(survivor.errors)
        end
      end

      get "/:id" do |id|
        cache_control :public, max_age: 30
        survivor = Survivor.first(id: id) || halt(404)
        last_modified(survivor.updated_at)
        encode serialize(survivor)
      end

      patch "/:id" do |id|
        protected!
        survivor = Survivor.first(id: id) || halt(404)
        if survivor.update(body_params)
          status 202
          encode serialize(survivor)
        else
          status 422
          encode serialize(survivor.errors)
        end
      end

      delete "/:id" do |id|
        protected!
        survivor = Survivor.first(id: id) || halt(404)
        survivor.destroy
        encode serialize(survivor)
      end

    end

  end
end
