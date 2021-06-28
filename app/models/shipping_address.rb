class ShippingAddress < ApplicationRecord
  with_options presence: true do
    validates :city, :address

    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format: { with: /\A[0-9]{11}\z/ }, length: { minimum: 10, maximum: 11 }
  end

  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
