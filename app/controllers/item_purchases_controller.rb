class ItemPurchasesController < ApplicationController
  def index
    begin
      @item = Item.find(params[:item_id])
    rescue
      redirect_to root_path
    end
  end

  def create
  end
end
