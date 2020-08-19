class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit]
  
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if current_user.id != @item.user_id
      redirect_to item_path(@item)
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to item_path(item)
    else
      redirect_to edit_item_path(item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :shipping_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    begin
      @item = Item.find(params[:id])
    rescue
      redirect_to root_path
    end
  end
end
