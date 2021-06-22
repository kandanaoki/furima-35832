class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶ]+\z/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  with_options presence: true do
    validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date
  end

  with_options format: NAME_REGEX do
    validates :first_name, :last_name
  end

  with_options format: NAME_KANA_REGEX do
    validates :first_name_kana, :last_name_kana
  end

  validates :password, format: PASSWORD_REGEX

  has_many :items
  has_many :purchases
  has_one :shipping_adress, dependent: :destroy
  has_one :card, dependent: :destroy
end
