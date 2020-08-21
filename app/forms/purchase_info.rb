class PurchaseInfo
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id

  valid_postal_code_regex = /\A\d{3}[-]\d{4}\z/
  valid_phone_number_regex = /\A\d{10,11}\z/

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: valid_postal_code_regex }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: valid_phone_number_regex }
  end

  def save
    item_purchase = ItemPurchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number, item_purchase_id: item_purchase.id)
  end
end
