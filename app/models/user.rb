class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶ]+\z/.freeze
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :nickname,        presence: true
  validates :first_name,      presence: true, format: NAME_REGEX
  validates :last_name,       presence: true, format: NAME_REGEX
  validates :first_name_kana, presence: true, format: NAME_KANA_REGEX
  validates :last_name_kana,  presence: true, format: NAME_KANA_REGEX
  validates :birth_date,      presence: true
  validates :password, format: PASSWORD_REGEX

  # has_many :items
  # has_many :purchases
end
