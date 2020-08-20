class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :item_purchase

  valid_postal_code_regex = /\A\d{3}[-]\d{4}\z/
  valid_phone_number_regex = /\A\d{10,11}\z/

  with_options presence: true do
    validates :postal_code, format: { with: valid_postal_code_regex }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: valid_phone_number_regex }
    validates :item_purchase
  end
end
