class PurchaseShippingAdress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :user_id, :item_id, :token, :city, :address

    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format: { with: /\A[0-9]{11}\z/ }, length: { minimum: 10, maximum: 11 }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAdress.create(prefecture_id: prefecture_id, city: city, address: address, building_name: building_name,
                          phone_number: phone_number, purchase_id: purchase.id)
  end
end
