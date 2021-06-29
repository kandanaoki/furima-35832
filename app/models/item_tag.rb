class ItemTag

  include ActiveModel::Model
  attr_accessor :name, :description, :images, :category_id, :status_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id, :price, :user_id, :tag_name, :item_id

  with_options presence: true do
    validates :name, :description, :images
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id, :status_id, :shipping_charge_id, :prefecture_id, :days_to_ship_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }


  def save
    item = Item.create(name: name, description: description, images: images, category_id: category_id, status_id: status_id, shipping_charge_id: shipping_charge_id, prefecture_id: prefecture_id, days_to_ship_id: days_to_ship_id, price: price, user_id: user_id)

    if tag_name != nil
      array_tag_name = tag_name.split(/,/)
      array_tag_name.each do |tag_name|
        tag_name.strip!
        tag = Tag.where(tag_name: tag_name).first_or_initialize
        tag.save
        ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
      end
    end
  end
  
  def update
    item = Item.find(item_id)
    item.update(name: name, description: description, images: images, category_id: category_id, status_id: status_id, shipping_charge_id: shipping_charge_id, prefecture_id: prefecture_id, days_to_ship_id: days_to_ship_id, price: price, user_id: user_id)
    item.tags.destroy_all

    if tag_name != nil
      array_tag_name = tag_name.split(/,/)
      array_tag_name.each do |tag_name|
        tag_name.strip!
        tag = Tag.where(tag_name: tag_name).first_or_initialize
        tag.save
        ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
      end
    end
  end
end