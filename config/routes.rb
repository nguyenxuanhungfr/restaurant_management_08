Rails.application.routes.draw do

  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "show_category", to: "static_pages#load_category"
  get "searh_autocomplete", to: "static_pages#load_dishes"
  post "/login", to: "sessions#create"
  post "/add_to_cart/:id", to: "carts#create", as: "add_to_cart"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :dishes
  resources :orders
  resources :menus
  resources :reviews
  resources :categories
  resources :carts
  resources :reservations
  resources :tables
  namespace :admin do
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :staffs
    resources :bookings
    resources :payments
    resources :menus
    resources :bills
    resources :categories
    resources :tables
    resources :dishes
    resources :users
  end
end
