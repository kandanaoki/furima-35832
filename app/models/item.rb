class Item < ApplicationRecord
  with_options presence: true do
    validates :name, :description, :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id, :status_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  belongs_to :user
  has_one :purchase, dependent: :destroy
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
