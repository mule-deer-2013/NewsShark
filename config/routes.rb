NewsShark::Application.routes.draw do

  root to: 'users#show'
  delete '/signout', to: 'sessions#destroy', as: :signout

  resources :sessions, only: [:create]

  resources :users, only: [:new, :create, :show] do
    resources :channels, only: [:create, :show, :destroy] do
        resources :articles, only: [:update]
    end
  end

  resources :articles, only: [:show]

end

# JW: only nest resources when it doesn't make sense to work with the sub-resource
#     without also having a hold of the parent resource -- is this true for channels
#     and articles?
