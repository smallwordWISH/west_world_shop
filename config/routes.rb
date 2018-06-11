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

  resources :orders, only: [:create, :index, :destroy]

  resources :order_items


  namespace :admin do
    resources :products, except: [:show]
    resources :orders, only: [:edit, :update]

    root "products#index"
  end
end
