require 'rails_helper'

RSpec.describe PurchaseInfo, type: :model do
  describe '商品購入情報の登録' do
    before do
      @purchase_info = FactoryBot.build(:purchase_info)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@purchase_info).to be_valid
    end
    it 'クレジットカードのトークンが取得できなければ保存できないこと' do
      @purchase_info.token = nil
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include("クレジットカード情報を入力してください")
    end
    it 'postal_codeが空だと保存できないこと' do
      @purchase_info.postal_code = nil
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include("郵便番号を入力してください")
    end
    it 'postal_codeにハイフンが含まれないと保存出来ないこと' do
      @purchase_info.postal_code = '1234567'
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include('郵便番号は不正な値です')
    end
    it 'prefecture_idが1(---)だと保存出来ないこと' do
      @purchase_info.prefecture_id = 1
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include('都道府県は1以外の値にしてください')
    end
    it 'cityが空だと保存出来ないこと' do
      @purchase_info.city = nil
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include("市区町村を入力してください")
    end
    it 'addressが空だと保存出来ないこと' do
      @purchase_info.address = nil
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include("番地を入力してください")
    end
    it 'phone_numberが空だと保存出来ないこと' do
      @purchase_info.phone_number = nil
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include("電話番号を入力してください")
    end
    it 'phone_numberが9桁以下だと保存出来ないこと' do
      @purchase_info.phone_number = '111111111'
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include('電話番号は不正な値です')
    end
    it 'phone_numberが12桁以上だと保存出来ないこと' do
      @purchase_info.phone_number = '111111111111'
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include('電話番号は不正な値です')
    end
    it 'phone_numberに数字以外が含まれると保存出来ないこと' do
      @purchase_info.phone_number = '111abc1111'
      @purchase_info.valid?
      expect(@purchase_info.errors.full_messages).to include('電話番号は不正な値です')
    end
  end
end
