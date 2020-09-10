class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_time
  has_one_attached :image
  belongs_to :user
  has_one :item_purchase
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

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
    validates :image
  end
  validates :sold_out, inclusion: { in: [true, false] }
end
