FactoryBot.define do
  factory :item do
    name { 'プロテイン' }
    text { '商品の説明文です' }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_time_id { 2 }
    price { 3000 }
    association :user
  end
end
