require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー情報の登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user).to be_valid
    end
    it 'nicknameが空だと保存できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('ニックネームを入力してください')
    end
    it 'nicknameがすでに存在している場合保存できないこと' do
      @user.email = 'sample2@sample.com'
      @user.save
      another_user = FactoryBot.build(:user, nickname: @user.nickname)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('ニックネームはすでに存在します')
    end
    it 'nicknameが大文字小文字を区別して保存できること' do
      @user.nickname = 'たろーabc'
      @user.email = 'sample2@sample.com'
      @user.save
      another_user = FactoryBot.build(:user, nickname: 'たろーABC')
      expect(another_user).to be_valid
    end
    it 'emailが空だと保存できないこと' do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールを入力してください')
    end
    it 'emailが@を含まないと保存できないこと' do
      @user.email = 'samplesample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'emailがすでに存在している場合保存できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, nickname: 'じろー', email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'passwordが空だと保存できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードを入力してください')
    end
    it 'passwordが6文字未満だと保存できないこと' do
      @user.password = '123qw'
      @user.password_confirmation = '123qw'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'passwordが半角英数字混合でないと保存できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは不正な値です')
    end
    it 'passwordが存在してもpassword_confirmationが空だと保存できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
    it 'passwordとpassword_confirmationが一致しなければ保存できないこと' do
      @user.password_confirmation = '111aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
    end
    it 'first_nameが空だと保存できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(性)を入力してください')
    end
    it 'first_nameが全角日本語でないと保存できないこと' do
      @user.first_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(性)は不正な値です')
    end
    it 'last_nameが空だと保存できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(名)を入力してください')
    end
    it 'last_nameが全角日本語でないと保存できないこと' do
      @user.last_name = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前(名)は不正な値です')
    end
    it 'first_name_kanaが空だと保存できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(性)を入力してください')
    end
    it 'first_name_kanaが全角カタカナでないと保存できないこと' do
      @user.first_name_kana = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(性)は不正な値です')
    end
    it 'last_name_kanaが空だと保存できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(名)を入力してください')
    end
    it 'last_name_kanaが全角カタカナでないと保存できないこと' do
      @user.last_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('お名前カナ(名)は不正な値です')
    end
    it 'birthdayが空だと保存できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include('生年月日を入力してください')
    end
  end
end
