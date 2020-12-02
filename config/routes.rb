Rails.application.routes.draw do
  root "static_pages#home"
  resources :salons, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create], controller: "salons/reviews"
  end
  resources :users, only: [:new, :create]
  resource  :sessions, only: [:new, :create, :destroy]
end
