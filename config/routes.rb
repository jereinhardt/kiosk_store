Kiosk::Engine.routes.draw do
  resources :admin_users
  resources :tests
  resources :product_categories
  resources :shipping_addresses
  resources :billing_addresses
  resources :tax_rates
  resources :shipping_methods
  resources :products
  resources :order_items
  resources :orders do
    member do 
      get :shipped
    end
  end
  resources :customers
  resources :addresses
  resources :sessions

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'orders#index'
end
