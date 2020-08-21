class ItemPurchasesController < ApplicationController
  before_action :set_item

  def index
  end

  def create
    @purchase_info = PurchaseInfo.new(purchase_info_params)
    if @purchase_info.valid?
      pay_item
      @purchase_info.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_info_params
    params.permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def order_params
    params.permit(:token)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  rescue StandardError
    redirect_to root_path
  end
end
