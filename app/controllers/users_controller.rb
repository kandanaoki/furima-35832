class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def edit
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    if @card != nil
      @shipping_address = current_user.shipping_address
    else
      redirect_to action: :new_card
    end
    
  end
  
  def update
    if current_user.update(user_params)
      redirect_to root_path
      sign_in(current_user, :bypass => true)
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
      @shipping_address = current_user.shipping_address
      render :edit
    end
  end

  def new_card
    @card = Card.new
  end

  def create_card
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )

    card = Card.new( 
      customer_token: customer.id,
      user_id: current_user.id
    )
    
    unless card.valid?
      render :new_card
      return
    end

    current_user.card.update(customer_token: customer.id)

    redirect_to edit_user_path(current_user.id)
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date)
  end

  def move_to_index
    redirect_to root_path if current_user == params[:id]
  end
end
