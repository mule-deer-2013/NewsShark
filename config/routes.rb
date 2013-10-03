NewsShark::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show]

  resources :channels, only: [:create, :show, :destroy] do
    resources :articles, only: [:update]
  end 
  root to: 'users#show'

end
