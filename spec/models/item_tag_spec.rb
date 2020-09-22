require 'rails_helper'

RSpec.describe ItemTag, type: :model do
  describe '商品情報の登録' do
    before do
      @item_tag = FactoryBot.build(:item_tag)
      @item_tag.image = fixture_file_upload('public/images/test_image.png')
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@item_tag).to be_valid
    end
    it 'imageが空だと保存できないこと' do
      @item_tag.image = nil
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('画像を入力してください')
    end
    it 'nameが空だと保存できないこと' do
      @item_tag.name = nil
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('商品名を入力してください')
    end
    it 'textが空だと保存できないこと' do
      @item_tag.text = nil
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('商品の説明を入力してください')
    end
    it 'category_idが1(---)だと保存できないこと' do
      @item_tag.category_id = 1
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('商品カテゴリーは1以外の値にしてください')
    end
    it 'status_idが1(---)だと保存できないこと' do
      @item_tag.status_id = 1
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('商品の状態は1以外の値にしてください')
    end
    it 'shipping_fee_idが1(---)だと保存できないこと' do
      @item_tag.shipping_fee_id = 1
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
    end
    it 'prefecture_idが1(---)だと保存できないこと' do
      @item_tag.prefecture_id = 1
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
    end
    it 'shipping_time_idが1(---)だと保存できないこと' do
      @item_tag.shipping_time_id = 1
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
    end
    it 'priceが空だと保存できないこと' do
      @item_tag.price = nil
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('価格を入力してください')
    end
    it 'priceが300未満だと保存できないこと' do
      @item_tag.price = 299
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('価格は300以上の値にしてください')
    end
    it 'priceが9,999,999より大きいと保存できないこと' do
      @item_tag.price = 10_000_000
      @item_tag.valid?
      expect(@item_tag.errors.full_messages).to include('価格は9999999以下の値にしてください')
    end
  end
end
