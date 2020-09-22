class SearchItemForm
  include ActiveModel::Model
  attr_accessor :name_i_cont_any, :tags_name_i_cont_any, :price_gteq, :price_lteq, :category, :item_sort, :status, :shipping_fee, :sales_status

  def search
    price_gteq = check_number(price_gteq)
    price_lteq = check_number(price_lteq)
    p = Item.ransack(name_i_cont_any: name_i_cont_any, tags_name_i_cont_any: tags_name_i_cont_any, price_gteq: price_gteq, price_lteq: price_lteq)
    @results = p.result
    @results = @results.where(category_id: category[:id]) if category[:id] != '1'
    @results = @results.where(status_id: status[:ids]) if status.present? && status[:ids][0] != '1'
    @results = @results.where(shipping_fee_id: shipping_fee[:ids]) if shipping_fee.present? && status[:ids][0] != '1'
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
    [p, @results]
  end

  def sort_results
    @results = @results.order(sort_params) if sort_params.present?
    @results
  end

  private

  def sort_params
    case item_sort[:id]
    when '2'
      'price ASC'
    when '3'
      'price DESC'
    when '4'
      'id ASC'
    when '5'
      'id DESC'
    end
  end

  def check_number(number)
    if number.to_i == 0
      nil
    else
      number.to_i
    end
  end
end
