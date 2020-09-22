require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品情報の登録' do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    it 'imageが空だと保存できないこと' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('画像を入力してください')
    end
    it 'sold_outがtureまたはfalse以外だと保存できないこと' do
      @item.sold_out = ''
      @item.valid?
      expect(@item.errors.full_messages).to include('Sold outは一覧にありません')
    end
  end
end
