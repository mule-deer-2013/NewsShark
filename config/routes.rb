NewsShark::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show] do
    resources :channels, only: [:create, :show]
  end

  root to: 'users#show'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

end

