FactoryBot.define do
  factory :purchase_info do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '札幌市' }
    address { '札幌123' }
    phone_number { '00012345678' }
    token { 'abcdef' }
    user_id { 1 }
    item_id { 1 }
  end
end
