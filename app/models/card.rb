class Card < ApplicationRecord
  belongs_to :user
  attr_accessor :card_token
end
