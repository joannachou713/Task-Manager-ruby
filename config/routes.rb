Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :labels
  
  get     'admin'  => 'users#index'
  get     'signup' => 'users#new'
  get     'login'  => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'
  
  root to: "tasks#index"

  match '/404', to: "errors#not_found", via: :all
  match '/500', to: "errors#internal_server_error", via: :all
end
