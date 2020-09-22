class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :search_item, only: [:index, :show, :search]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
    @item_tag = ItemTag.new
  end

  def create
    @item_tag = ItemTag.new(item_params)
    if @item_tag.valid?
      @item_tag.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    set_tag_list
  end

  def edit
    @item_tag = ItemTag.new
    redirect_to item_path(@item) if current_user.id != @item.user_id
  end

  def update
    @item_tag = ItemTag.new(item_params.merge(item_id: params[:id]))
    if @item_tag.valid?(:update)
      @item_tag.update
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    if current_user.id != @item.user_id
      redirect_to root_path
    else
      if @item.destroy
        redirect_to root_path
      else
        render :show
      end
    end
  end

  def search
    redirect_to root_path if params[:q].nil?
    @results = @p.result.includes(:user)
  end

  def detailed_search
    redirect_to root_path if params[:q].nil?
    search_item_form = SearchItemForm.new(search_params)
    @p, @results = search_item_form.search
    @results = search_item_form.sort_results
    render :search
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :shipping_time_id, :price, :image, tags: { name: [] }).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  rescue StandardError
    redirect_to root_path
  end

  def set_tag_list
    @tag_list = []
    @item.tags.each do |tag|
      @tag_list << tag.name
    end
  end

  def search_item
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def search_params
    params.require(:q).permit(:name_i_cont_any, :tags_name_i_cont_any, :price_gteq, :price_lteq, item_sort: [:id], category: [:id], status: { ids: [] }, shipping_fee: { ids: [] }, sales_status: { ids: [] })
  end
end
