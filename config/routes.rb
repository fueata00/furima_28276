Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, except: [:index]
  resources :item_purchases, only: [:index, :create]
end
