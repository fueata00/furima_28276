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
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'nicknameがすでに存在している場合保存できないこと' do
      @user.email = 'sample2@sample.com'
      @user.save
      another_user = FactoryBot.build(:user, nickname: @user.nickname)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Nickname has already been taken")
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
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailが@を含まないと保存できないこと' do
      @user.email = 'samplesample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'emailがすでに存在している場合保存できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'passwordが空だと保存できないこと' do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字未満だと保存できないこと' do
      @user.password = '123qw'
      @user.password_confirmation = '123qw'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)', 'Password is invalid')
    end
    it 'passwordが半角英数字混合でないと保存できないこと' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end
    it 'passwordが存在してもpassword_confirmationが空だと保存できないこと' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordとpassword_confirmationが一致しなければ保存できないこと' do
      @user.password_confirmation = '111aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'first_nameが空だと保存できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
    end
    it 'first_nameが全角日本語でないと保存できないこと' do
      @user.first_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end
    it 'last_nameが空だと保存できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
    end
    it 'last_nameが全角日本語でないと保存できないこと' do
      @user.last_name = 'ﾀﾛｳ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end
    it 'first_name_kanaが空だと保存できないこと' do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana is invalid')
    end
    it 'first_name_kanaが全角カタカナでないと保存できないこと' do
      @user.first_name_kana = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end
    it 'last_name_kanaが空だと保存できないこと' do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid')
    end
    it 'last_name_kanaが全角カタカナでないと保存できないこと' do
      @user.last_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid')
    end
    it 'birthdayが空だと保存できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
