FactoryBot.define do
  factory :user do
    nickname { 'たろー' }
    email { 'sample@sample.com' }
    password { '123qwe' }
    password_confirmation { '123qwe' }
    first_name { '山田' }
    last_name { '太郎' }
    first_name_kana { 'ヤマダ' }
    last_name_kana { 'タロウ' }
    birthday { Date.new(2000, 1, 1) }
  end
end
