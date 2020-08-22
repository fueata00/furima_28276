FactoryBot.define do
  factory :item do
    id { 1 }
    name { 'プロテイン' }
    text { '商品の説明文です' }
    category_id { 2 }
    status_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_time_id { 2 }
    price { 3000 }
    sold_out { false }
    association :user
  end
end
