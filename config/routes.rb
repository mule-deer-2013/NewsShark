NewsShark::Application.routes.draw do
  resources :users, except: [:index]
  root to: 'users#new'
end
