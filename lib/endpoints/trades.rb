module Endpoints
  class Trades < Base
    namespace "/trades" do
      serializer Serializers::Trade

      get do
        if params[:page].nil? || params[:page]==0
          params[:page]=1
        end
        if params[:per_page].nil? || params[:per_page]<=0
          params[:per_page]= Config.per_page
        end

        last_modified(Trade.order(:updated_at).all.last.try(:updated_at))
        headers 'Link' => paginate_attributes(Trade.all.paginate(page: params[:page], per_page: params[:per_page]))
        encode serialize(Trade.all.paginate(page: params[:page], per_page: params[:per_page]))
      end

      post do
        protected!
        trade = Trade.new(body_params)
        if trade.save
          status 201
          encode serialize(trade)
        else
          status 422
          encode serialize(trade.errors)
        end
      end

      get "/:id" do |id|
        protected!
        cache_control :public, max_age: 30
        trade = Trade.first(id: id) || halt(404)
        last_modified(trade.updated_at)
        encode serialize(trade)
      end

      patch "/:id" do |id|
        protected!
        trade = Trade.first(id: id) || halt(404)
        if trade.update(body_params)
          status 202
          encode serialize(trade)
        else
          status 422
          encode serialize(trade.errors)
        end
      end

      delete "/:id" do |id|
        protected!
        trade = Trade.first(id: id) || halt(404)
        trade.destroy
        encode serialize(trade)
      end
    end
  end
end
