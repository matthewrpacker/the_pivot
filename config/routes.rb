Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: [:index]
  end
  root to: 'home#index'
  resources :cart_items, only: [:create, :update, :destroy]
  resources :cart, only: [:index]
  resources :items, only: [:index, :show]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/:title', to: 'categories#show', as: :category
end
