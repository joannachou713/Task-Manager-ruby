Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
  
  get     'admin'  => 'users#index'
  get     'signup' => 'users#new'
  get     'login'  => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'
  
  root to: "tasks#index"
end
