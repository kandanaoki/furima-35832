class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.order('created_at DESC').includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :status_id, :shipping_charge_id, :prefecture_id,
                                 :days_to_ship_id, :price).merge(user_id: current_user.id)
  end
end
