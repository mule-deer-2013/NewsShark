NewsShark::Application.routes.draw do
  resources :users, except: [:index]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  
  root to: 'users#show'
end

