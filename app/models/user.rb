class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :item_purchases

  valid_password_regex = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]{6,}\z/i
  valid_name_regex = /\A[ぁ-んァ-ン一-龥]/
  valid_name_kana_regex = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true }
    validates :email
    validates :password, format: { with: valid_password_regex }
    validates :first_name, format: { with: valid_name_regex }
    validates :last_name, format: { with: valid_name_regex }
    validates :first_name_kana, format: { with: valid_name_kana_regex }
    validates :last_name_kana, format: { with: valid_name_kana_regex }
    validates :birthday
  end
end
