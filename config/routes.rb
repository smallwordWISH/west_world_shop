Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"

  resources :products, only: [:index, :show] do
    post :add_to_cart, on: :member  
  end

  resource :cart, only: [:show]
  
  resources :cart_items, only:[:destroy] do
    member do
      patch :plus
      patch :minus
    end
  end

  resources :orders, only: [:create, :index, :destroy] do
    post :checkout_spgateway, on: :member
  end

  resources :order_items

  post 'spgateway/return'

  namespace :admin do
    resources :products, except: [:show]
    resources :orders, only: [:index, :edit, :update, :destroy]

    root "products#index"
  end
end
