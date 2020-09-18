class ItemTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :status_id, :shipping_fee_id, :prefecture_id, :shipping_time_id, :price, :user_id, :image, :tags, :item_id, :sold_out

  with_options presence: true do
    validates :name
    validates :text
    validates :category_id, numericality: { other_than: 1 }
    validates :status_id, numericality: { other_than: 1 }
    validates :shipping_fee_id, numericality: { other_than: 1 }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :shipping_time_id, numericality: { other_than: 1 }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :user_id
    validates :image, unless: -> { validation_context == :update }
  end

  def save
    item = Item.create(name: name, text: text, category_id: category_id, status_id: status_id, shipping_fee_id: shipping_fee_id, prefecture_id: prefecture_id, shipping_time_id: shipping_time_id, price: price, user_id: user_id, user_id: user_id, image: image)
    
    tags[:name].each do |n|
      tag = Tag.where(name: n).first_or_initialize
      tag.save
      ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
    end
  end

  def update
    item = Item.find(item_id)
    if image == nil
      item.update(name: name, text: text, category_id: category_id, status_id: status_id, shipping_fee_id: shipping_fee_id, prefecture_id: prefecture_id, shipping_time_id: shipping_time_id, price: price, user_id: user_id)
    else
      item.update(name: name, text: text, category_id: category_id, status_id: status_id, shipping_fee_id: shipping_fee_id, prefecture_id: prefecture_id, shipping_time_id: shipping_time_id, price: price, user_id: user_id, image: image)
    end
    
    item_tag_rel = ItemTagRelation.where(item_id: item_id)
    item_tag_rel.each do |rel|
      rel.destroy
    end

    tags[:name].each do |n|
      tag = Tag.where(name: n).first_or_initialize
      if tag.save
        ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
      end
    end
  end

end