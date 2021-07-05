class Card < ApplicationRecord
  validates :customer_token, presence: true
  belongs_to :user, optional: true
end
