Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_shipping_address'
    post 'addresses', to: 'users/registrations#create_shipping_address'
    get 'cards', to: 'users/registrations#new_card'
    post 'cards', to: 'users/registrations#create_card'
  end

  root to: "items#index"
  resources :items do
    post 'purchase', on: :member
    resources :comments, only: :create
    collection do
      get 'search'
      get 'complex_search_item'
      get 'complex_search_tag'
    end
    member do
      get 'new_card'
      post 'create_card'
    end
  end
  resources :users, only: [:edit, :update] do
    collection do
      get 'new_card'
      post 'create_card'
    end
  end
end
