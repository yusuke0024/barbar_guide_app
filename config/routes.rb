Rails.application.routes.draw do
  get "/", to: "static_pages#home"
  resources :salons, only: [:index, :new, :create]
end
