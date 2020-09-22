Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, except: [:index] do
    resources :item_purchases, only: [:index, :create]
    collection do
      get 'search'
      get 'detailed_search'
    end
  end
  get 'tags/search', to: 'tags#search'
end
