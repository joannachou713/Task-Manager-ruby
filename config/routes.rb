Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  resources :users
  get 'signup' => 'users#new'
  root to: "tasks#index"
end
