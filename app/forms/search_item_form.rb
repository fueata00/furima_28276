class SearchItemForm
  include ActiveModel::Model
  attr_accessor :name_i_cont_any, :tags_name_i_cont_any, :price_gteq, :price_lteq, :category, :item_sort, :status, :shipping_fee, :sales_status

  def search
    p = Item.ransack(name_i_cont_any: name_i_cont_any, tags_name_i_cont_any: tags_name_i_cont_any, price_gteq: price_gteq, price_lteq: price_lteq)
    @results = p.result
    @results = @results.where(category_id: category[:id]) if category[:id] != '1'
    if status.present? && status[:ids][0] != '1'
      @results = @results.where(status_id: status[:ids])
    end
    if shipping_fee.present? && status[:ids][0] != '1'
      @results = @results.where(shipping_fee_id: shipping_fee[:ids])
    end
    if sales_status.present? && sales_status[:ids][0] != '1'
      count = 1
      sales_status[:ids].each do |s|
        if s == '2'
          sales_status[:ids][count] = false
        elsif s == '3'
          sales_status[:ids][count] = true
        end
      end
      @results = results.where(sold_out: sales_status[:ids])
    end
    return p, @results
  end

  def sort_results
    @results = @results.order(sort_params) if sort_params.present?
    return @results
  end

  private
  
  def sort_params
    case item_sort[:id]
    when '2'
      return "price ASC"
    when '3'
      return "price DESC"
    when '4'
      return "id ASC"
    when '5'
      return "id DESC"
    else
      return nil
    end
  end

end