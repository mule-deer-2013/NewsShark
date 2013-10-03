NewsShark::Application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  resources :users, only: [:new, :create, :show] do
    resources :channels, only: [:create, :show, :destroy] do
        resources :articles, only: [:update]
    end
  end
 
  root to: 'users#show'


  resources :guests, :path => "users" do
    resources :channels, only: [:create, :show, :destroy] do
      resources :articles, only: [:update]
    end
  end
  resources :members, :path => "users" do
    resources :channels, only: [:create, :show, :destroy] do
      resources :articles, only: [:update]
    end
  end
end
