class Item < ApplicationRecord
  # with_options presence: true do
  #   validates :name, :description, :images
  # end

  # with_options numericality: { other_than: 1 } do
  #   validates :category_id, :status_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id
  # end

  # validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  belongs_to :user
  has_one :purchase
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :days_to_ship
end
