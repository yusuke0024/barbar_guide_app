Rails.application.routes.draw do
  get "/", to: "static_pages#home"
  resources :salons, only: [:index, :new, :create]
  resources :users, only: [:new, :create]
  resource  :sessions, only: [:new, :create]
end
