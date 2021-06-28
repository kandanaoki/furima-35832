class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def edit
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    @shipping_address = current_user.shipping_address
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

  def move_to_index
    redirect_to root_path if current_user == params[:id]
  end
end
