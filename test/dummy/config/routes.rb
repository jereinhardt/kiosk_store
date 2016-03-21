Rails.application.routes.draw do

  mount Kiosk::Engine => "/kiosk"

  get "product/:id", to: 'products#show', as: 'product'
  post "product/:id", to: 'products#buy', as: 'buy'

  root to: "products#index"

  match 'cart', to: "orders#index", as: 'cart', via: [:get, :patch]
  match 'checkout', to: 'orders#checkout', as: 'checkout', via: [:get, :post]
  match 'shipping_method', to: 'orders#shipping', as: 'shipping_method', via: [:get, :patch]
  match 'checkout/pay', to: 'orders#payment', as: 'payment', via: [:get, :post]
  match 'checkout/confirm', to: 'orders#confirmation', as: 'confirmation', via: [:get, :post]
  match 'checkout/charge', to: 'orders#charge', as: 'charge', via: [:get, :post]
  match 'checkout/thanks', to: 'orders#thanks', as: 'thanks', via: [:get]

end
