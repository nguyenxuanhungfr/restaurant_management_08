Rails.application.routes.draw do

  root "static_pages#home"
  get "/login", to: "sessions#new"
  get "show_category", to: "static_pages#load_category"
  get "searh_autocomplete", to: "static_pages#load_dishes"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :dishes
  resources :menus
  resources :reviews
  resources :categories
  resources :reservations
  resources :tables
  namespace :admin do
    root "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :staffs
    resources :bookings
    resources :menus
    resources :categories
    resources :tables
    resources :dishes
  end
end
