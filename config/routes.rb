Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  root to: "tasks#index"
  get "/sort_create", to: "tasks#sort_create"
  get "/sort_priority", to: "tasks#sort_priority"
  get "/sort_status", to: "tasks#sort_status"
end
