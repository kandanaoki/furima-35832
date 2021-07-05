class Item < ApplicationRecord
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
