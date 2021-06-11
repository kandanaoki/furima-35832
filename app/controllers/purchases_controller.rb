class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :find_item, only: [:index, :create]
  before_action :move_to_index, only: [:index]

  def index
    @purchase_shipping_adress = PurchaseShippingAdress.new
    @purchase = Purchase.new
  end

  def create
    @purchase_shipping_adress = PurchaseShippingAdress.new(purchase_params)
    if @purchase_shipping_adress.valid?
      pay_item
      @purchase_shipping_adress.save
      redirect_to root_path
    else
      render action: :index

    end
  end

  private

  def purchase_params
    params.require(:purchase_shipping_adress).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if current_user == @item.user || Purchase.find_by(item_id: @item.id)
  end
end
