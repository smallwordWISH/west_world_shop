Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "products#index"

  resources :products, only: [:index, :show] do
    post :add_to_cart, on: :member  
  end

  resources :cart
  
  resources :cart_items, only:[:destroy] do
    member do
      patch :plus
      patch :minus
    end
  end


  namespace :admin do
    resources :products, except: [:show]
    resources :orders, only: [:edit, :update]

    root "products#index"
  end
end
