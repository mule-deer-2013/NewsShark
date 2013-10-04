NewsShark::Application.routes.draw do

  root to: 'users#show'
  get '/profile', to: 'users#show', as: :user
  delete '/signout', to: 'sessions#destroy', as: :signout

  resources :sessions, only: [:create]

  resources :users, only: [:new, :create, :show]

  resources :guests, only: [:create]

  resources :channels, only: [:create, :show, :destroy] do
    resources :articles, only: [:update]
  end 
  root to: 'users#show'

end
