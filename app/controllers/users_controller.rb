class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def edit
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 環境変数を読み込む
    card = Card.find_by(user_id: current_user.id) # ユーザーのid情報を元に、カード情報を取得

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
    @shipping_adress = current_user.shipping_adress
  end
  
  def update
    if current_user.update(user_params)
      redirect_to root_path
      sign_in(current_user, :bypass => true)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date)
  end
end
