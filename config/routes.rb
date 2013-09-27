NewsShark::Application.routes.draw do
  resources :users, only: [:new, :create, :show] do 
    resources :channels, only: [:create, :show]
  end

  root to: 'users#new'
end
