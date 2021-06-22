class CardShippingAdress
  include ActiveModel::Model
  attr_accessor :user_id, :card_token, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id, :card_token, :city, :address

    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :phone_number, format: { with: /\A[0-9]{11}\z/ }, length: { minimum: 10, maximum: 11 }
  end

  def save
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    customer = Payjp::Customer.create(
      description: 'test', # テストカードであることを説明
      card: card_token # 登録しようとしているカード情報
    )
    card = Card.create!( 
      # 顧客トークンとログインしているユーザーを紐付けるインスタンスを生成
      card_token: card_token,  #カード情報
      customer_token: customer.id, # 顧客トークン
      user_id: user_id # ログインしているユーザー
    )
    shipping_adress = ShippingAdress.create!(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name,
                          phone_number: phone_number, user_id: user_id)
  end
end
