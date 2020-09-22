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
  has_many :tags, through: :item_tag_relations, dependent: :destroy

  validates :sold_out, inclusion: { in: [true, false] }
  validates :image, presence: true
end
