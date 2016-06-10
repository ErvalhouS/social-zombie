class ItemController < ApplicationController

  # POST /items/exchange.json
  def exchange
      if Item.exchange(item_params[:my_items], item_params[:other_items])
        render json: Item.find(item_params[:my_items].first).survivor, status: :ok
      else
        render json: item_params[:item_value].errors, status: :unprocessable_entity
      end
  end

  # POST /items/inventory/1.json
  def inventory
      render json: Item.inventory(item_params[:suvivor]), status: :ok
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:survivor, :item_value, my_items: [], other_items: [])
  end
end

