NewsShark::Application.routes.draw do

  resources :sessions, only: [:create]
  delete '/signout', to: 'sessions#destroy', as: :signout

  # JW: only nest resources when it doesn't make sense to work with the sub-resource
  #     without also having a hold of the parent resource -- is this true for channels
  #     and articles?
  resources :users, only: [:new, :create] do
    resources :channels, only: [:create, :show, :destroy] do
        resources :articles, only: [:update]
    end
  end
  get '/profile', to: 'users#show', as: :user

  root to: 'users#show'

end

