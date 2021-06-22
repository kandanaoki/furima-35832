class CardsController < ApplicationController
  def new
    @card_shipping_adress = CardShippingAdress.new
  end

  def create
    @card_shipping_adress = CardShippingAdress.new(card_params)
    if @card_shipping_adress.valid?
      @card_shipping_adress.save
      redirect_to root_path
    else
      render action: "new" # カード登録画面へリダイレクト
    end
  end

  private

  def card_params
    params.require(:card_shipping_adress).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      card_token: params[:card_token], user_id: current_user.id
    )
  end
end