class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :complex_search_item, :complex_search_tag]
  before_action :find_item, only: [:show, :edit, :update, :destroy, :purchase]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :self_move_to_index, only: [:purchase]
  before_action :private_complex_search_item
  before_action :private_complex_search_tag
  before_action :set_item_column
  before_action :set_tag_column


  def index
    @items = Item.order('created_at DESC').includes(:user)
  end

  def new
    @item = ItemTag.new
  end

  def create
    @item = ItemTag.new(item_params)
    if @item.valid?
      @item.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.order('created_at ASC').includes(:user)
    @tags = @item.tags
  end

  def edit
    tags = @item.tags
    tag_names = []
    tags.each do |tag|
      tag_names.push(tag.tag_name)
    end
    tag_names_joined = tag_names.join(', ')
    @item_tag = ItemTag.new(name: @item.name, description: @item.description, images: @item.images, category_id:@item.category_id, status_id:@item.status_id, shipping_charge_id: @item.shipping_charge_id, prefecture_id:@item.prefecture_id, days_to_ship_id: @item.days_to_ship_id, price: @item.price, user_id: @item.user_id, tag_name: tag_names_joined)
  end

  def update
    @item_tag = ItemTag.new(item_params_update)
    if @item_tag.valid?
      @item_tag.update
      return redirect_to root_path
    else
      render "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def purchase
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
    if @card != nil
      Payjp::Charge.create(
        amount: @item.price,
        customer: customer_token,
        currency: 'jpy'
      )
      Purchase.create(user_id: current_user.id , item_id: params[:id])
      redirect_to root_path
    else
      redirect_to action: :new_card
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
    redirect_to action: :show, id: params[:id]
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def complex_search_item
    @results = @q.result
  end

  def complex_search_tag
    @results = @t.result
  end


  private

  def item_params
    params.require(:item_tag).permit(:tag_name, :name, :description, :category_id, :status_id, :shipping_charge_id, :prefecture_id,
                                 :days_to_ship_id, :price, images: []).merge(user_id: current_user.id)
  end

  def item_params_update
    params.require(:item_tag).permit(:tag_name, :name, :description, :category_id, :status_id, :shipping_charge_id, :prefecture_id,
                                 :days_to_ship_id, :price, images: []).merge(user_id: current_user.id, item_id: @item.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user != @item.user || @item.purchase.present?
  end

  def self_move_to_index
    redirect_to root_path if current_user == @item.user || @item.purchase.present?
  end

  def private_complex_search_item
    @q = Item.ransack(params[:q])
  end

  def private_complex_search_tag
    @t = Tag.ransack(params[:q])
  end

  def set_item_column
    @item_name = Item.select("name").distinct.order('name ASC')
  end

  def set_tag_column
    @tag_name = Tag.select("tag_name").distinct.order('tag_name ASC')
  end
end
