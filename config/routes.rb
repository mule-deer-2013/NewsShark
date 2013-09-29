NewsShark::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show] do
    resources :channels, only: [:create, :show] do
        resources :articles, only: [:update]
    end
  end

  root to: 'users#new'

end

