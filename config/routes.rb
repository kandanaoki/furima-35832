Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root to: "items#index"
  resources :items do
    post 'purchase', on: :member
  end
  resources :users, only: [:edit, :update]
  resources :cards, only: [:new, :create]
end
